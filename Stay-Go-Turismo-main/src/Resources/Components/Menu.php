<div id="MenuBox" class="BColor2">
    <div class="MenuIcon" onclick="MenuIconClosing()" id="MenuDesign">
        <div></div>
        <div></div>
        <div></div>
    </div>
    <div id="LinksLayout">
        <div class="LinkEdit Color1 Text_1-6em" id="inicio" onclick="MenuLinkRoute('inicio')">Início</div>
        <div class="LinkEdit Color1 Text_1-6em" id="sobre" onclick="MenuLinkRoute('sobre')">Sobre</div>
        <div class="LinkEdit Color1 Text_1-6em" id="referencias" onclick="MenuLinkRoute('referencias')">Referencias</div>
        <div class="LinkEdit Color1 Text_1-6em" id="contato" onclick="MenuLinkRoute('contato')">Contato</div>
    </div>
    <div style="width:100%;text-align:center;margin-top:24px;">
        <button id="toggleThemeBtn" class="BColor3 Color1" style="padding:10px 24px;border-radius:8px;border:none;cursor:pointer;font-size:1em;">Alternar Tema</button>
    </div>
</div>

<style>
    *{
        margin: 0;
    }
    .MenuIcon {
        display: flex;
        flex-direction: column;
        gap: 6px;
        cursor: pointer;
        margin-left: 0px;
        transform: translate(0px, 4px);
    }
    .MenuIcon div {
        width: 32px;
        height: 4px;
        transition: 0.3s;
        border-radius: 6px;
        box-shadow: 0 1px 4px rgba(0,0,0,0.12);
    }
    #MenuBox {
        position: fixed;
        transform: translate(0%,-50%);
        z-index: 20;
        top: 50%;
        left: -100%;
        border-radius: 24px;
        border-bottom-left-radius: 0px;
        border-top-left-radius: 0px;
        padding: 32px 18px 32px 18px;
        width: 320px;
        height: 95vh;
        box-shadow: 0 8px 32px rgba(0,0,0,0.18);
        transition: left 0.7s cubic-bezier(.77,0,.18,1);
        background: var(--menu-bg, inherit);
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        animation: menuFadeIn 0.7s;
    }
    @keyframes menuFadeIn {
        from { opacity: 0; transform: translate(-30px, -50%); }
        to { opacity: 1; transform: translate(0%, -50%); }
    }
    #LinksLayout {
        width: 100%;
        margin-left: 0;
        display: flex;
        flex-direction: column;
        gap: 18px;
        margin-top: 24px;
    }
    .LinkEdit {
        padding: 12px 18px;
        border-radius: 12px;
        text-decoration: none;
        font-weight: 500;
        letter-spacing: 0.5px;
        transition: background 0.3s, color 0.3s, box-shadow 0.3s;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        background: var(--menu-link-bg, rgba(255,255,255,0.7));
    }
    .LinkEdit:hover {
        background: var(--menu-link-hover-bg, #e0e7ff);
        color: var(--menu-link-hover-color, #4e54c8);
        box-shadow: 0 6px 24px rgba(78,84,200,0.12);
        filter: brightness(1.08);
        cursor: pointer;
    }
    #MenuDesign {
        margin: 10px 0 0 0;
        transform: translate(0px);
    }
    @media screen and (max-width: 500px) {
        #MenuBox {
            position: fixed;
            transform: translate(-50%,-50%);
            z-index: 20;
            top: 50%;
            left: -50%;
            border-radius: 0px;
            padding: 16px 0 16px 0;
            width: 100vw;
            height: 100vh;
            transition: left 0.7s cubic-bezier(.77,0,.18,1);
        }
        #LinksLayout {
            margin-top: 16px;
            gap: 12px;
        }
    }
</style>
<script>
window.addEventListener('DOMContentLoaded', function() {
    var links = document.querySelectorAll('.LinkEdit');
    links.forEach(function(link) {
        addEventWithZoom(link, 'click', function(e) {
            // Mantém o comportamento original
        });
    });
    var btn = document.getElementById('toggleThemeBtn');
    if(btn) {
        btn.addEventListener('click', function() {
            // Faz requisição para controller e recarrega a página
            fetch('/darkmode/set?toggle=1').then(function() {
                location.reload();
            });
        });
    }
});
</script>