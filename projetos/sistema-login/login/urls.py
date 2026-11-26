"""
URL configuration for sistema_login project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/6.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.contrib.auth import views as auth_views
from django.urls import path
from login import views

urlpatterns = [
    path('login/', views.login_view, name='login'),
    path('boasvindas/', views.boasvindas_view, name='boasvindas'),
    path('cadastro/', views.cadastro_view, name='cadastro'),
    path('cadastrofeito/', views.cadastrofeito_view, name='cadastrofeito'),
    path(
        'cadastro/confirmar/<uidb64>/<token>/',
        views.cadastro_confirmar_view,
        name='cadastro_confirmar'
    ),
    path(
    'senha/',
    auth_views.PasswordResetView.as_view(
        template_name='senha.html',
        email_template_name='registration/password_reset_email.html',
        subject_template_name='registration/password_reset_subject.txt',
        success_url='/senha2/'
    ),
    name='senha'
),

path(
    'senha2/',
    auth_views.PasswordResetDoneView.as_view(
        template_name='senha_enviada.html'
    ),
    name='senha2'
),

path(
    'senha/<uidb64>/<token>/',
    auth_views.PasswordResetConfirmView.as_view(
        template_name='senha2.html',
        success_url='/senhaalt/'
    ),
    name='password_reset_confirm'
),

path(
    'senhaalt/',
    auth_views.PasswordResetCompleteView.as_view(
        template_name='senhaalt.html'
    ),
    name='senhaalt'
),

    path('logout/', views.logout_view, name='logout'),
]
