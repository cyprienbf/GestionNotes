from django.urls import reverse_lazy
from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
from .models import Ressource

class RessourceListView(ListView):
    model = Ressource
    template_name = 'ressources/ressource_list.html'
    context_object_name = 'ressources'

class RessourceDetailView(DetailView):
    model = Ressource
    template_name = 'ressources/ressource_detail.html'

class RessourceCreateView(CreateView):
    model = Ressource
    template_name = 'ressources/ressource_form.html'
    fields = ['ue', 'code', 'nom', 'descriptif', 'coefficient']
    success_url = reverse_lazy('ressources:ressource_list')

class RessourceUpdateView(UpdateView):
    model = Ressource
    template_name = 'ressources/ressource_form.html'
    fields = ['ue', 'code', 'nom', 'descriptif', 'coefficient']
    success_url = reverse_lazy('ressources:ressource_list')

class RessourceDeleteView(DeleteView):
    model = Ressource
    template_name = 'ressources/ressource_confirm_delete.html'
    success_url = reverse_lazy('ressources:ressource_list')