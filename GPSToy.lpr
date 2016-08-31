program GPSToy;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  UDmImagens,
  UMenuPrincipal,
  UMenuLateral,
  UDesenho,
  UAjustarVolume;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  TAjustarVolume.InicializarVolume;
  Application.CreateForm(TMenuPrincipal, MenuPrincipal);
  Application.CreateForm(TDmImagens, DmImagens);
  Application.Run;
end.

