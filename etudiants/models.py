from django.db import models

class Etudiant(models.Model):
    numero_etudiant = models.CharField(max_length=20, unique=True, verbose_name="N° étudiant")
    nom = models.CharField(max_length=100)
    prenom = models.CharField(max_length=100)
    groupe = models.CharField(max_length=50, blank=True)
    photo = models.ImageField(upload_to='photos_etudiants/', null=True, blank=True)
    email = models.EmailField(unique=True)

    def __str__(self):
        return f"{self.prenom} {self.nom} ({self.numero_etudiant})"

    class Meta:
        verbose_name = "Étudiant"
        verbose_name_plural = "Étudiants"