var ScreenSize = false;
var MenuOpen = false;
var Menu, Heade, BlackScreen;
var ScreenScrollCheck = 0;
const TamanhoMin = 950;

// Variáveis de medidas para movimentação do menu
const MENU_WIDTH_DESKTOP = '300px';
const MENU_WIDTH_MOBILE = '110vw';
const MENU_LEFT_OPEN_DESKTOP = '0';
const MENU_LEFT_CLOSED_DESKTOP = '-100%';
const MENU_LEFT_OPEN_MOBILE = '0';
const MENU_LEFT_CLOSED_MOBILE = '-100vw';

function BlackScreenShow(){
    if (!BlackScreen) BlackScreen = document.getElementById("BlackScreen");
    BlackScreen.style.opacity = "0.4";
    BlackScreen.style.visibility = "visible";
}
function BlackScreenHide(){
    if (!BlackScreen) BlackScreen = document.getElementById("BlackScreen");
    BlackScreen.style.opacity = "0";
    BlackScreen.style.visibility = "hidden";
}
function MenuOpening(){
    if(window.innerWidth < TamanhoMin){
        Menu.style.left = MENU_LEFT_OPEN_MOBILE;
    } else {
        Menu.style.left = MENU_LEFT_OPEN_DESKTOP;
    }
    MenuOpen = true;
}
function MenuClosing(){
    if(window.innerWidth < TamanhoMin){
        Menu.style.left = MENU_LEFT_CLOSED_MOBILE;
    } else {
        Menu.style.left = MENU_LEFT_CLOSED_DESKTOP;
    }
    MenuOpen = false;
}
function HeaderShow(){
    if (!Heade) Heade = document.getElementById("Heade");
    Heade.style.transform = "translate(0px, -100px)";
}
function HeaderHide(){
    if (!Heade) Heade = document.getElementById("Heade");
    Heade.style.transform = "translate(0px, 0px)";
}
function MenuIconOpening(){
    if (!Menu) Menu = document.getElementById("MenuBox");
    MenuOpening();
    BlackScreenShow();
    HeaderShow();
    localStorage.setItem("MenuAberto", true);
}
function MenuIconClosing(){
    if (!Menu) Menu = document.getElementById("MenuBox");
    MenuClosing();
    BlackScreenHide();
    HeaderHide();
    localStorage.setItem("MenuAberto", false);
}
window.addEventListener('DOMContentLoaded', function() {
    Menu = document.getElementById("MenuBox");
    Heade = document.getElementById("Heade");
    BlackScreen = document.getElementById("BlackScreen");
    var Status = localStorage.getItem("MenuAberto");
    var ScrollCheck = localStorage.getItem("ScrollSet");
    if(window.innerWidth < TamanhoMin){
        Menu.style.width = MENU_WIDTH_MOBILE;
        if(MenuOpen == true){
            Menu.style.left = MENU_LEFT_OPEN_MOBILE;
            ScreenSize = true;
        }
        else{
            Menu.style.left = MENU_LEFT_CLOSED_MOBILE;
            ScreenSize = true;
        }
    }
    else{
        Menu.style.width = MENU_WIDTH_DESKTOP;
        if(MenuOpen == true){
            Menu.style.left = MENU_LEFT_OPEN_DESKTOP;
            ScreenSize = false;
        }
        else{
            Menu.style.left = MENU_LEFT_CLOSED_DESKTOP;
            ScreenSize = false;
        }
    }
    if(Status == 'true'){
        MenuIconOpening();
    }
    window.screenY = ScrollCheck;
});
function Reset(){
    localStorage.setItem("MenuAberto", false)
    localStorage.setItem("ScrollCheck", null)
}

// Função global de zoom para divs
function ativarZoomDiv(div) {
    if (!div) return;
    div.classList.add('zoom-ativo');
    setTimeout(() => {
        div.classList.remove('zoom-ativo');
    }, 800); // tempo do efeito
}

// Função utilitária: sempre que adicionar um evento a uma div, ativa o zoom
function addEventWithZoom(div, event, handler) {
    if (!div) return;
    div.addEventListener(event, function(e) {
        ativarZoomDiv(div);
        if (typeof handler === 'function') handler(e);
    });
}