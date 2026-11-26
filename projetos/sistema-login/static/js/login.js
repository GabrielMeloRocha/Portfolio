const formulario = document.querySelector("form");
const mensagem = document.getElementById("mensagem");

if (formulario) {

    formulario.addEventListener("submit", function(event) {

        mensagem.textContent = "";

        console.log("Enviando formulário para o Django...");

    });

}