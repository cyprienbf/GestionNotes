from django.urls import reverse_lazy
from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
from .models import Enseignant

class EnseignantListView(ListView):
    model = Enseignant
    template_name = 'enseignants/enseignant_list.html'
    context_object_name = 'enseignants'

class EnseignantDetailView(DetailView):
    model = Enseignant
    template_name = 'enseignants/enseignant_detail.html'

class EnseignantCreateView(CreateView):
    model = Enseignant
    fields = ['nom', 'prenom'] 
    template_name = 'enseignants/enseignant_form.html'
    success_url = reverse_lazy('enseignants:enseignant_list')

class EnseignantUpdateView(UpdateView):
    model = Enseignant
    fields = ['nom', 'prenom']
    template_name = 'enseignants/enseignant_form.html'
    success_url = reverse_lazy('enseignants:enseignant_list')

class EnseignantDeleteView(DeleteView):
    model = Enseignant
    template_name = 'enseignants/enseignant_confirm_delete.html'
    success_url = reverse_lazy('enseignants:enseignant_list')
