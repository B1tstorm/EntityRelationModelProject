function putContent() {
    event.preventDefault();
    let inputs = document.querySelectorAll("input");
    console.log(inputs);
    inputs.forEach(function (element) {
        let id = element.getAttribute("id");
        let editField = document.getElementById(id);
        editField.value = "jonas";
    })

    /*    let vorname = document.getElementById("inputVorname")
        vorname.value = "Jonas";
        let nachname = document.getElementById("inputNachname")
        nachname.value = "Becker";
        let email = document.getElementById("inputEmail")
        email.value = "jb@google.de";*/
}