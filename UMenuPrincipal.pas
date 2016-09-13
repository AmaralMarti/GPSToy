unit UMenuPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  UDmGpsToy, UMenuLateral, UDesenho, USonsAnimais;

type
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
    procedure AbrirDesenho(Sender: TObject);
    procedure AbrirSonsAnimais(Sender: TObject);
  private

  public

  end;

var
  MenuPrincipal: TMenuPrincipal;

implementation

{$R *.lfm}

{ TMenuPrincipal }

procedure TMenuPrincipal.FormShow(Sender: TObject);
begin
  DmGpsToy.InicializaForm(Self);
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

procedure TMenuPrincipal.AbrirDesenho(Sender: TObject);
begin
  SysUtils.Beep;
  TDesenho.ShowScreen;
end;

procedure TMenuPrincipal.AbrirSonsAnimais(Sender: TObject);
begin
  SysUtils.Beep;
  TSonsAnimais.ShowScreen;
end;

end.

