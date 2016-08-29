# GPSToy
Aplicativo para WinCE que transformou meu velho aparelho GPS em um brinquedo para meu filho se divertir

## Especificações do projeto

### Aparelho GPS

Esse projeto foi desenvolvido para funcionar especificamente no modelo de aparelho de GPS que eu tenho. É muito simples alterá-lo para funcionar em qualquer outro modelo de aparelho GPS que rode WinCE, basicamente será necessário adaptar o tamanho da tela se ela for diferente de 7". Acredito que não haja diferenças caso o aparelho rode WinCE 5 ou WinCE 6, mas não tenho como garantir por não ter feito esse teste.

#### Especificações do meu aparelho GPS

<p align="center">
  <img src="http://marti.com.br/img/gps_001.jpg">
  <br>
  GPS na sua tela original
</p>

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



## A Ideia

Tenho um aparelho GPS praticamente novo aqui em casa faz um tempo, pelo bom estado dele eu sempre fiquei com dó de jogá-lo fora e fui deixando guardado pra ver como poderia usá-lo no futuro.

Eu até pensei em usá-lo como monitor para o meu RaspberryPi, mas nunca fui adiante porque não é muito prático e eu já tenho um monitor LCD sobrando que uso pro Rasp quando preciso.

A ideia de transformá-lo em um brinquedo para meu filho de 18 meses veio quando eu abri o Paint no Win CE e dei a caneta para meu menino rabiscar (muita gente começou nos computadores desenhando no Paint, eu mesmo sou um exemplo). Pra minha surpresa ele segurou a caneta direitinho e começou a rabiscar, quando tentei tirar o GPS dele pra colocar pra carregar ele não deixou e ficou deitadinho no chão rabiscando até o aparelho apagar de vez.

Finalmente eu tinha encontrado uma utilidade para o GPS, mas como meu filho saia batendo com a caneta pra todo lado da tela  alguém sempre precisava ficar por perto pra "dar suporte". Pra resolver isso eu resolvi criar uma aplicação que ficasse em tela cheia e que só permitisse que ele desenhasse, sem fechar a tela ou acessar algum menu do sistema. Depois disso a criatividade foi embora e a aplicação foi crescendo.

