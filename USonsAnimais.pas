unit USonsAnimais;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons, ExtCtrls, mmsystem,
  UDmGpsToy, UMenuLateral;

type
  TSonsAnimaisTipoAnimal = (taNaoDefinido, taGato, taVaca, taPato, taCachorro, taGalo, taCavalo);

  TSonsAnimais = class(TForm)
    btnMenu: TSpeedButton;
    imgGato: TImage;
    imgGalo: TImage;
    imgCavalo: TImage;
    imgFundo: TImage;
    imgCachorro: TImage;
    imgVaca: TImage;
    imgPato: TImage;
    shChachorro: TShape;
    shGato: TShape;
    shGalo: TShape;
    shCavalo: TShape;
    shVaca: TShape;
    shPato: TShape;
    procedure btnMenuClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Reproduzir(Sender: TObject);
  private
    function GetTipoAnimal(const pComponente: TComponent): TSonsAnimaisTipoAnimal;
  public
    class procedure ShowScreen;
  end;

implementation

{$R *.lfm}

{ TSonsAnimais }

procedure TSonsAnimais.FormShow(Sender: TObject);
begin
  DmGpsToy.InicializaForm(Self);
end;

procedure TSonsAnimais.Reproduzir(Sender: TObject);
var
  lTipoAnimal: TSonsAnimaisTipoAnimal;
  lArquivo: String;
begin
  lTipoAnimal := GetTipoAnimal(TComponent(Sender));

  case lTipoAnimal of
    taGato: lArquivo := DmGpsToy.SomGato;
    taVaca: lArquivo := DmGpsToy.SomVaca;
    taPato: lArquivo := DmGpsToy.SomPato;
    taCachorro: lArquivo := DmGpsToy.SomCachorro;
    taGalo: lArquivo := DmGpsToy.SomGalo;
    taCavalo: lArquivo := DmGpsToy.SomCavalo;
  else
    Exit;
  end;

  PlaySoundW(StringToPWideChar(AnsiString(lArquivo)), 0, 0);
end;

function TSonsAnimais.GetTipoAnimal(const pComponente: TComponent): TSonsAnimaisTipoAnimal;
begin
  Result := taNaoDefinido;

  if pComponente = imgGato then Result := taGato;
  if pComponente = imgVaca then Result := taVaca;
  if pComponente = imgPato then Result := taPato;
  if pComponente = imgCachorro then Result := taCachorro;
  if pComponente = imgGalo then Result := taGalo;
  if pComponente = imgCavalo then Result := taCavalo;
end;

procedure TSonsAnimais.btnMenuClick(Sender: TObject);
begin
  if TMenuLateral.ShowMenu = mlrSair then begin
    SysUtils.Beep;
    Close;
  end;
end;

class procedure TSonsAnimais.ShowScreen;
var
  lForm: TSonsAnimais;
begin
  Application.CreateForm(TSonsAnimais, lForm);
  try
    lForm.ShowModal;
  finally
    FreeAndNil(lForm);
  end;
end;

end.
