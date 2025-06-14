import csv
import io
from django.shortcuts import render, redirect, get_object_or_404
from django.views import View
from django.contrib import messages
from .models import Examen
from etudiants.models import Etudiant
from notes.models import Note
from notes.forms import NoteUploadForm
from django.urls import reverse_lazy
from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
from .models import Examen

class ExamenListView(ListView):
    model = Examen
    template_name = 'examens/examen_list.html'
    context_object_name = 'examens'

class ExamenDetailView(DetailView):
    model = Examen
    template_name = 'examens/examen_detail.html'

class ExamenCreateView(CreateView):
    model = Examen
    fields = ['titre', 'date', 'coefficient', 'ressource', 'enseignant']
    template_name = 'examens/examen_form.html'
    success_url = reverse_lazy('examens:examen_list')

class ExamenUpdateView(UpdateView):
    model = Examen
    fields = ['titre', 'date', 'coefficient', 'ressource', 'enseignant']
    template_name = 'examens/examen_form.html'
    success_url = reverse_lazy('examens:examen_list')

class ExamenDeleteView(DeleteView):
    model = Examen
    template_name = 'examens/examen_confirm_delete.html'
    success_url = reverse_lazy('examens:examen_list')

class SaisieNotesCSVView(View):
    template_name = 'examens/saisir_notes_csv.html'

    def get(self, request, pk):
        examen = get_object_or_404(Examen, pk=pk)
        form = NoteUploadForm()
        context = {
            'form': form,
            'examen': examen
        }
        return render(request, self.template_name, context)

    def post(self, request, pk):
        examen = get_object_or_404(Examen, pk=pk)
        form = NoteUploadForm(request.POST, request.FILES)
        
        if form.is_valid():
            csv_file = request.FILES['csv_file']
            
            # Vérifier que c'est un fichier CSV
            if not csv_file.name.endswith('.csv'):
                messages.error(request, 'Erreur : Le fichier doit être au format .csv')
                return redirect('examens:saisir_notes_csv', pk=examen.pk)

            # Lire le contenu du fichier
            # Utiliser 'utf-8-sig' pour gérer le BOM (Byte Order Mark) que certains éditeurs (comme Excel) ajoutent
            try:
                decoded_file = csv_file.read().decode('utf-8-sig')
                io_string = io.StringIO(decoded_file)
                reader = csv.reader(io_string, delimiter=';')
                
                # Sauter l'en-tête
                next(reader)

                notes_creees = 0
                notes_mises_a_jour = 0
                erreurs = []
                ligne_num = 1 # On a déjà lu l'en-tête

                for row in reader:
                    ligne_num += 1
                    try:
                        if len(row) < 2:
                            erreurs.append(f"Ligne {ligne_num}: Ligne malformée ou vide.")
                            continue

                        num_etudiant = row[0].strip()
                        note_str = row[1].strip().replace(',', '.') # Remplacer la virgule par un point
                        appreciation = row[2].strip() if len(row) > 2 else ""

                        # Validation des données
                        etudiant = Etudiant.objects.get(numero_etudiant=num_etudiant)
                        note_val = float(note_str)

                        if not 0 <= note_val <= 20:
                            raise ValueError("La note doit être entre 0 et 20.")

                        # Créer ou mettre à jour la note
                        note_obj, created = Note.objects.update_or_create(
                            examen=examen,
                            etudiant=etudiant,
                            defaults={'note': note_val, 'appreciation': appreciation}
                        )
                        
                        if created:
                            notes_creees += 1
                        else:
                            notes_mises_a_jour += 1

                    except Etudiant.DoesNotExist:
                        erreurs.append(f"Ligne {ligne_num}: L'étudiant avec le numéro '{num_etudiant}' n'existe pas.")
                    except ValueError as e:
                        erreurs.append(f"Ligne {ligne_num}: Donnée de note invalide ('{note_str}'). {e}")
                    except IndexError:
                        erreurs.append(f"Ligne {ligne_num}: Ligne incomplète. Assurez-vous d'avoir au moins 2 colonnes.")
                    except Exception as e:
                        erreurs.append(f"Ligne {ligne_num}: Une erreur inattendue est survenue : {e}")

                # Afficher le résumé
                if notes_creees > 0:
                    messages.success(request, f"{notes_creees} note(s) créée(s) avec succès.")
                if notes_mises_a_jour > 0:
                    messages.info(request, f"{notes_mises_a_jour} note(s) mise(s) à jour avec succès.")
                for erreur in erreurs:
                    messages.error(request, erreur)
            
            except Exception as e:
                 messages.error(request, f"Erreur lors de la lecture du fichier : {e}")

        return redirect('examens:saisir_notes_csv', pk=examen.pk)
