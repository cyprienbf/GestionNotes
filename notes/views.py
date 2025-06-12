from django.urls import reverse_lazy
from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
from .models import Note

class NoteListView(ListView):
    model = Note
    template_name = 'notes/note_list.html'
    context_object_name = 'notes'

class NoteDetailView(DetailView):
    model = Note
    template_name = 'notes/note_detail.html'

class NoteCreateView(CreateView):
    model = Note
    fields = ['examen', 'etudiant', 'note', 'appreciation']
    template_name = 'notes/note_form.html'
    success_url = reverse_lazy('notes:note_list')

class NoteUpdateView(UpdateView):
    model = Note
    fields = ['examen', 'etudiant', 'note', 'appreciation']
    template_name = 'notes/note_form.html'
    success_url = reverse_lazy('notes:note_list')

class NoteDeleteView(DeleteView):
    model = Note
    template_name = 'notes/note_confirm_delete.html'
    success_url = reverse_lazy('notes:note_list')