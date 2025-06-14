from django.urls import path
from .views import ExamenListView, ExamenDetailView, ExamenCreateView, ExamenUpdateView, ExamenDeleteView, SaisieNotesCSVView

app_name = 'examens'

urlpatterns = [
    path('', ExamenListView.as_view(), name='examen_list'),
    path('<int:pk>/', ExamenDetailView.as_view(), name='examen_detail'),
    path('ajouter/', ExamenCreateView.as_view(), name='examen_create'),
    path('<int:pk>/modifier/', ExamenUpdateView.as_view(), name='examen_update'),
    path('<int:pk>/supprimer/', ExamenDeleteView.as_view(), name='examen_delete'),
    path('<int:pk>/saisir-notes-csv/', SaisieNotesCSVView.as_view(), name='saisir_notes_csv'),
]