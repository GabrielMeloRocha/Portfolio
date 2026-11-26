from django.shortcuts import render, redirect
from django.contrib.auth import get_user_model
from django.contrib.auth.password_validation import validate_password
from django.contrib.auth import authenticate, login
from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib.auth import logout
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth import views as auth_views
from django.contrib.auth.tokens import default_token_generator
from django.core.mail import send_mail
from smtplib import SMTPException
from django.urls import reverse
from django.utils.encoding import force_bytes, force_str
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode

User = get_user_model()

# Create your views here.
def login_view(request):

    if request.method == 'POST':

        email = request.POST.get('email', '').strip().lower()
        senha = request.POST.get('senha', '')

        usuario = authenticate(
            request,
            username=email,
            password=senha
        )

        if usuario is not None:
            login(request, usuario)
            if request.POST.get('lembre_se') == 'on':
                request.session.set_expiry(14 * 24 * 60 * 60)
            else:
                request.session.set_expiry(0)
            return redirect('boasvindas')

        return render(request, 'login.html', {
            'erro': 'Usuário ou senha incorretos.'
        })
    
    return render(request, 'login.html')

@login_required(login_url='login')
def boasvindas_view(request):
    return render(request, 'boasvindas.html')

def cadastro_view(request):
    return render(request, 'cadastro.html')

def cadastrofeito_view(request):

    if request.method == 'POST':

        print("FORMULÁRIO RECEBIDO!")

        nome = request.POST.get('nome_completo', '').strip()

        email = request.POST.get('email', '').strip().lower()

        senha = request.POST.get('senha', '')

        confirmar = request.POST.get('confirmar_senha', '')

        termos = request.POST.get('termos')

        if not nome or not email or not senha or not confirmar:

            return render(request, 'cadastro.html', {
                'erro': 'Preencha todos os campos.'
                
                })

        if senha != confirmar:
            return render(request, 'cadastro.html', {
                'erro': 'As senhas não coincidem.'
            })

        if termos != 'aceito':
            return render (request, 'cadastro.html', {
                'erro': 'Aceite os termos para continuar.'
            })

        if User.objects.filter(username=email).exists():

            return render(request, 'cadastro.html', {
                'erro': 'Este usuário já existe.'
            })

        try:
            validate_password(senha)
        except ValidationError as erro:
            return render(request, 'cadastro.html', {
                'erro': erro.messages
            })

        usuario = User.objects.create_user(
            username=email,
            email=email,
            first_name=nome,
            password=senha,
            is_active=False
        )

        uid = urlsafe_base64_encode(force_bytes(usuario.pk))
        token = default_token_generator.make_token(usuario)
        link_confirmacao = request.build_absolute_uri(
            reverse('cadastro_confirmar', kwargs={'uidb64': uid, 'token': token})
        )

        try:
            send_mail(
                subject='Confirme seu cadastro',
                message=(
                    f'Olá, {nome}!\n\n'
                    'Para confirmar seu cadastro, abra este link:\n'
                    f'{link_confirmacao}\n\n'
                    'Se você não fez este cadastro, ignore esta mensagem.'
                ),
                from_email=None,
                recipient_list=[email],
                fail_silently=False,
            )
        except (SMTPException, OSError):
            usuario.delete()
            return render(request, 'cadastro.html', {
                'erro': 'Não foi possível enviar o e-mail de confirmação. Confira a configuração do e-mail e tente novamente.'
            })

        return redirect('cadastrofeito')
    
    return render(request, 'cadastrofeito.html')

def senha1_view(request):
    return render(request, 'senha.html')

def senha2_view(request):
    return render(request, 'senha2.html')

def senhaalt_view(request):
    return render(request, 'senhaalt.html')

def cadastro_confirmar_view(request, uidb64, token):
    confirmado = False
    try:
        uid = force_str(urlsafe_base64_decode(uidb64))
        usuario = User.objects.get(pk=uid)
    except (TypeError, ValueError, OverflowError, User.DoesNotExist):
        usuario = None

    if usuario is not None and not usuario.is_active and default_token_generator.check_token(usuario, token):
        usuario.is_active = True
        usuario.save(update_fields=['is_active'])
        confirmado = True

    return render(request, 'cadastro_confirmar.html', {'confirmado': confirmado})

def logout_view(request):
    logout(request)
    return redirect('login')
