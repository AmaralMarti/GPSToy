unit UControleDesenho;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, Graphics, Controls;

type

  { TControleDesenho }

  TControleDesenhoOnChangeControlesBloqueados = procedure(const pControlesBloqueados: Boolean) of object;
  TControleDesenhoOnChangeEspessuraTraco = procedure(const pEspessuraTraco: Byte) of object;
  TControleDesenhoOnChangeCorTraco = procedure(const pCorTraco: TColor) of object;

  TControleDesenho = class
  private
    FTela: TPanel;
    FControlesBloqueados: Boolean;
    FMouseDown: Boolean;
    FX: Integer;
    FY: Integer;
    FCor: TColor;
    FEspessuraTraco: Byte;

    FOnChangeControlesBloqueados: TControleDesenhoOnChangeControlesBloqueados;
    FOnChangeEspessuraTraco: TControleDesenhoOnChangeEspessuraTraco;
    FOnChangeCorTraco: TControleDesenhoOnChangeCorTraco;

    procedure TelaMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TelaMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure TelaMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    procedure SetControlesBloqueados(const pControlesBloqueados: Boolean);
    procedure SetEspessuraTraco(const pEspessuraTraco: Byte);
    procedure SetCorTraco(const pCor: TColor);

    procedure SetOnChangeControlesBloqueados(const pEvento: TControleDesenhoOnChangeControlesBloqueados);
    procedure SetOnChangeEspessuraTraco(const pEvento: TControleDesenhoOnChangeEspessuraTraco);
    procedure SetOnChangeCorTraco(const pEvento: TControleDesenhoOnChangeCorTraco);
  public
    constructor Create(const pTelaDesenho: TPanel);

    procedure LimparDesenho;

    property ControlesBloqueados: Boolean read FControlesBloqueados write SetControlesBloqueados;
    property EspessuraTraco: Byte read FEspessuraTraco write SetEspessuraTraco;
    property CorTraco: TColor read FCor write SetCorTraco;

    property OnChangeControlesBloqueados: TControleDesenhoOnChangeControlesBloqueados read FOnChangeControlesBloqueados write SetOnChangeControlesBloqueados;
    property OnChangeEspessuraTraco: TControleDesenhoOnChangeEspessuraTraco read FOnChangeEspessuraTraco write SetOnChangeEspessuraTraco;
    property OnChangeCorTraco: TControleDesenhoOnChangeCorTraco read FOnChangeCorTraco write SetOnChangeCorTraco;
  end;

implementation

{ TControleDesenho }

constructor TControleDesenho.Create(const pTelaDesenho: TPanel);
begin
  FTela := pTelaDesenho;

  FTela.Canvas.Brush.Style := bsSolid;

  FTela.OnMouseDown := @TelaMouseDown;
  FTela.OnMouseMove := @TelaMouseMove;
  FTela.OnMouseUp := @TelaMouseUp;

  ControlesBloqueados := False;
  CorTraco := clBlack;
  EspessuraTraco := 10;

  FMouseDown := False;
end;

procedure TControleDesenho.SetControlesBloqueados(const pControlesBloqueados: Boolean);
begin
  FControlesBloqueados := pControlesBloqueados;

  SysUtils.Beep;

  if Assigned(FOnChangeControlesBloqueados) then begin
    FOnChangeControlesBloqueados(FControlesBloqueados);
  end;
end;

procedure TControleDesenho.SetEspessuraTraco(const pEspessuraTraco: Byte);
begin
  if ControlesBloqueados then begin
    Exit;
  end;

  FEspessuraTraco := pEspessuraTraco;
  FTela.Canvas.Pen.Width := FEspessuraTraco;

  if Assigned(FOnChangeEspessuraTraco) then begin
    FOnChangeEspessuraTraco(FEspessuraTraco);
  end;
end;

procedure TControleDesenho.SetCorTraco(const pCor: TColor);
begin
  if ControlesBloqueados then begin
    Exit;
  end;

  SysUtils.Beep;

  FCor := pCor;

  FTela.Canvas.Pen.Color := FCor;
  FTela.Canvas.Brush.Color := FCor;

  if Assigned(FOnChangeCorTraco) then begin
    FOnChangeCorTraco(FCor);
  end;
end;

procedure TControleDesenho.SetOnChangeControlesBloqueados(const pEvento: TControleDesenhoOnChangeControlesBloqueados);
begin
  FOnChangeControlesBloqueados := pEvento;

  if Assigned(FOnChangeControlesBloqueados) then begin
    FOnChangeControlesBloqueados(ControlesBloqueados);
  end;
end;

procedure TControleDesenho.SetOnChangeEspessuraTraco(const pEvento: TControleDesenhoOnChangeEspessuraTraco);
begin
  FOnChangeEspessuraTraco := pEvento;

  if Assigned(FOnChangeEspessuraTraco) then begin
    FOnChangeEspessuraTraco(EspessuraTraco);
  end;
end;

procedure TControleDesenho.SetOnChangeCorTraco(const pEvento: TControleDesenhoOnChangeCorTraco);
begin
  FOnChangeCorTraco := pEvento;

  if Assigned(FOnChangeCorTraco) then begin
    FOnChangeCorTraco(CorTraco);
  end;
end;

procedure TControleDesenho.LimparDesenho;
begin
  if ControlesBloqueados then begin
    Exit;
  end;

  FTela.Repaint;
end;

procedure TControleDesenho.TelaMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  FMouseDown := True;
  FX := X;
  FY := Y;
end;

procedure TControleDesenho.TelaMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  lDif: Integer;
begin
  if FMouseDown then begin
    lDif := FTela.Canvas.Pen.Width div 6;
    FTela.Canvas.Ellipse(X - lDif, Y - lDif, X + lDif, Y + lDif);

    FTela.Canvas.Line(FX, FY, X, Y);
    FX := X;
    FY := Y;
  end;
end;

procedure TControleDesenho.TelaMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FMouseDown := False;
end;

end.

