/* BUTTONS */

const github = document.querySelector('.github')
github.onclick = function () {
    window.open('https://www.github.com/badruxx/', "_blank")
}

const linkedin = document.querySelector('.linkedin')
linkedin.onclick = function () {
    window.open("https://www.linkedin.com/in/hyan-jan-suamina-856271298/", '_blank')
}

const email = document.querySelector('.email')
email.onclick = function () {
    window.location = "mailto:hyanjansuamina@gmail.com"
}