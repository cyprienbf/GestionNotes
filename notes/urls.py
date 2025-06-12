from django.urls import path
from .views import NoteListView, NoteDetailView, NoteCreateView, NoteUpdateView, NoteDeleteView

app_name = 'notes'

urlpatterns = [
    path('', NoteListView.as_view(), name='note_list'),
    path('<int:pk>/', NoteDetailView.as_view(), name='note_detail'),
    path('ajouter/', NoteCreateView.as_view(), name='note_create'),
    path('<int:pk>/modifier/', NoteUpdateView.as_view(), name='note_update'),
    path('<int:pk>/supprimer/', NoteDeleteView.as_view(), name='note_delete'),
]