from django.urls import reverse_lazy
from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
from .models import UE

class UEListView(ListView):
    model = UE
    template_name = 'ues/ue_list.html'
    context_object_name = 'ues'

class UEDetailView(DetailView):
    model = UE
    template_name = 'ues/ue_detail.html'

class UECreateView(CreateView):
    model = UE
    template_name = 'ues/ue_form.html'
    fields = ['code', 'nom', 'semestre', 'credits_ects']
    success_url = reverse_lazy('ues:ue_list')

class UEUpdateView(UpdateView):
    model = UE
    template_name = 'ues/ue_form.html'
    fields = ['code', 'nom', 'semestre', 'credits_ects']
    success_url = reverse_lazy('ues:ue_list')

class UEDeleteView(DeleteView):
    model = UE
    template_name = 'ues/ue_confirm_delete.html'
    success_url = reverse_lazy('ues:ue_list')