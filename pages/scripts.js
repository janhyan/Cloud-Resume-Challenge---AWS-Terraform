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

const kaway = document.querySelector('.kaway-github')
kaway.onclick = function () {
    window.open("https://github.com/janhyan/KawayFSL", '_blank')
}

const resume = document.querySelector('.resume-github')
resume.onclick = function () {
    window.open("https://github.com/janhyan/Cloud-Resume-Challenge---AWS-Terraform", '_blank')
}

function toggleMobileMenu(menu) {
    menu.classList.toggle('open');
}

/* VISITOR COUNTER */

const apiUrl = 'https://airtk17j7h.execute-api.ap-northeast-1.amazonaws.com/dev'
const visitorCounter = document.querySelector('.counter')




fetch(apiUrl)
    .then(Response => {
        if (!Response.ok) {
            throw new Error('Network response was not okay.')
        }
        return Response.json();
    })
    .then(data => {
        visitorCounter.innerHTML = data.count;
    })
    .catch(error => {
        console.error('Error:', error);
    });

// Typing Animation
var typed = new Typed('#intro-text-description', {
    strings: ['Cloud Engineering', 'DevOps', 'Cybersecurity', 'PCB Design', 'Radio Comms'],
    typeSpeed: 100,
    backSpeed: 50,
    loop: true,
    autoInsertCss: true,

})