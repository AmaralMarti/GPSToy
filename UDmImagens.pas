unit UDmImagens;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Controls;

type

  { TDmImagens }

  TDmImagens = class(TDataModule)
    lstIcones: TImageList;
  private
    { private declarations }
  public
    { public declarations }
  end;

const
  LARGURA_TELA = 800;
  ALTURA_TELA = 480;

  LARGURA_MENU = 123;
  ALTURA_MENU = ALTURA_TELA;
  POSICAO_MENU_VISIVEL = 678;
  POSICAO_MENU_OCULTO = 808;

  ICONE_MENU = 0;
  ICONE_TRAVA_OFF = 1;
  ICONE_TRAVA_ON = 2;
  ICONE_MUDO_OFF = 3;
  ICONE_MUDO_ON = 4;
  ICONE_BRILHO_FRACO = 5;
  ICONE_BRILHO_MEDIO = 6;
  ICONE_BRILHO_FORTE = 7;

var
  DmImagens: TDmImagens;

implementation

{$R *.lfm}

end.

