from django.urls import path
from .views import (
    RessourceListView,
    RessourceDetailView,
    RessourceCreateView,
    RessourceUpdateView,
    RessourceDeleteView,
)

app_name = 'ressources'

urlpatterns = [
    path('', RessourceListView.as_view(), name='ressource_list'),
    path('<int:pk>/', RessourceDetailView.as_view(), name='ressource_detail'),
    path('ajouter/', RessourceCreateView.as_view(), name='ressource_create'),
    path('<int:pk>/modifier/', RessourceUpdateView.as_view(), name='ressource_update'),
    path('<int:pk>/supprimer/', RessourceDeleteView.as_view(), name='ressource_delete'),
]