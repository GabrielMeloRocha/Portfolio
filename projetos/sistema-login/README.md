# Sistema de login Django

Projeto de estudo com cadastro, confirmação de cadastro por e-mail, login, logout, páginas protegidas e recuperação de senha por e-mail.

## Requisitos

- Python 3.12 ou superior
- Gmail com verificação em duas etapas e uma senha de app para enviar e-mails

## Instalação no Windows (PowerShell)

No terminal, dentro da pasta do projeto:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
Copy-Item .env.example .env
```

Abra o arquivo `.env` e preencha `EMAIL_HOST_USER` com o Gmail remetente e `EMAIL_HOST_PASSWORD` com a senha de app desse mesmo Gmail. Não compartilhe nem publique esse arquivo.

Gere uma chave secreta para `DJANGO_SECRET_KEY` com este comando e coloque o resultado apenas no `.env`:

```powershell
python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
```

## Preparar e iniciar

```powershell
python manage.py migrate
python manage.py runserver
```

Abra <http://127.0.0.1:8000/login/>. Para criar uma conta, use um endereço de e-mail que você possa acessar e confirme o cadastro pelo link recebido.

## Segurança

- O arquivo `.env` contém credenciais e não deve ser enviado ao GitHub.
- O `.env.example` contém somente valores de exemplo; substitua-os apenas no `.env` local.
- O banco local `db.sqlite3` e a pasta do ambiente virtual também são ignorados pelo Git.
- As configurações deste README são para desenvolvimento local. Não publique um site com `DEBUG=True`.
