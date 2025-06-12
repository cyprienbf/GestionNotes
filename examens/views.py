from django.urls import reverse_lazy
from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
from .models import Examen

class ExamenListView(ListView):
    model = Examen
    template_name = 'examens/examen_list.html'
    context_object_name = 'examens'

class ExamenDetailView(DetailView):
    model = Examen
    template_name = 'examens/examen_detail.html'

class ExamenCreateView(CreateView):
    model = Examen
    fields = ['titre', 'date', 'coefficient', 'ressource', 'enseignant']
    template_name = 'examens/examen_form.html'
    success_url = reverse_lazy('examens:examen_list')

class ExamenUpdateView(UpdateView):
    model = Examen
    fields = ['titre', 'date', 'coefficient', 'ressource', 'enseignant']
    template_name = 'examens/examen_form.html'
    success_url = reverse_lazy('examens:examen_list')

class ExamenDeleteView(DeleteView):
    model = Examen
    template_name = 'examens/examen_confirm_delete.html'
    success_url = reverse_lazy('examens:examen_list')