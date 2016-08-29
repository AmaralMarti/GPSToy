unit UMenuLateral;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  ExtCtrls;

type

  TMenuLateralResult = (mlrNenhum, mlrSair);

  { TMenuLateral }

  TMenuLateral = class(TForm)
    btnBrilho: TSpeedButton;
    btnRecolhe: TSpeedButton;
    btnSair: TSpeedButton;
    btnVolume: TSpeedButton;
    imgBrilho: TImage;
    imgLinha: TImage;
    imgSair: TImage;
    imgVolume: TImage;
    procedure btnRecolheClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FResult: TMenuLateralResult;
    procedure Apresentar;
    procedure Recolher;
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
  Height := 480;
  Width := 123;
  Top := 0;

  FResult := mlrNenhum;
end;

procedure TMenuLateral.btnSairClick(Sender: TObject);
begin
  FResult := mlrSair;
  Recolher;
end;

procedure TMenuLateral.FormActivate(Sender: TObject);
begin
  Apresentar;
end;

procedure TMenuLateral.btnRecolheClick(Sender: TObject);
begin
  Recolher;
end;

procedure TMenuLateral.Apresentar;
var
  i: Integer;
begin
  Left := 808;

  for i := 1 to 10 do begin
    Left := Left - 13;
    Sleep(10);
    Application.ProcessMessages;
  end;
end;

procedure TMenuLateral.Recolher;
var
  i: Integer;
begin
  Left := 678;
  for i := 1 to 10 do begin
    Left := Left + 13;
    Sleep(10);
    Application.ProcessMessages;
  end;
  Close;
end;

end.

