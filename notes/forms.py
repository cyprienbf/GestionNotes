from django import forms

class NoteUploadForm(forms.Form):
    csv_file = forms.FileField(
        label="Sélectionnez le fichier CSV",
        help_text="Le fichier doit être au format CSV avec un point-virgule (;) comme séparateur."
    )