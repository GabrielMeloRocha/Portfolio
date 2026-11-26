const form =
document.querySelector('form');
const nomUser = 
document.getElementById('nomUser')
const erroMensagem =
document.getElementById('erroMensagem');

form.addEventListener("submit", function(event) {

    const emailDigitado =
    nomUser.value.trim();

    if (emailDigitado === '') {
        event.preventDefault();
        erroMensagem.textContent = 'Por favor, digite o seu e-mail cadastrado.'
    } else if (!nomUser.checkVisibility()) {
        event.preventDefault();
        erroMensagem.textContent = 'Por favor, digite o seu e-mail válido.'
    } else {
        window.location.href = "senha2.html";
    }
});