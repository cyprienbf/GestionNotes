from django.db import models
from ressources.models import Ressource
from enseignants.models import Enseignant

class Examen(models.Model):
    titre = models.CharField(max_length=200)
    date = models.DateField()
    coefficient = models.FloatField(default=1.0)
    ressource = models.ForeignKey(Ressource, on_delete=models.CASCADE, related_name='examens')
    enseignant = models.ForeignKey(Enseignant, on_delete=models.SET_NULL, null=True, blank=True, related_name='examens')

    def __str__(self):
        return f"{self.titre} ({self.ressource.nom})"

    class Meta:
        verbose_name = "Examen"
        verbose_name_plural = "Examens"
        ordering = ['-date', 'ressource']