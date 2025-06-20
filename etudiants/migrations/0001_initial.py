# Generated by Django 5.2.3 on 2025-06-14 10:15

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Etudiant',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('numero_etudiant', models.CharField(max_length=20, unique=True, verbose_name='N° étudiant')),
                ('nom', models.CharField(max_length=100)),
                ('prenom', models.CharField(max_length=100)),
                ('groupe', models.CharField(blank=True, max_length=50)),
                ('photo', models.ImageField(blank=True, null=True, upload_to='photos_etudiants/')),
                ('email', models.EmailField(max_length=254, unique=True)),
            ],
            options={
                'verbose_name': 'Étudiant',
                'verbose_name_plural': 'Étudiants',
            },
        ),
    ]
