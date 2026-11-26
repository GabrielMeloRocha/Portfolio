const form =
document.querySelector('form');
const mensg =
document.getElementById('mensg');


const senhaNov =
document.getElementById('senhaNov');
const senhaConfi =
document.getElementById('senhaConfi');


form.addEventListener("submit", function(event) {
    event.preventDefault();

    if (senhaNov.value === "" || senhaConfi === "") {
        mensg.textContent = "Preencha Todos os Campos"
    } else if (senhaNov.value != senhaConfi.value) {
        mensg.textContent = "As senhas não são iguais.";
    }
    else {
        window.location.href = "senhaalt.html";
    }
});