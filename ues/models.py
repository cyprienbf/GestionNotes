from django.db import models

class UE(models.Model):
    code = models.CharField(max_length=20, unique=True, verbose_name="Code UE")
    nom = models.CharField(max_length=200)
    semestre = models.PositiveIntegerField()
    credits_ects = models.PositiveIntegerField(verbose_name="Crédits ECTS")

    def __str__(self):
        return f"{self.code} - {self.nom}"

    class Meta:
        verbose_name = "Unité d'Enseignement"
        verbose_name_plural = "Unités d'Enseignement"
        ordering = ['semestre', 'code']