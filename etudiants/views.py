from django.urls import reverse_lazy
from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
from .models import Etudiant
from ues.models import UE

class EtudiantListView(ListView):
    model = Etudiant
    template_name = 'etudiants/etudiant_list.html'
    context_object_name = 'etudiants'

    def get_queryset(self):
        queryset = super().get_queryset()
        sort_by = self.request.GET.get('sort')

        if sort_by == 'moyenne':
            # On ne peut pas trier directement via SQL, donc on trie en Python
            # On met -1 pour les étudiants sans note pour les placer à la fin.
            etudiants_tries = sorted(
                queryset, 
                key=lambda e: e.moyenne_generale if e.moyenne_generale is not None else -1, 
                reverse=True
            )
            return etudiants_tries
        
        return queryset.order_by('nom', 'prenom')


class EtudiantDetailView(DetailView):
    model = Etudiant
    template_name = 'etudiants/etudiant_detail.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        etudiant = self.get_object()
        
        # --- Calcul des classements ---
        # C'est une opération potentiellement lourde. A optimiser si la performance devient un problème.
        tous_les_etudiants = Etudiant.objects.all()

        # Classement général
        moyennes_generales = sorted(
            [(e, e.moyenne_generale) for e in tous_les_etudiants if e.moyenne_generale is not None],
            key=lambda item: item[1],
            reverse=True
        )
        try:
            rang_general = [i for i, (e, m) in enumerate(moyennes_generales) if e == etudiant][0] + 1
            context['classement_general'] = f"{rang_general} / {len(moyennes_generales)}"
        except IndexError:
            context['classement_general'] = "Non classé"

        # Structure pour stocker tous les résultats
        resultats_par_ue = []
        ues_a_traiter = UE.objects.filter(ressources__examens__notes__etudiant=etudiant).distinct()

        for ue in ues_a_traiter:
            # Classement par UE
            moyennes_ue = sorted(
                [(e, e.calculer_moyenne_ue(ue)) for e in tous_les_etudiants if e.calculer_moyenne_ue(ue) is not None],
                key=lambda item: item[1],
                reverse=True
            )
            try:
                rang_ue = [i for i, (e, m) in enumerate(moyennes_ue) if e == etudiant][0] + 1
                classement_ue_str = f"{rang_ue} / {len(moyennes_ue)}"
            except IndexError:
                classement_ue_str = "Non classé"

            ue_data = {
                'ue': ue,
                'moyenne': etudiant.calculer_moyenne_ue(ue),
                'classement': classement_ue_str,
                'ressources': []
            }
            
            for ressource in ue.ressources.filter(examens__notes__etudiant=etudiant).distinct():
                # Classement par ressource
                moyennes_ressource = sorted(
                    [(e, e.calculer_moyenne_ressource(ressource)) for e in tous_les_etudiants if e.calculer_moyenne_ressource(ressource) is not None],
                    key=lambda item: item[1],
                    reverse=True
                )
                try:
                    rang_ressource = [i for i, (e, m) in enumerate(moyennes_ressource) if e == etudiant][0] + 1
                    classement_ressource_str = f"{rang_ressource} / {len(moyennes_ressource)}"
                except IndexError:
                    classement_ressource_str = "Non classé"

                ressource_data = {
                    'ressource': ressource,
                    'moyenne': etudiant.calculer_moyenne_ressource(ressource),
                    'classement': classement_ressource_str,
                    'notes': etudiant.notes.filter(examen__ressource=ressource).order_by('examen__date')
                }
                ue_data['ressources'].append(ressource_data)
            
            resultats_par_ue.append(ue_data)
            
        context['resultats_par_ue'] = resultats_par_ue
        return context

# Les vues Create, Update, Delete ne changent pas
class EtudiantCreateView(CreateView):
    model = Etudiant
    template_name = 'etudiants/etudiant_form.html'
    fields = ['numero_etudiant', 'nom', 'prenom', 'groupe', 'photo', 'email']
    success_url = reverse_lazy('etudiants:etudiant_list')

class EtudiantUpdateView(UpdateView):
    model = Etudiant
    template_name = 'etudiants/etudiant_form.html'
    fields = ['numero_etudiant', 'nom', 'prenom', 'groupe', 'photo', 'email']
    success_url = reverse_lazy('etudiants:etudiant_list')

class EtudiantDeleteView(DeleteView):
    model = Etudiant
    template_name = 'etudiants/etudiant_confirm_delete.html'
    success_url = reverse_lazy('etudiants:etudiant_list')