unit UDesenho;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls, ComCtrls, ColorBox;

type

  { TDesenho }

  TDesenho = class(TForm)
    btnSair: TSpeedButton;
    GroupBox1: TGroupBox;
    imgLockFront: TImage;
    imgLockClose: TImage;
    imgLockOpen: TImage;
    lbTraco: TLabel;
    pnlDraw: TPanel;
    shAmarelo: TShape;
    shLockBackground: TShape;
    shAzul: TShape;
    shRosa: TShape;
    shVerde: TShape;
    shPreto: TShape;
    btnLimpar: TSpeedButton;
    shBranco: TShape;
    upTraco: TUpDown;
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgLockFrontClick(Sender: TObject);
    procedure pnlDrawMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pnlDrawMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure pnlDrawMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure AtualizarCor(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnLimparClick(Sender: TObject);
    procedure upTracoClick(Sender: TObject; Button: TUDBtnType);
  private
    FBloqueado: Boolean;
    FMouseDown: Boolean;
    FX: Integer;
    FY: Integer;
    procedure AtualizarTraco;
  public
    class procedure ShowScreen;
  end;

implementation

{$R *.lfm}

{ TDesenho }

procedure TDesenho.FormShow(Sender: TObject);
begin
  Top := 0;
  Left := 0;
  Width := Screen.Width;
  Height := Screen.Height;

  btnSair.Top := 0;
  btnSair.Left := Width - btnSair.Width;

  BringToFront;

  AtualizarTraco;

  pnlDraw.Canvas.Brush.Style := bsSolid;
  pnlDraw.Canvas.Pen.Color := clBlack;
  pnlDraw.Canvas.Brush.Color := clBlack;

  FBloqueado := True;
  imgLockFrontClick(Nil);

end;

procedure TDesenho.imgLockFrontClick(Sender: TObject);
begin
  FBloqueado := not FBloqueado;

  imgLockClose.Visible := FBloqueado;
  imgLockOpen.Visible := not FBloqueado;

  if FBloqueado then begin
    shLockBackground.Brush.Color := clRed;
  end else begin
    shLockBackground.Brush.Color := clLime;
  end;
end;

procedure TDesenho.btnSairClick(Sender: TObject);
begin
  if FBloqueado then begin
    Exit;
  end;

  SysUtils.Beep;
  Close;
end;

procedure TDesenho.pnlDrawMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  AtualizarTraco;

  FMouseDown := True;
  FX := X;
  FY := Y;
end;

procedure TDesenho.pnlDrawMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  lDif: Integer;
begin
  if FMouseDown then begin
    lDif := pnlDraw.Canvas.Pen.Width div 6;
    pnlDraw.Canvas.Ellipse(X - lDif, Y - lDif, X + lDif, Y + lDif);

    pnlDraw.Canvas.Line(FX, FY, X, Y);
    FX := X;
    FY := Y;
  end;
end;

procedure TDesenho.pnlDrawMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FMouseDown := False;
end;

procedure TDesenho.AtualizarCor(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FBloqueado then begin
    Exit;
  end;

  SysUtils.Beep;

  pnlDraw.Canvas.Pen.Color := TShape(Sender).Brush.Color;
  pnlDraw.Canvas.Brush.Color := TShape(Sender).Brush.Color;

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

  pnlDraw.Repaint;
end;

procedure TDesenho.upTracoClick(Sender: TObject; Button: TUDBtnType);
begin
  AtualizarTraco;
end;

procedure TDesenho.AtualizarTraco;
begin
  if FBloqueado then begin
    Exit;
  end;
  lbTraco.Caption := IntToStr(upTraco.Position);
  pnlDraw.Canvas.Pen.Width := upTraco.Position;
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

