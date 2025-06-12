from django.urls import path
from .views import (
    UEListView,
    UEDetailView,
    UECreateView,
    UEUpdateView,
    UEDeleteView,
)

app_name = 'ues'

urlpatterns = [
    path('', UEListView.as_view(), name='ue_list'),
    path('<int:pk>/', UEDetailView.as_view(), name='ue_detail'),
    path('ajouter/', UECreateView.as_view(), name='ue_create'),
    path('<int:pk>/modifier/', UEUpdateView.as_view(), name='ue_update'),
    path('<int:pk>/supprimer/', UEDeleteView.as_view(), name='ue_delete'),
]