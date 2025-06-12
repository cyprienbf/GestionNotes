from django.shortcuts import render

def home_view(request):
    """
    Vue pour la page d'accueil.
    """
    # Pour l'instant, on se contente d'afficher un template simple.
    # Plus tard, on pourra y ajouter des statistiques (nombre d'étudiants, etc.)
    return render(request, 'home.html')