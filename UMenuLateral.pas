unit UMenuLateral;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons, ExtCtrls, StdCtrls, registry,
  UDmGpsToy, UAjustarVolume;

type
  TMenuLateralResult = (mlrNenhum, mlrSair);

  TMenuLateral = class(TForm)
    btnBrilho: TSpeedButton;
    btnRecolhe: TSpeedButton;
    btnSair: TSpeedButton;
    btnVolume: TSpeedButton;
    imgBrilho: TImage;
    imgSair: TImage;
    imgMudo: TImage;
    lbVolume: TLabel;
    lbBrilho: TLabel;
    shDivisor2: TShape;
    shDivisor3: TShape;
    shDivisor1: TShape;
    shpLinha: TShape;
    procedure btnBrilhoClick(Sender: TObject);
    procedure btnRecolheClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnVolumeClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgBrilhoClick(Sender: TObject);
    procedure imgMudoClick(Sender: TObject);
  private
    FResult: TMenuLateralResult;
    FShow: Boolean;
    procedure Apresentar;
    procedure Recolher;
    procedure AtualizarVolume;
    procedure AtualizarBrilho;
    function GetBrilho: Integer;
  public
    class function ShowMenu: TMenuLateralResult;
  end;

implementation

{$R *.lfm}

{ TMenuLateral }

class function TMenuLateral.ShowMenu: TMenuLateralResult;
var
  lForm: TMenuLateral;
begin
  Application.CreateForm(TMenuLateral, lForm);
  try
    lForm.ShowModal;
    Result := lForm.FResult;
  finally
    FreeAndNil(lForm);
  end;
end;

procedure TMenuLateral.FormShow(Sender: TObject);
begin
  Height := ALTURA_MENU;
  Width := LARGURA_MENU;

  Top := 0;
  Left := POSICAO_MENU_OCULTO;

  FResult := mlrNenhum;

  AtualizarVolume;
  AtualizarBrilho;
end;

procedure TMenuLateral.imgBrilhoClick(Sender: TObject);
begin
  btnBrilho.Click;
end;

procedure TMenuLateral.imgMudoClick(Sender: TObject);
begin
  TAjustarVolume.ChangeMudo;
  AtualizarVolume;
end;

procedure TMenuLateral.btnSairClick(Sender: TObject);
begin
  FResult := mlrSair;
  Recolher;
end;

procedure TMenuLateral.btnVolumeClick(Sender: TObject);
begin
  TAjustarVolume.ChangeVolume;
  AtualizarVolume;
end;

procedure TMenuLateral.FormActivate(Sender: TObject);
begin
  if not FShow then begin
    Apresentar;
    FShow := True;
  end;
end;

procedure TMenuLateral.FormCreate(Sender: TObject);
begin
  FShow := False;
end;

procedure TMenuLateral.btnRecolheClick(Sender: TObject);
begin
  Recolher;
end;

procedure TMenuLateral.btnBrilhoClick(Sender: TObject);
begin
  SysUtils.ExecuteProcess('ctlpnl.exe',['windows\bklctl.cpl']);
  AtualizarBrilho;
end;

procedure TMenuLateral.Apresentar;
var
  i: Integer;
begin
  Left := POSICAO_MENU_OCULTO;
  for i := 1 to 10 do begin
    Left := Left - 12;
    Application.ProcessMessages;
  end;
  Left := POSICAO_MENU_VISIVEL;
end;

procedure TMenuLateral.Recolher;
var
  i: Integer;
begin
  Left := POSICAO_MENU_VISIVEL;
  for i := 1 to 10 do begin
    Left := Left + 13;
    Application.ProcessMessages;
  end;
  Left := POSICAO_MENU_OCULTO;
  Close;
end;

procedure TMenuLateral.AtualizarVolume;
var
  lIndiceIcone, lValorVolume: Integer;
begin
  if TAjustarVolume.Mudo then begin
    lIndiceIcone := ICONE_MUDO_ON;
  end else begin
    lIndiceIcone := ICONE_MUDO_OFF;
  end;

  lValorVolume := TAjustarVolume.Volume * 10;

  DmGpsToy.lstIcones.GetBitmap(lIndiceIcone, imgMudo.Picture.Bitmap);
  btnVolume.Caption := IntToStr(lValorVolume) + '%';
end;

procedure TMenuLateral.AtualizarBrilho;
var
  lIndiceIcone, lValorBrilho: Integer;
begin
  lValorBrilho := GetBrilho;

  if lValorBrilho <= 34 then begin
    lIndiceIcone := ICONE_BRILHO_FRACO;
  end;

  if (lValorBrilho > 34) and (lValorBrilho < 66) then begin
    lIndiceIcone := ICONE_BRILHO_MEDIO;
  end;

  if lValorBrilho >= 66 then begin
    lIndiceIcone := ICONE_BRILHO_FORTE;
  end;

  DmGpsToy.lstIcones.GetBitmap(lIndiceIcone, imgBrilho.Picture.Bitmap);
  btnBrilho.Caption := IntToStr(lValorBrilho) + '%';
end;

function TMenuLateral.GetBrilho: Integer;
var
  lReg: TRegistry;
begin
  lReg := TRegistry.Create;
  try
    Result := -1;
    lReg.RootKey := HKEY_CURRENT_USER;
    if lReg.OpenKey('ControlPanel\BackLight', False) then begin
      Result := lReg.ReadInteger('BacklightCurrentLevel');
    end;
  finally
    FreeAndNil(lReg);
  end;
end;

end.
