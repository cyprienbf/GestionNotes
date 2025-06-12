from django.db import models
from examens.models import Examen
from etudiants.models import Etudiant

class Note(models.Model):
    examen = models.ForeignKey(Examen, on_delete=models.CASCADE, related_name='notes')
    etudiant = models.ForeignKey(Etudiant, on_delete=models.CASCADE, related_name='notes')
    note = models.FloatField(verbose_name="Note sur 20")
    appreciation = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"Note de {self.etudiant.prenom} {self.etudiant.nom} à l'examen {self.examen.titre}: {self.note}/20"

    class Meta:
        verbose_name = "Note"
        verbose_name_plural = "Notes"
        # Contrainte pour s'assurer qu'un étudiant n'a qu'une seule note par examen
        unique_together = ('examen', 'etudiant')
        ordering = ['examen', 'etudiant__nom']