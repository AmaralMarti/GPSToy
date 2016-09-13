program GPSToy;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  UDmGpsToy,
  UAjustarVolume,
  UMenuPrincipal,
  UMenuLateral,
  UDesenho,
  USonsAnimais, UControleDesenho;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  TAjustarVolume.InicializarVolume;
  Application.CreateForm(TDmGpsToy, DmGpsToy);
  Application.CreateForm(TMenuPrincipal, MenuPrincipal);
  Application.Run;
end.

