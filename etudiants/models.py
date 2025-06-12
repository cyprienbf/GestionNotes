from django.db import models
from ues.models import UE
from ressources.models import Ressource

class Etudiant(models.Model):
    numero_etudiant = models.CharField(max_length=20, unique=True, verbose_name="N° étudiant")
    nom = models.CharField(max_length=100)
    prenom = models.CharField(max_length=100)
    groupe = models.CharField(max_length=50, blank=True)
    photo = models.ImageField(upload_to='photos_etudiants/', null=True, blank=True)
    email = models.EmailField(unique=True)

    def __str__(self):
        return f"{self.prenom} {self.nom} ({self.numero_etudiant})"

    def calculer_moyenne_ressource(self, ressource):
        """Calcule la moyenne pondérée pour une ressource donnée."""
        notes_etudiant = self.notes.filter(examen__ressource=ressource)
        total_notes_ponderees = 0
        total_coeffs = 0

        if not notes_etudiant.exists():
            return None

        for note in notes_etudiant:
            total_notes_ponderees += note.note * note.examen.coefficient
            total_coeffs += note.examen.coefficient
        
        return total_notes_ponderees / total_coeffs if total_coeffs > 0 else None

    def calculer_moyenne_ue(self, ue):
        """Calcule la moyenne pondérée pour une UE, basée sur les moyennes des ressources."""
        ressources_de_l_ue = ue.ressources.all()
        total_moyennes_ponderees = 0
        total_coeffs = 0

        if not ressources_de_l_ue.exists():
            return None

        for ressource in ressources_de_l_ue:
            moyenne_ressource = self.calculer_moyenne_ressource(ressource)
            if moyenne_ressource is not None:
                total_moyennes_ponderees += moyenne_ressource * ressource.coefficient
                total_coeffs += ressource.coefficient
        
        return total_moyennes_ponderees / total_coeffs if total_coeffs > 0 else None

    @property
    def moyenne_generale(self):
        """Calcule la moyenne générale pondérée par les crédits ECTS des UE."""
        ues_avec_notes = UE.objects.filter(ressources__examens__notes__etudiant=self).distinct()
        total_moyennes_ponderees = 0
        total_credits_ects = 0

        if not ues_avec_notes.exists():
            return None

        for ue in ues_avec_notes:
            moyenne_ue = self.calculer_moyenne_ue(ue)
            if moyenne_ue is not None:
                total_moyennes_ponderees += moyenne_ue * ue.credits_ects
                total_credits_ects += ue.credits_ects
        
        return total_moyennes_ponderees / total_credits_ects if total_credits_ects > 0 else None

    class Meta:
        verbose_name = "Étudiant"
        verbose_name_plural = "Étudiants"