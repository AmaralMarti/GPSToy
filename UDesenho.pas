unit UDesenho;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons, StdCtrls, ComCtrls,
  UDmGpsToy, UMenuLateral, UControleDesenho;

type
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
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AtualizarCor(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnLimparClick(Sender: TObject);
    procedure AlterarTravamentoControles(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure udTracoClick(Sender: TObject; Button: TUDBtnType);
  private
    FDesenho: TControleDesenho;
    FListaControleCores: TList;
    procedure OnChangeEspessuraTraco(const pEspessuraTraco: Byte);
    procedure OnChangeControlesBloqueados(const pControlesBloqueados: Boolean);
    procedure OnChangeCorTraco(const pCorTraco: TColor);
  public
    class procedure ShowScreen;
  end;

implementation

{$R *.lfm}

{ TDesenho }

procedure TDesenho.FormShow(Sender: TObject);
begin
  DmGpsToy.InicializaForm(Self);

  {$Region 'Inicializa a lista dos Controles de Cores'}
  FListaControleCores := TList.Create;

  FListaControleCores.Add(shPreto);
  FListaControleCores.Add(shAmarelo);
  FListaControleCores.Add(shAzul);
  FListaControleCores.Add(shRosa);
  FListaControleCores.Add(shVerde);
  FListaControleCores.Add(shBranco);
  {$EndRegion}

  {$Region 'Inicializa o Objeto de Controle do Desenho'}
  FDesenho := TControleDesenho.Create(pnlDesenho);

  FDesenho.OnChangeControlesBloqueados := @OnChangeControlesBloqueados;
  FDesenho.OnChangeCorTraco := @OnChangeCorTraco;
  FDesenho.OnChangeEspessuraTraco := @OnChangeEspessuraTraco;
  {$EndRegion}
end;

procedure TDesenho.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FDesenho);
  FreeAndNil(FListaControleCores);
end;

procedure TDesenho.btnMenuClick(Sender: TObject);
begin
  if FDesenho.ControlesBloqueados then begin
    Exit;
  end;

  if TMenuLateral.ShowMenu = mlrSair then begin
    SysUtils.Beep;
    Close;
  end;
end;

procedure TDesenho.AtualizarCor(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FDesenho.CorTraco := TShape(Sender).Brush.Color;
end;

procedure TDesenho.btnLimparClick(Sender: TObject);
begin
  FDesenho.LimparDesenho;
end;

procedure TDesenho.AlterarTravamentoControles(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FDesenho.ControlesBloqueados := not FDesenho.ControlesBloqueados;
end;

procedure TDesenho.udTracoClick(Sender: TObject; Button: TUDBtnType);
begin
  FDesenho.EspessuraTraco := udTraco.Position;
end;

procedure TDesenho.OnChangeEspessuraTraco(const pEspessuraTraco: Byte);
begin
  lbTraco.Caption := IntToStr(pEspessuraTraco);
end;

procedure TDesenho.OnChangeControlesBloqueados(const pControlesBloqueados: Boolean);
var
  lIndiceIcone: Integer;
  lCor: TColor;
begin
  if pControlesBloqueados then begin
    lIndiceIcone := ICONE_TRAVA_ON;
    lCor := clRed;
  end else begin
    lIndiceIcone := ICONE_TRAVA_OFF;
    lCor := clLime;
  end;

  DmGpsToy.lstIcones.GetBitmap(lIndiceIcone, imgTrava.Picture.Bitmap);
  shTrava.Brush.Color := lCor;
end;

procedure TDesenho.OnChangeCorTraco(const pCorTraco: TColor);
var
  i: Integer;
  lComponenteCor: TShape;
begin

  for i := 0 to pred(FListaControleCores.Count) do begin
    lComponenteCor := TShape(FListaControleCores[i]);
    if lComponenteCor.Brush.Color = pCorTraco then begin
      lComponenteCor.Pen.Width := 5;
    end else begin
      lComponenteCor.Pen.Width := 1;
    end;
  end;
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

