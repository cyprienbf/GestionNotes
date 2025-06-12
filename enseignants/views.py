from django.urls import reverse_lazy
from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
from django.contrib.auth.models import User
from .models import Enseignant

class EnseignantListView(ListView):
    model = Enseignant
    template_name = 'enseignants/enseignant_list.html'
    context_object_name = 'enseignants'

class EnseignantDetailView(DetailView):
    model = Enseignant
    template_name = 'enseignants/enseignant_detail.html'

# Note: Une vue de création plus robuste gérerait la création de l'objet User associé.
# Pour l'instant, nous supposons que le User est créé via l'admin ou un autre process.
# Ceci est une simplification pour ce CRUD. La version complète nécessiterait un formulaire personnalisé.
# Nous allons donc créer un formulaire simple qui demande de sélectionner un User existant.
class EnseignantCreateView(CreateView):
    model = Enseignant
    fields = ['user'] # On sélectionne un User existant non lié
    template_name = 'enseignants/enseignant_form.html'
    success_url = reverse_lazy('enseignants:enseignant_list')

    def get_form(self, form_class=None):
        form = super().get_form(form_class)
        # On filtre pour n'afficher que les utilisateurs qui ne sont pas déjà des enseignants
        linked_users_pk = Enseignant.objects.all().values_list('user__pk', flat=True)
        form.fields['user'].queryset = User.objects.exclude(pk__in=linked_users_pk)
        return form

class EnseignantUpdateView(UpdateView):
    model = Enseignant
    fields = ['user']
    template_name = 'enseignants/enseignant_form.html'
    success_url = reverse_lazy('enseignants:enseignant_list')

class EnseignantDeleteView(DeleteView):
    model = Enseignant
    template_name = 'enseignants/enseignant_confirm_delete.html'
    success_url = reverse_lazy('enseignants:enseignant_list')

    # Il faut aussi supprimer le User associé pour ne pas le laisser "orphelin"
    def form_valid(self, form):
        user = self.get_object().user
        response = super().form_valid(form)
        user.delete()
        return response