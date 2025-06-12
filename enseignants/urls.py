from django.urls import path
from .views import (
    EnseignantListView,
    EnseignantDetailView,
    EnseignantCreateView,
    EnseignantUpdateView,
    EnseignantDeleteView
)

app_name = 'enseignants'

urlpatterns = [
    path('', EnseignantListView.as_view(), name='enseignant_list'),
    path('<int:pk>/', EnseignantDetailView.as_view(), name='enseignant_detail'),
    path('ajouter/', EnseignantCreateView.as_view(), name='enseignant_create'),
    path('<int:pk>/modifier/', EnseignantUpdateView.as_view(), name='enseignant_update'),
    path('<int:pk>/supprimer/', EnseignantDeleteView.as_view(), name='enseignant_delete'),
]