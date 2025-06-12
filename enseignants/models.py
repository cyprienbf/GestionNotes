from django.db import models
from django.contrib.auth.models import User

# On étend le modèle User de Django avec un profil Enseignant
class Enseignant(models.Model):
    # Relation un-à-un avec le User. Si le User est supprimé, le profil Enseignant aussi.
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    # nom et prenom sont déjà dans le modèle User, mais on peut les redoubler ici si on veut
    # ou simplement utiliser user.first_name et user.last_name
    
    def __str__(self):
        # Utilise le prénom et le nom du modèle User associé
        return f"{self.user.first_name} {self.user.last_name}"

    class Meta:
        verbose_name = "Enseignant"
        verbose_name_plural = "Enseignants"