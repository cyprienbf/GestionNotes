from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static
from .views import home_view

urlpatterns = [
    path('', home_view, name='home'),
    path('admin/', admin.site.urls),
    path('etudiants/', include('etudiants.urls')),
    path('ues/', include('ues.urls')),
    path('ressources/', include('ressources.urls')),
    path('enseignants/', include('enseignants.urls')),
    path('examens/', include('examens.urls')),
    path('notes/', include('notes.urls')),
]

# Servir les fichiers media en mode DEBUG
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)