# GPSToy
Aplicativo para WinCE que transformou meu velho aparelho GPS em um brinquedo para meu filho se divertir

## Especificações do projeto

_**Importante:** Esse projeto foi desenvolvido para funcionar especificamente no modelo de aparelho de GPS que eu tenho. É muito simples alterá-lo para funcionar em qualquer outro modelo de aparelho GPS que rode WinCE, basicamente será necessário adaptar o tamanho da tela se ela for diferente de 7" (alterar o tamanho das imagens e posicionamento dos componentes). Acredito que a versão do WinCE que aparelho use (WinCE 5 ou WinCE 6) não altere o funcionamento da aplicação, mas não posso garantir porque não testei esse caso._

### Aparelho GPS

<p align="center">
  <img src="http://marti.com.br/img/gps_001.jpg">
  <br>
  GPS na sua tela original
</p>

#### Especificações do meu aparelho GPS
* Modelo: GPS Guia Quatro Rodas 7.0 TV e Câmera de Ré
* Site do produto: [http://aquariusbrasil.com/produto/gps-guia-quatro-rodas-7-0-tv-e-camera-de-re](http://aquariusbrasil.com/produto/gps-guia-quatro-rodas-7-0-tv-e-camera-de-re)
* Tela: 7.0" Touch Screen colorida. Resolução: 800 x 480 pixels
* Sistema Operacional: Microsoft Windows CE .NET 6.0 (versão core)
* Processador: 600MHz
* Memória RAM: 128MB
* Memória interna: 2GB (1GB livre para utilização do usuário)
* Slot para cartão de memória: Micro SD/MMC de até 32GB
* Áudio: alto-falante integrado
* Entrada para fone de ouvido estéreo de 3.5 mm
* Conexões: USB 2.0
* Antena de TV digital
* Câmera de ré
* Transmissão FM

### Linguagem de programação

Usei nesse projeto o Lazarus, que é uma IDE para Free Pascal que compila para diversar plataformas, inclusive WinCE com processador ARM que é o caso do aparelho GPS. Se você não conhece essa IDE eu recomendo que perca um tempinho para conhecê-la, ela é muito versátil e simples de usar, é multiplataforma e compila aplicações para muitos sistemas operacionais (alguns que lembro para citar agora são: **Linux**, **FreeBSD**, **Win32**, **Win64**, **Solaris**, **MacOS**, **Android**, **Symbian**, **WinCE**, **PalmOS** e **MS-DOS**) e várias arquiteturas de processador (as que me lembro pra citar são: **i386**, **x86_64**, **ARM** e **MIPS**). Se você achar qualquer aparelhinho largado em uma gaveta da sua casa e quiser criar uma aplicação para ele, provavelmente você conseguirá criá-la com Lazarus! Vale a pena tê-la sempre instalada no seu PC para qualquer necessidade.

<p align="center">
  <img src="http://marti.com.br/img/lazarus_about.jpg">
  <br>
  Tela de Sobre do Lazarus
</p>

#### Especificações da IDE Lazarus utilizada
* Versão da IDE: Lazarus versão 1.4.0 (**obrigatoriamente a versão para Windows**)
* Sistema Operacional: Windows 8.1 32 bits (usei uma VM que baixei do site [www.modern.ie](http://www.modern.ie))
* Customizações: não customizei nada, rodei a VM no VirtualBox, instalei o Lazarus e criei o projeto. Uso todas as configurações e os componentes do padrão de instalação do Lazarus.

**Muito Importante:**
Esse projeto exige o uso de _cross compile_ (compilação cruzada), ou seja, gerar uma aplicação para um sistema operacional usando outro. Isso acontece porque vamos usar o Lazarus rodando sobre o Windows 8.1 para gerar um executável para o Windows CE, veja que são sistemas operacionais completamente diferentes.

**Por que usar a VM?** Eu não tenho acesso a nenhum computador com Windows, uso Linux em todos os meus computadores. Acredito que até seja possível configurar o Lazarus para fazer _cross compile_ de Linux para WinCE, eu li alguma documentação e tentei fazer, mas tive muitos problemas e acabei optando por usar a VM da Microsoft, pois para fazer o _cross compile_ de Windows 8.1 para WinCE não é preciso fazer configuração nenhuma no ambiente, você precisa apenas configurar seu projeto no Lazarus com o _target_ para WinCE e processador ARM.

### Arquivos de imagens e sons

## A Ideia

Tenho um aparelho GPS praticamente novo aqui em casa faz um tempo, pelo bom estado dele eu sempre fiquei com dó de jogá-lo fora e fui deixando guardado pra ver como poderia usá-lo no futuro.

Eu até pensei em usá-lo como monitor para o meu RaspberryPi, mas nunca fui adiante porque não é muito prático e eu já tenho um monitor LCD sobrando que uso pro Rasp quando preciso.

A ideia de transformá-lo em um brinquedo para meu filho de 18 meses veio quando eu abri o Paint no Win CE e dei a caneta para meu menino rabiscar (muita gente começou nos computadores desenhando no Paint, eu mesmo sou um exemplo). Pra minha surpresa ele segurou a caneta direitinho e começou a rabiscar, quando tentei tirar o GPS dele pra colocar pra carregar ele não deixou e ficou deitadinho no chão rabiscando até o aparelho apagar de vez.

Finalmente eu tinha encontrado uma utilidade para o GPS, mas como meu filho saia batendo com a caneta pra todo lado da tela  alguém sempre precisava ficar por perto pra "dar suporte". Pra resolver isso eu resolvi criar uma aplicação que ficasse em tela cheia e que só permitisse que ele desenhasse, sem fechar a tela ou acessar algum menu do sistema. Depois disso a criatividade foi embora e a aplicação foi crescendo.

