unit UMenuPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons, StdCtrls, Grids,
  UDmImagens, UMenuLateral, UDesenho;

type

  { TMenuPrincipal }

  TMenuPrincipal = class(TForm)
    imgSonsAnimais: TImage;
    imgFundo: TImage;
    imgTitulo: TImage;
    btnDesenho: TImage;
    btnSonsAnimais: TImage;
    imgDesenho: TImage;
    shDesenho: TShape;
    shSonsAnimais: TShape;
    btnMenu: TSpeedButton;
    procedure btnMenuClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OpenDraw(Sender: TObject);
  private

  public

  end;

Function PlaySoundW(x1: PWideChar; x2: HMODULE; x3: DWORD): longbool; stdcall; external 'coredll.dll' name 'PlaySoundW';

var
  MenuPrincipal: TMenuPrincipal;

implementation

{$R *.lfm}

{ TMenuPrincipal }

procedure TMenuPrincipal.FormShow(Sender: TObject);
begin
  Top := 0;
  Left := 0;
  Width := LARGURA_TELA;
  Height := ALTURA_TELA;

  btnMenu.Flat := True;
  DmImagens.lstIcones.GetBitmap(ICONE_MENU, btnMenu.Glyph);

  BringToFront;
end;

procedure TMenuPrincipal.btnSairClick(Sender: TObject);
begin
  SysUtils.Beep;
  Close;
end;

procedure TMenuPrincipal.btnMenuClick(Sender: TObject);
begin
  if TMenuLateral.ShowMenu = mlrSair then begin
    Close;
  end;
end;

procedure TMenuPrincipal.OpenDraw(Sender: TObject);
begin
  SysUtils.Beep;
  TDesenho.ShowScreen;
end;

end.

