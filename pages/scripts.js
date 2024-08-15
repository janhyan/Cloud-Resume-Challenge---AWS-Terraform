/* BUTTONS */

const github = document.querySelector('.github')
github.onclick = function () {
    window.open('https://www.github.com/janhyan/', "_blank")
}

const linkedin = document.querySelector('.linkedin')
linkedin.onclick = function () {
    window.open("https://www.linkedin.com/in/hyan-jan-suamina-856271298/", '_blank')
}

const email = document.querySelector('.email')
email.onclick = function () {
    window.location = "mailto:hyanjansuamina@gmail.com"
}

/* VISITOR COUNTER */

const apiUrl = ''
const visitorCounter = document.querySelector('.counter')



visitorCounter.innerHTML = '20';

fetch(apiUrl)
    .then(Response => {
        if (!Response.ok) {
            throw new Error('Network response was not okay.')
        }
        return Response.json();
    })
    .then(data => {
        console.log(data);
    })
    .catch(error => {
        console.error('Error:', error);
    });