<nav id="Heade" class="BColor3">
    <div id="IconsEdit">
        <div class="MenuIcon" onclick="MenuIconOpening()">
            <div></div>
            <div></div>
            <div></div>
        </div>
        <div class="logo Text_1-5em">MinhaLogo</div>
    </div>
    <div class="RoutesAlign Color2 Text_1-5em">
        <div class="RoutesAlign" id="RoutesAlign">
            <a class="Text_0-6em" href="/">Home</a>
            <a class="Text_0-6em" href="/comofunciona">Como Funciona</a>
            <a class="Text_0-6em" href="/quemsomos">Quem Somos</a>
            <a class="Text_0-6em" href="/citacoes">Citações</a>
            <a class="Text_0-6em" href="/feedback">Contato</a>
        </div>
    </div>
    <div class="menu-toggle" onclick="toggleMenu()">
        <img src="../../Web/Imagens/Seta.png" id="MenuIconDesign" alt="">
    </div>
    <div class="RoutesAlign-box Color2 Text_1-5em" id="mobileMenu">
        <div id="RoutesAlign">
            <div><a class="Text_1-5em" href="/">Home</a></div>
            <div><a class="Text_1-5em" href="/comofunciona">Como Funciona</a></div>
            <div><a class="Text_1-5em" href="/quemsomos">Quem Somos</a></div>
            <div><a class="Text_1-5em" href="/citacoes">Citações</a></div>
            <div><a class="Text_1-5em" href="/feedback">Contato</a></div>
        </div>
    </div>
</nav>

<style>
    *{
        margin: 0;
    }
    .MenuIcon{
        display: flex;
        flex-direction: column;
        gap: 5px;
        cursor: pointer;
        margin-left: 0px;
        transform: translate(0px, 3px);
    }
    .MenuIcon div{
        width: 30px;
        height: 4px;
        <?php if(isset($DarkMode) && $DarkMode == true): ?>
            background: yellow;
        <?php else: ?>
            background: white;
        <?php endif ?>
        transition: 0.3s;
        border-radius: 5px;
    }
    nav{
        width: calc(100% - 60px);
        height: 50px;
        padding: 15px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: relative;
        box-shadow: 0 2px 8px rgba(0,0,0,0.2);
        transition: transform 0.4s ease-in-out;
    }
    .logo{
        font-weight: bold;
        margin-left: 50px;
    }
    .RoutesAlign{
        display: flex;
        gap: 20px;
    }
    .RoutesAlign a{
        text-decoration: none;
        font-weight: 500;
        position: relative;
        <?php if(isset($DarkMode) && $DarkMode == true): ?>
            color: yellow;
        <?php else: ?>
            color: white;
        <?php endif ?>
    }
    .RoutesAlign a::after{
        content: "";
        position: absolute;
        width: 0%;
        height: 2px;
        <?php if(isset($DarkMode) && $DarkMode == true): ?>
            background: yellow;
        <?php else: ?>
            background: white;
        <?php endif ?>
        left: 0;
        bottom: -5px;
        transition: 0.3s;
    }
    .RoutesAlign a:hover::after{
        width: 100%;
    }
    .menu-toggle{
        display: none;
        flex-direction: column;
        gap: 5px;
        cursor: pointer;
    }
    .menu-toggle div{
        width: 25px;
        height: 3px;
        <?php if(isset($DarkMode) && $DarkMode == true): ?>
            background: yellow;
        <?php else: ?>
            background: white;
        <?php endif ?>
        transition: 0.3s;
    }
    #IconsEdit{
        display: flex;
    }
    #MenuIconDesign{
        width: 40px;
        height: 30px;
        transform: translate(0px, 4px);
    }

    /* MENU MOBILE */
    .RoutesAlign-box{
        display: none;
        flex-direction: column;
        position: absolute;
        top: 70px;
        right: 30px;
        <?php if(isset($DarkMode) && $DarkMode == true): ?>
            background: rgb(50,50,50);
        <?php else: ?>
            background: white;
        <?php endif ?>
        border-radius: 10px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        padding: 20px;
        z-index: 1000;
        animation: slideDown 0.3s ease-in-out;
    }
    .RoutesAlign-box a{
        padding: 10px 0;
        <?php if(isset($DarkMode) && $DarkMode == true): ?>
            color: yellow;
        <?php else: ?>
            color: #333;
        <?php endif ?>
        text-decoration: none;
        <?php if(isset($DarkMode) && $DarkMode == true): ?>
            border-bottom: 1px solid yellow;
        <?php else: ?>
            border-bottom: 1px solid #ddd;
        <?php endif ?>
        transition: 0.2s;
    }
    .RoutesAlign-box a:last-child{
        border-bottom: none;
    }
    .RoutesAlign-box a:hover{
        <?php if(isset($DarkMode) && $DarkMode == true): ?>
            color: white;
        <?php else: ?>
            color: #4e54c8;
        <?php endif ?>
    }

    @keyframes slideDown{
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* RESPONSIVO */

    @media (max-width: 800px){
        .RoutesAlign {
            display: none;
        }
        .menu-toggle {
            display: flex;
        }
    }
</style>

<script>
    const menuBox = document.getElementById("mobileMenu");

    function toggleMenu() {
        menuBox.style.display = (menuBox.style.display === "flex") ? "none" : "flex";
    }
    window.addEventListener("resize", () => {
        if (window.innerWidth > 800) {
        menuBox.style.display = "none";
        }
    });
</script>