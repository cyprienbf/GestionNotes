from django.urls import path
from .views import (
    EtudiantListView,
    EtudiantDetailView,
    EtudiantCreateView,
    EtudiantUpdateView,
    EtudiantDeleteView,
)

app_name = 'etudiants'

urlpatterns = [
    path('', EtudiantListView.as_view(), name='etudiant_list'),
    path('<int:pk>/', EtudiantDetailView.as_view(), name='etudiant_detail'),
    path('ajouter/', EtudiantCreateView.as_view(), name='etudiant_create'),
    path('<int:pk>/modifier/', EtudiantUpdateView.as_view(), name='etudiant_update'),
    path('<int:pk>/supprimer/', EtudiantDeleteView.as_view(), name='etudiant_delete'),
]