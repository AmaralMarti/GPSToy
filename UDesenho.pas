unit UDesenho;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons, StdCtrls, ComCtrls, ColorBox,
  UDmGpsToy, UMenuLateral;

type

  { TDesenho }

  TDesenho = class(TForm)
    btnMenu: TSpeedButton;
    grpTraco: TGroupBox;
    imgTrava: TImage;
    lbTraco: TLabel;
    pnlDesenho: TPanel;
    shAmarelo: TShape;
    shTrava: TShape;
    shAzul: TShape;
    shRosa: TShape;
    shVerde: TShape;
    shPreto: TShape;
    btnLimpar: TSpeedButton;
    shBranco: TShape;
    udTraco: TUpDown;
    procedure btnMenuClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgTravaClick(Sender: TObject);
    procedure pnlDesenhoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pnlDesenhoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure pnlDesenhoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure AtualizarCor(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnLimparClick(Sender: TObject);
    procedure shTravaMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure udTracoClick(Sender: TObject; Button: TUDBtnType);
  private
    FBloqueado: Boolean;
    FMouseDown: Boolean;
    FX: Integer;
    FY: Integer;
    procedure AtualizarTraco;
    procedure ProcessarTrava;
  public
    class procedure ShowScreen;
  end;

implementation

{$R *.lfm}

{ TDesenho }

procedure TDesenho.FormShow(Sender: TObject);
begin
  DmGpsToy.InicializaForm(Self);

  AtualizarTraco;

  pnlDesenho.Canvas.Brush.Style := bsSolid;
  pnlDesenho.Canvas.Pen.Color := clBlack;
  pnlDesenho.Canvas.Brush.Color := clBlack;

  FBloqueado := True;
  ProcessarTrava;
end;

procedure TDesenho.imgTravaClick(Sender: TObject);
begin
  ProcessarTrava;
end;

procedure TDesenho.btnMenuClick(Sender: TObject);
begin
  if FBloqueado then begin
    Exit;
  end;

  if TMenuLateral.ShowMenu = mlrSair then begin
    SysUtils.Beep;
    Close;
  end;
end;

procedure TDesenho.pnlDesenhoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  AtualizarTraco;

  FMouseDown := True;
  FX := X;
  FY := Y;
end;

procedure TDesenho.pnlDesenhoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  lDif: Integer;
begin
  if FMouseDown then begin
    lDif := pnlDesenho.Canvas.Pen.Width div 6;
    pnlDesenho.Canvas.Ellipse(X - lDif, Y - lDif, X + lDif, Y + lDif);

    pnlDesenho.Canvas.Line(FX, FY, X, Y);
    FX := X;
    FY := Y;
  end;
end;

procedure TDesenho.pnlDesenhoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FMouseDown := False;
end;

procedure TDesenho.AtualizarCor(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FBloqueado then begin
    Exit;
  end;

  SysUtils.Beep;

  pnlDesenho.Canvas.Pen.Color := TShape(Sender).Brush.Color;
  pnlDesenho.Canvas.Brush.Color := TShape(Sender).Brush.Color;

  shPreto.Pen.Width := 1;
  shAmarelo.Pen.Width := 1;
  shAzul.Pen.Width := 1;
  shRosa.Pen.Width := 1;
  shVerde.Pen.Width := 1;
  shBranco.Pen.Width := 1;

  TShape(Sender).Pen.Width := 5;
end;

procedure TDesenho.btnLimparClick(Sender: TObject);
begin
  if FBloqueado then begin
    Exit;
  end;

  pnlDesenho.Repaint;
end;

procedure TDesenho.shTravaMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ProcessarTrava;
end;

procedure TDesenho.udTracoClick(Sender: TObject; Button: TUDBtnType);
begin
  AtualizarTraco;
end;

procedure TDesenho.AtualizarTraco;
begin
  if FBloqueado then begin
    Exit;
  end;

  lbTraco.Caption := IntToStr(udTraco.Position);
  pnlDesenho.Canvas.Pen.Width := udTraco.Position;
end;

procedure TDesenho.ProcessarTrava;
var
  lIndiceIcone: Integer;
  lCor: TColor;
begin
  FBloqueado := not FBloqueado;

  if FBloqueado then begin
    lIndiceIcone := ICONE_TRAVA_ON;
    lCor := clRed;
  end else begin
    lIndiceIcone := ICONE_TRAVA_OFF;
    lCor := clLime;
  end;

  DmGpsToy.lstIcones.GetBitmap(lIndiceIcone, imgTrava.Picture.Bitmap);
  shTrava.Brush.Color := lCor;
end;

class procedure TDesenho.ShowScreen;
var
  lForm: TDesenho;
begin
  Application.CreateForm(TDesenho, lForm);
  try
    lForm.ShowModal;
  finally
    FreeAndNil(lForm);
  end;
end;

end.

