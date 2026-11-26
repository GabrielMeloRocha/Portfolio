const form = document.querySelector('form');
const mensg = document.getElementById('mensg');

const nomeComp = document.getElementById('nomeComp');
const user = document.getElementById('user');
const novaSenha = document.getElementById('novaSenha');
const confSenha = document.getElementById('confSenha');
const terms = document.getElementById('terms');

form.addEventListener("submit", function(event) {

    console.log("BOTÃO CADASTRAR FOI ACIONADO!");

    if (
        nomeComp.value.trim() === "" ||
        user.value.trim() === "" ||
        novaSenha.value === "" ||
        confSenha.value === ""
    ) {
        event.preventDefault();
        mensg.textContent = 'Preencha todos os campos.';
        console.log("ERRO: Campos vazios.");
    }
    else if (novaSenha.value !== confSenha.value) {
        event.preventDefault();
        mensg.textContent = "As senhas não são iguais.";
        console.log("ERRO: Senhas diferentes.");
    }
    else if (!terms.checked) {
        event.preventDefault();
        mensg.textContent = "Aceite os termos e condições.";
        console.log("ERRO: Termos não aceitos.");
    }
    else {
        console.log("VALIDAÇÕES CONCLUÍDAS. ENVIO LIBERADO.");
    }

});