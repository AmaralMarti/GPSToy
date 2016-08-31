unit UAjustarVolume;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ComCtrls, mmsystem;

type

  { TAjustarVolume }

  TAjustarVolume = class(TForm)
    btnOk: TButton;
    btnCancelar: TButton;
    chkMudo: TCheckBox;
    lbPercentual: TLabel;
    lbTitulo: TLabel;
    shLeft: TShape;
    shRight: TShape;
    shBottom: TShape;
    shTop: TShape;
    trkVolume: TTrackBar;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure chkMudoChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure trkVolumeChange(Sender: TObject);
  private
    class procedure SetVolume(const pPercentual: Integer);
  public
    FVolumeAtual: Integer;
    class procedure ChangeVolume;
    class function Volume: Integer;
    class function Mudo: Boolean;
    class procedure ChangeMudo;
    class procedure InicializarVolume;
  end;

implementation

var
  FVolume: Integer;
  FMudo: Boolean;

{$R *.lfm}

{ TAjustarVolume }

procedure TAjustarVolume.btnOkClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TAjustarVolume.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TAjustarVolume.chkMudoChange(Sender: TObject);
var
  lVolumeAtual: Integer;
begin
  trkVolume.Enabled := not chkMudo.Checked;
  if trkVolume.Enabled then begin
    trkVolume.Position := FVolumeAtual;
  end else begin
    lVolumeAtual := FVolumeAtual;
    trkVolume.Position := 0;
    FVolumeAtual := lVolumeAtual;
  end;
end;

procedure TAjustarVolume.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if ModalResult = mrOK then begin
    FMudo := chkMudo.Checked;
    if not FMudo then begin
      FVolume := trkVolume.Position;
      SetVolume(FVolume);
    end;
  end;
end;

procedure TAjustarVolume.FormShow(Sender: TObject);
begin
  trkVolume.Position := FVolume;
  FVolumeAtual := FVolume;
  chkMudo.Checked := FMudo;
end;

procedure TAjustarVolume.trkVolumeChange(Sender: TObject);
begin
  FVolumeAtual := trkVolume.Position;
  lbPercentual.Caption := IntToStr(FVolumeAtual * 10) + '%';
end;

class procedure TAjustarVolume.SetVolume(const pPercentual: Integer);
begin
  case pPercentual of
    00: waveOutSetVolume(0, 0);
    01: waveOutSetVolume(0, 6554);
    02: waveOutSetVolume(0, 13107);
    03: waveOutSetVolume(0, 19661);
    04: waveOutSetVolume(0, 26214);
    05: waveOutSetVolume(0, 32768);
    06: waveOutSetVolume(0, 39321);
    07: waveOutSetVolume(0, 45875);
    08: waveOutSetVolume(0, 52428);
    09: waveOutSetVolume(0, 58982);
    10: waveOutSetVolume(0, 65535);
  end;
end;

class procedure TAjustarVolume.ChangeVolume;
var
  lForm: TAjustarVolume;
begin
  Application.CreateForm(TAjustarVolume, lForm);
  try
    lForm.ShowModal;
  finally
    FreeAndNil(lForm);
  end;
end;

class function TAjustarVolume.Volume: Integer;
begin
  if FMudo then begin
    Result := 0;
  end else begin
    Result := FVolume;
  end;
end;

class function TAjustarVolume.Mudo: Boolean;
begin
  Result := FMudo;
end;

class procedure TAjustarVolume.ChangeMudo;
begin
  FMudo := not FMudo;

  if FMudo then begin
    SetVolume(0);
  end else begin
    SetVolume(FVolume);
  end;
end;

class procedure TAjustarVolume.InicializarVolume;
begin
  FMudo := False;
  FVolume := 5;
  SetVolume(FVolume);
end;

end.

