<!DOCTYPE html>
<HTML>
<HEAD>
    <TITLE>Microsoft Azure App Service - Welcome</TITLE>
    <SCRIPT type="text/javascript">
        function loc() {
            var browserLanguage = (navigator.language) ? navigator.language : navigator.userLanguage;
            var t, h, p;
            switch (browserLanguage.toLowerCase()) {
                case "en-us":
                    t = "Azure App Service - Welcome";
                    h = "Your App Service app is up and running";
                    p = "Go to your app's quick start guide in the Azure portal to get started or read our deployment documentation.";
                    break;
                case "de-de":
                    t = "Azure App Service – Willkommen";
                    h = "Die Website wurde erfolgreich erstellt.";
                    p = "Es wurde noch nichts erstellt, aber Websites vereinfachen die Veröffentlichung von Inhalten mit GIT, FTP oder Ihrem bevorzugten Entwicklungstool.";
                    break;
                case "es-es":
                    t = "Azure App Service - Inicio";
                    h = "Esta app de App Service se ha creado correctamente";
                    p = "Actualmente no hay contenido, pero Microsoft Azure App Service facilita la publicación de contenido con GIT, FTP o su herramienta de desarrollo preferida.";
                    break;
                case "fr-fr":
                    t = "Azure App Service - Bienvenue";
                    h = "Ce site Web a été correctement créé";
                    p = "Il n'y a rien ici encore, mais Sites Web facilite la publication de contenu avec GIT, FTP ou votre outil de développement favori.";
                    break;
                case "it-it":
                    t = "Azure App Service - Pagina introduttiva";
                    h = "Il sito Web è stato creato correttamente";
                    p = "Non vi è ancora alcun elemento, tuttavia tramite i siti Web è possibile pubblicare facilmente i contenuti tramite GIT, FTP o lo strumento di sviluppo preferito.";
                    break;
                case "ja-jp":
                    t = "Web サイト - ようこそ";
                    h = "この Web サイトは正常に作成されました";
                    p = "ここにはまだ何もありませんが、Web サイトを使用すると GIT、FTP、またはその他の開発ツールでコンテンツを容易に公開できます。";
                    break;
                case "ko-kr":
                    t = "웹 사이트 - 시작";
                    h = "이 웹 사이트가 생성되었습니다.";
                    p = "아직 여기에 아무 것도 없지만 GIT, FTP 또는 선호하는 개발 도구를 사용하여 웹 사이트로 콘텐츠를 간단하게 게시할 수 있습니다.";
                    break;
                case "pt-br":
                    t = "Azure App Service - Bem-vindo";
                    h = "Este site foi criado com sucesso";
                    p = "Ainda não há nada aqui, mas os sites facilitam a publicação de conteúdo com GIT, FTP ou outra ferramenta de desenvolvimento favorita.";
                    break;
                case "ru-ru":
                    t = "Веб-сайты ― добро пожаловать";
                    h = "Этот веб-сайт успешно созда";
                    p = "Пока здесь ничего нет, но с помощью веб-сайтов вы можете легко публиковать содержимое посредством GIT, FTP или другого средства разработки, которое вы предпочитаете.";
                    break;
                case "tr-tr":
                    t = "Azure App Service Hoşgeldiniz";
                    h = "Web sitesi başarıyla oluşturuldu";
                    p = "Burada henüz yayınlanmış içerik bulunmamaktadır, ama Windows Azure App Service sayesinde GIT, FTP veya en sevdiğiniz geliştirme aracını kullanarak kolayca içerik yayınlayabilirsiniz.";
                    break;
                case "zh-hans":
                    t = "网站 - 欢迎";
                    h = "已成功创建此网站";
                    p = "这里现在不包含任何内容，但是在网站上使用 GIT、FTP 或您喜爱的开发工具可以轻松发布内容。";
                    break;
                case "zh-hant":
                    t = "網站 - 歡迎使用";
                    h = "已成功建立這個網站";
                    p = "尚無內容，但網站讓您輕鬆地使用 GIT、FTP 或最愛的開發工具發佈內容。";
                    break;
                default: t = "Azure App Service - Welcome";
                    h = "This web app has been successfully created";
                    p = "There is nothing here yet, but Azure App Service makes it simple to publish content with GIT, FTP or your favorite development tool.";
            }

            document.title = t;
            document.getElementById("bodyHeadline").innerHTML = h;
            document.getElementById("bodyContent").innerHTML = p;
        }
    </SCRIPT>
    <STYLE type="text/css">
        @font-face {
            font-family: SegoeLight;
            src: url(//:) format("no404"), url(/fonts/segoe-ui-light-latest.woff2);
            font-weight: normal;
            font-style: normal;
        }

        body {
            margin: 0px;
            padding: 0px;
            color: rgb(255, 255, 255);
            overflow: hidden;
            font-family: "SegoeLight",helvetica,sans-serif;
            font-size: 2.7vmin;
            background-color: rgb(0, 120, 215);
        }

        .content {
            position: absolute;
            left: 3.8vw;
            top: 5.5vh;
            height: 30vh;
        }

            .content .azureLogo {
                height: 2.7vmin;
                width: 2.7vmin;
                position: relative;
                top: 0.3vmin;
            }

            .content .azureBrand {
                margin: 0 0 6.5vh .2vh;
                font-family: 'Segoe UI', helvetica, sans-serif;
                font-size: 2.7vmin;
            }

            .content .bodyHeadline {
                margin: 3.5vh 0 1vh 0;
                font-size: 5.1vmin;
            }

            .content .bodyContent {
                margin: 1.5vh 0 3.5vh 0;
                font-family: 'Segoe UI', helvetica, sans-serif;
                font-size: 2.7vmin;
            }

                .content .bodyContent a {
                    color: #fff;
                    text-decoration: underline;
                }

                    .content .bodyContent a:hover {
                        opacity: .7;
                    }

        .bottomContent {
            left: 3.8vw;
            top: 30vh;
            height: 68vh;
            position: absolute;
            max-width: 860px;
        }

        tr {
            font-size: 1.9vmin;
        }

        td {
            white-space: nowrap;
        }

        .link {
            width: 1.9vmin;
        }

        table {
            border-spacing: 1.1vmin;
        }

        .tableHeader {
            font-family: "Segoe UI",helvetica,sans-serif !important;
            font-size: 2.7vmin !important;
        }

        .bottomContent .bodyContent {
            margin: 1vmin 0px 0px;
            font-family: "Segoe UI",helvetica,sans-serif;
            font-size: 2.7vmin;
        }

            .bottomContent .bodyContent a {
                color: rgb(255, 255, 255);
                text-decoration: underline;
            }

                .bottomContent .bodyContent a:hover {
                    opacity: 0.7;
                }

        .content .bodyCTA:hover {
            opacity: 0.7;
        }

        .characterCount {
            font-size: 1.7vmin;
        }

        .search-button {
            padding: 1.5vmin 0px 0px 1.5vmin;
            border: currentColor;
            border-image: none;
            top: 0px;
            width: 5.1vmin;
            height: 5.1vmin;
            right: -5.1vmin;
            position: absolute;
            cursor: pointer;
            align-content: center;
            background-repeat: no-repeat;
            background-color: rgb(0, 21, 128);
        }

        .submit-button {
            border: currentColor;
            border-image: none;
            width: 15vmin;
            height: 6.5vmin;
            color: rgb(255, 255, 255);
            font-family: SegoeLight;
            font-size: 3vmin;
            margin-top: 2vmin;
            cursor: pointer;
            background-color: rgb(0, 21, 128);
        }

        .text-input {
            padding: 0px 4% 0px 2%;
            border: currentColor;
            border-image: none;
            width: 94%;
            height: 6.6vmin;
            color: rgb(80, 80, 80);
            line-height: 1.2em;
            font-size: 4.6vmin;
            float: right;
            background-color: rgb(255, 255, 255);
        }

        .textarea-input {
            padding: 0px 4% 0px 2%;
            border: currentColor;
            border-image: none;
            width: 94%;
            height: 20vmin;
            color: rgb(80, 80, 80);
            line-height: 1.2em;
            font-size: 2.6vmin;
            float: right;
            background-color: rgb(255, 255, 255);
        }

        .wa-textSearch {
            width: 65vmin;
            margin-top: 3vmin;
            display: block;
            position: relative;
            box-sizing: inherit;
        }

        .search {
            margin: 0px;
            padding: 0px;
            border: currentColor;
            border-image: none;
            width: auto;
            display: block;
        }

        .svg-flip-horizontal {
            transform: scaleX(-1);
        }

        .svg-white {
            color: rgb(255, 255, 255);
            fill: white;
            stroke: white;
        }

        .wrapper {
            width: 100%;
            height: 100%;
            overflow: hidden;
            min-width: 1200px;
        }

        .innerwrapper {
            width: 384px;
            height: 100%;
            margin-right: auto;
            margin-left: 72vw;
        }

        .cloudSvg {
            height: 75vh;
            margin-top: 5vh;
            min-height: 400px;
        }

        .treesSvg {
            height: 10vh;
            margin-left: 10vw;
            z-index: -1;
        }

        @media screen and (max-width:768px) and (min-width:0px) {
            .innerwrapper {
                display: none;
            }
        }

        .browser {
            top: 400px;
            width: 384px;
            height: 305px;
            display: block;
            position: absolute;
            z-index: 10;
            cursor: pointer;
        }

            .browser div {
                left: 100px;
                top: 40px;
                width: 384px;
                height: 305px;
                text-align: left;
                font-size: 200px;
                position: absolute;
                -ms-user-select: none;
                -webkit-touch-callout: none;
                -webkit-user-select: none;
                -khtml-user-select: none;
                -moz-user-select: none;
                user-select: none;
            }

        .bulb {
            top: 0px;
            margin-left: 20px;
            position: fixed;
        }

        .light {
            top: 0px;
            margin-left: 53px;
            position: fixed;
            opacity: 0;
        }

        .bottom {
            height: 10vh;
            bottom: 0px;
            margin-right: auto;
            margin-left: 23vw;
            position: fixed;
            z-index: -1;
        }
    </STYLE>
</HEAD>
<BODY onload="loc();">
    <DIV class="wrapper">
        <DIV class="innerwrapper">
            <!-- CLOUDS -->
            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 315.832 615.066" class="cloudSvg">
                <defs>
                    <clipPath id="clip-path">
                        <rect x="112.881" y="107.746" width="61.672" height="100.498" fill="none" />
                    </clipPath>
                </defs>
                <title>Asset 1</title>
                <g id="Layer_2" data-name="Layer 2">
                    <g id="Layer_1-2" data-name="Layer 1">
                        <line x1="153.538" y1="188.293" x2="153.538" y2="403.714" fill="none" stroke="#636468" stroke-miterlimit="10" stroke-width="2.144" />
                        <g>
                            <path d="M24.463,128.9A128.259,128.259,0,1,1,153.358,256.517,128.271,128.271,0,0,1,24.463,128.9" fill="#fff" opacity="0.2" />
                            <path d="M69.04,128.682a83.681,83.681,0,1,1,84.095,83.264A83.688,83.688,0,0,1,69.04,128.682" fill="#fff" opacity="0.3" />
                            <g>
                                <path d="M195.307,127.386A41.213,41.213,0,1,0,131.114,161.6s8.9,6.992,8.9,27.862l14.046,5.732v.011l.021-.007.012.007v-.011l14.053-5.732h.044v-2.047c.512-18.065,7.859-24.95,8.766-25.738a41.16,41.16,0,0,0,18.353-34.29m-41.228,67.265-.142-5.19h.292Z" fill="#fff" />
                                <rect x="140.013" y="189.463" width="28.175" height="18.782" fill="#484b4d" />
                                <line x1="140.011" y1="196.444" x2="168.181" y2="196.444" fill="none" stroke="#f6eb3c" stroke-width="0.03" />
                                <line x1="140.011" y1="202.211" x2="168.181" y2="202.211" fill="none" stroke="#f6eb3c" stroke-width="0.03" />
                                <polygon points="146.766 208.242 148.969 213.205 159.13 213.205 161.338 208.242 146.766 208.242" />
                            </g>
                        </g>
                        <path d="M310.722,69.405c-.065,0-.122.014-.183.019a10.744,10.744,0,0,0,.394-2.841,10.582,10.582,0,0,0-17.749-7.8,13.885,13.885,0,0,0-27.227,2.356,9.416,9.416,0,0,0-1.609-.148,9.316,9.316,0,0,0,0,18.633h46.374a5.11,5.11,0,0,0,0-10.221Z" fill="#fff" />
                        <path d="M242.839,316.209c-.1,0-.184.022-.281.028a16.162,16.162,0,0,0-26.51-16.254,21.213,21.213,0,0,0-41.594,3.6c-.18-.032-.356-.057-.532-.083a16.131,16.131,0,0,0-26.246,6.722,11.012,11.012,0,0,0-14.631,10.416,11.162,11.162,0,0,0,11.028,11.186h98.766a7.809,7.809,0,1,0,0-15.617Z" fill="#fff" />
                        <path d="M34.222,229.951a3.963,3.963,0,0,0-3.961-3.963,4.108,4.108,0,0,0-.484.034,10.561,10.561,0,0,0-20.2-6.149A7.217,7.217,0,1,0,7.218,233.91l.01,0v0H30.585l-.007-.016A3.957,3.957,0,0,0,34.222,229.951Z" fill="#fff" />
                        <g>
                            <g>
                                <path d="M292.037,375.777H14.758c-9.438,0-11.357,1.91-11.357,11.355V603.718c0,9.438,1.918,11.348,11.357,11.348H292.037c9.444,0,11.365-1.91,11.365-11.348V387.133C303.4,377.687,301.481,375.777,292.037,375.777Z" fill="#636569" />
                                <rect x="10.757" y="416.967" width="285.36" height="188.098" fill="#0071bc" />
                                <g>
                                    <path d="M41.493,396.39a14.958,14.958,0,1,1-14.961-14.956A14.957,14.957,0,0,1,41.493,396.39Z" fill="#26a9e0" />
                                    <polygon points="23.683 394.766 28.849 389.889 24.65 389.889 17.741 396.406 24.611 402.896 28.815 402.896 23.683 398.048 35.329 398.048 35.329 394.766 23.683 394.766" fill="#fff" opacity="0.5" />
                                </g>
                                <rect x="48.917" y="390.858" width="245.838" height="13.658" fill="#fff" opacity="0.3" />
                            </g>
                            <text transform="translate(111.208 546.202) rotate(0.238)" font-size="117.174" fill="#fff" font-family="MyriadPro-Regular, Myriad Pro">:-)</text>
                        </g>
                        <g>
                            <path d="M169.433,150.092a27.5,27.5,0,1,1,5.122-38.541,27.384,27.384,0,0,1-5.122,38.541" fill="#59b4d9" />
                            <path d="M164.38,133.081a5.923,5.923,0,0,0,8.3,1.1c.135-.1.24-.229.363-.34,2.65,1.867,4.49,3.1,5.528,3.806a23.73,23.73,0,0,0,.737-2.357c-1.1-.815-2.577-1.956-4.719-3.692a5.874,5.874,0,0,0-8.433-7.2c-2.8-2.513-5.877-5.393-9.122-8.618,10.081-5.423,17.244-4.629,17.244-4.629a27.623,27.623,0,0,0-3.967-4.068,29.285,29.285,0,0,0-18.4,3.432l0,0h0q-3.772-3.949-7.681-8.485a25.588,25.588,0,0,0-3.643,1.482,59.234,59.234,0,0,0,7.429,9.423h0c.005.007.012.012.019.019a50.926,50.926,0,0,0-7.638,6.618c-.319.34-.626.682-.926,1.024a8.3,8.3,0,0,0-4.529.31,20.1,20.1,0,0,1-1.9-11.918,28.993,28.993,0,0,0-2.961,3.594,17.624,17.624,0,0,0,1.083,11.107,8.3,8.3,0,0,0-.006,10.07,8.518,8.518,0,0,0,.615.71,41.673,41.673,0,0,0-1.606,9.639c.261.354.261.64.519.986a27.915,27.915,0,0,0,4.576,4.41,30.324,30.324,0,0,1,1.885-12.512,8.256,8.256,0,0,0,3.831-.623c.7.619,1.441,1.245,2.228,1.882a45.838,45.838,0,0,0,8.013,5.108,5.436,5.436,0,0,0,8.746,4.882,5.411,5.411,0,0,0,1.219-1.338,49.053,49.053,0,0,0,10.787,1.121c.425,0,2.395-2.68,3.523-4.341a29,29,0,0,1-13.53-.924,5.4,5.4,0,0,0-8.268-3.425,51.538,51.538,0,0,1-7.434-4.94q-.777-.616-1.495-1.23a8.339,8.339,0,0,0,.35-8.307c.315-.315.624-.63.958-.943a60.378,60.378,0,0,1,7.171-5.8c-.09-.084-.172-.172-.26-.256.089.083.173.167.263.25h0c3.433,3.175,7.073,6.184,10.52,8.873A5.885,5.885,0,0,0,164.38,133.081Z" fill="#fff" />
                        </g>
                    </g>
                </g>
            </svg>
        </DIV>
    </DIV>
    <DIV>
        <DIV class="content">
            <!-- AZURE LOGO -->
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="18.6" viewBox="0 0 24 18.6" class="azureLogo">
                <g id="Layer_2" data-name="Layer 2">
                    <g id="Layer_1-2" data-name="Layer 1">
                        <g>
                            <polygon points="5.483 18.598 24 18.6 14.027 1.314 10.989 9.66 16.822 16.599 5.483 18.598" fill="#fff" />
                            <polygon points="13.231 0 6.104 5.981 0 16.553 5.505 16.553 5.505 16.569 13.231 0" fill="#fff" />
                        </g>
                    </g>
                </g>
            </svg>
            <SPAN class="azureBrand">Microsoft Azure</SPAN>
            <DIV id="bodyHeadline" class="bodyHeadline">Your App Service app is up and running</DIV>
            <DIV id="bodyContent" class="bodyContent">Go to your app's quick start guide in the Azure portal to get started or read our deployment documentation.</DIV>
			
			<table width="750" frame="below">
              <tr bgcolor="rgb(13,188,242)">  
                <th align="left" width="200">    Java Property  </th>  
                <th align="left" width="500">    Value  </th>
              </tr>
              <%@ page import="java.util.*" %>
              <%
                  ArrayList<String> mainPageProps = new ArrayList<String>();
                  mainPageProps.add("java.version");
                  mainPageProps.add("java.vendor");
                  mainPageProps.add("os.arch");
                  mainPageProps.add("catalina.base");
                  mainPageProps.add("jetty.base");
                  mainPageProps.add("user.timezone");
                  for(String name : mainPageProps)
                  {
                    String value = System.getProperty(name);
                    if(value != null)
                    {
  out.print("<tr><td>" + name);
  out.print("</td><td>" + value );
  out.print("</td></tr>");
                    }
                  }
              %>
            </table>
        </DIV>
        <DIV class="bottomContent">
        </DIV>
        <DIV class="bottom">
            <!-- TREES -->
            <svg xmlns="http://www.w3.org/2000/svg" width="745" height="117.585" viewBox="0 0 745 117.585" class="treesSvg">
                <g id="Layer_2" data-name="Layer 2">
                    <g id="Layer_1-2" data-name="Layer 1">
                        <g>
                            <polygon points="532.876 117 532.876 93.986 523.607 78.43 523.607 28.926 512.917 28.926 512.917 39.146 505.369 43.199 505.369 54.709 501.596 54.709 501.596 90.552 489.647 90.552 489.647 15.72 460.087 15.72 460.087 95.582 456.313 95.582 456.313 42.132 437.446 42.132 437.446 0 428.011 0 428.011 61.628 424.869 63.47 424.869 31.442 400.97 31.442 400.97 76.089 386.504 76.089 386.504 97.468 380.844 97.468 380.844 50.935 368.895 50.935 368.895 67.284 352.543 67.284 352.543 47.791 343.109 47.791 343.109 39.615 338.078 39.615 338.078 28.926 335.561 28.926 335.561 39.615 331.16 39.615 331.16 47.791 322.355 47.791 322.355 90.375 318.052 89.441 318.052 28.926 307.362 28.926 307.362 39.146 299.185 43.199 299.185 54.709 296.041 54.709 296.041 90.552 287.765 90.552 287.765 15.72 257.577 15.72 257.577 95.582 254.432 95.582 254.432 42.132 233.677 42.132 233.677 0 226.13 0 226.13 61.628 222.357 63.47 222.357 31.442 198.458 31.442 198.458 76.089 183.993 76.089 183.993 97.468 178.333 97.468 178.333 50.935 166.383 50.935 166.383 67.284 150.661 67.284 150.661 47.791 140.598 47.791 140.598 39.615 136.195 39.615 136.195 28.926 133.051 28.926 133.051 39.615 128.648 39.615 128.648 47.791 119.215 47.791 119.215 90.375 116.699 88.716 116.699 52.822 112.296 52.822 112.296 99.22 102.863 104.564 102.863 117 532.876 117" fill="#001580" opacity="0.6" />
                            <rect x="87.756" y="107.621" width="3.237" height="9.964" fill="#00857d" />
                            <polygon points="722.417 116.708 691.591 14.068 660.516 116.708 722.417 116.708" fill="#8cc63f" opacity="0.6" />
                            <polygon points="570.219 116.93 587.958 56.303 605.695 116.93 570.219 116.93" fill="#4bb55f" />
                            <polygon points="629.893 116.93 643.19 71.485 656.485 116.93 629.893 116.93" fill="#4bb55f" />
                            <polygon points="592.057 116.93 613.558 45.339 635.058 116.93 592.057 116.93" fill="#d9e021" opacity="0.6" />
                            <polygon points="702.093 116.93 723.546 45.497 745 116.93 702.093 116.93" fill="#00857d" opacity="0.7" />
                            <polygon points="645.869 116.93 662.08 62.947 678.293 116.93 645.869 116.93" fill="#00857d" opacity="0.7" />
                            <g opacity="0.8">
                                <ellipse cx="73.159" cy="83.917" rx="20.39" ry="20.386" fill="#8cc63f" />
                                <rect x="70.709" y="101.331" width="5.066" height="15.599" fill="#8cc63f" />
                            </g>
                            <circle cx="89.322" cy="95.842" r="13.024" fill="#00857d" opacity="0.8" />
                            <g>
                                <g>
                                    <circle cx="43.306" cy="102.632" r="8.83" fill="#00857d" opacity="0.8" />
                                    <rect x="42.175" y="110.175" width="2.193" height="6.755" fill="#00857d" />
                                </g>
                                <g opacity="0.8">
                                    <ellipse cx="27.505" cy="89.147" rx="17.161" ry="17.156" fill="#8cc63f" />
                                    <rect x="25.304" y="103.803" width="4.264" height="13.127" fill="#8cc63f" />
                                </g>
                                <circle cx="12.419" cy="96.822" r="12.418" fill="#00857d" opacity="0.8" />
                                <rect x="10.827" y="107.429" width="3.085" height="9.501" fill="#00857d" />
                            </g>
                            <g>
                                <g>
                                    <circle cx="558.474" cy="102.632" r="8.83" fill="#00857d" opacity="0.8" />
                                    <rect x="557.343" y="110.175" width="2.193" height="6.755" fill="#00857d" />
                                </g>
                                <g opacity="0.8">
                                    <ellipse cx="542.673" cy="89.147" rx="17.161" ry="17.156" fill="#8cc63f" />
                                    <rect x="540.471" y="103.803" width="4.264" height="13.127" fill="#8cc63f" />
                                </g>
                                <circle cx="527.586" cy="96.822" r="12.418" fill="#00857d" opacity="0.8" />
                                <rect x="525.995" y="107.429" width="3.085" height="9.501" fill="#00857d" />
                            </g>
                        </g>
                    </g>
                </g>
            </svg>
        </DIV>
    </DIV>
</BODY>
</HTML>