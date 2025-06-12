from django.db import models
from ues.models import UE  # Importer le modèle UE

class Ressource(models.Model):
    # Relation avec une UE. Si l'UE est supprimée, la ressource aussi (CASCADE)
    ue = models.ForeignKey(UE, on_delete=models.CASCADE, related_name='ressources')
    code = models.CharField(max_length=20, unique=True, verbose_name="Code Ressource")
    nom = models.CharField(max_length=200)
    descriptif = models.TextField(blank=True)
    coefficient = models.FloatField()

    def __str__(self):
        return f"{self.code} - {self.nom}"

    class Meta:
        verbose_name = "Ressource"
        verbose_name_plural = "Ressources"
        ordering = ['ue', 'code']