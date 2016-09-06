unit UDmGpsToy;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Controls, Forms, IniFiles, Buttons, Dialogs;

type
  TDmGpsToy = class(TDataModule)
    lstIcones: TImageList;
    procedure DataModuleCreate(Sender: TObject);
  private
    FCaminhoAplicacao: String;
    FCaminhoArquivosSom: String;
    FSomGato: String;
    FSomVaca: String;
    FSomPato: String;
    FSomCachorro: String;
    FSomGalo: String;
    FSomCavalo: String;
    procedure CriarArquivoIniPadrao;
  public
    property CaminhoAplicacao: String read FCaminhoAplicacao;
    property CaminhoArquivosSom: String read FCaminhoArquivosSom;
    property SomGato: String read FSomGato;
    property SomVaca: String read FSomVaca;
    property SomPato: String read FSomPato;
    property SomCachorro: String read FSomCachorro;
    property SomGalo: String read FSomGalo;
    property SomCavalo: String read FSomCavalo;

    procedure InicializaForm(const pForm: TForm);
  end;

const
  {$Region 'Constantes referentes ao ARQUIVO INI'}
  ARQUIVO_INI = 'GpsToy.ini';
  SECTION_CONFIG = 'CONFIG';
  VALUE_PASTA_SONS = 'pasta_arquivos_sons';
  VALUE_ARQUIVO_SOM_GATO = 'arquivo_som_gato';
  VALUE_ARQUIVO_SOM_VACA = 'arquivo_som_vaca';
  VALUE_ARQUIVO_SOM_PATO = 'arquivo_som_pato';
  VALUE_ARQUIVO_SOM_CACHORRO = 'arquivo_som_cachorro';
  VALUE_ARQUIVO_SOM_GALO = 'arquivo_som_galo';
  VALUE_ARQUIVO_SOM_CAVALO = 'arquivo_som_cavalo';
  DEFAULT_PASTA_SONS = 'Sons';
  DEFAULT_SOM_GATO = 'gato.wav';
  DEFAULT_SOM_VACA = 'vaca.wav';
  DEFAULT_SOM_PATO = 'pato.wav';
  DEFAULT_SOM_CACHORRO = 'cachorro.wav';
  DEFAULT_SOM_GALO = 'galo.wav';
  DEFAULT_SOM_CAVALO = 'cavalo.wav';
  {$EndRegion}

  {$Region 'Constantes referentes às DIMENSÕES DE TELA'}
  LARGURA_TELA = 800;
  ALTURA_TELA = 480;
  LARGURA_MENU = 123;
  {$EndRegion}

  {$Region 'Constantes referentes ao POSICIONAMENTO DO MENU LATERAL'}
  ALTURA_MENU = ALTURA_TELA;
  POSICAO_MENU_VISIVEL = LARGURA_TELA - LARGURA_MENU;
  POSICAO_MENU_OCULTO = LARGURA_TELA + 1;
  {$EndRegion}

  {$Region 'Constantes referentes aos INDICES DOS ICONES'}
  ICONE_MENU = 0;
  ICONE_TRAVA_OFF = 1;
  ICONE_TRAVA_ON = 2;
  ICONE_MUDO_OFF = 3;
  ICONE_MUDO_ON = 4;
  ICONE_BRILHO_FRACO = 5;
  ICONE_BRILHO_MEDIO = 6;
  ICONE_BRILHO_FORTE = 7;
  {$EndRegion}

var
  DmGpsToy: TDmGpsToy;

implementation

{$R *.lfm}

{ TDmGpsToy }

procedure TDmGpsToy.DataModuleCreate(Sender: TObject);
var
  lArquivoIni: TIniFile;
  lPastaArquivosSom, lArquivoSomGato, lArquivoSomVaca, lArquivoSomPato,
  lArquivoSomCachorro, lArquivoSomGalo, lArquivoSomCavalo: String;
begin
  // Carrega o PATH atual da aplicação
  FCaminhoAplicacao := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));

  // Se não existir um ARQUIVO INI no PATH da aplicação, cria o arquivo padrão do GpsToy
  CriarArquivoIniPadrao;

  // Carrega os parâmetros do ARQUIVO INI
  lArquivoIni := TIniFile.Create(CaminhoAplicacao + ARQUIVO_INI);
  try
    lPastaArquivosSom := lArquivoIni.ReadString(SECTION_CONFIG, VALUE_PASTA_SONS, DEFAULT_PASTA_SONS);
    lArquivoSomGato := lArquivoIni.ReadString(SECTION_CONFIG, VALUE_ARQUIVO_SOM_GATO, DEFAULT_SOM_GATO);
    lArquivoSomVaca := lArquivoIni.ReadString(SECTION_CONFIG, VALUE_ARQUIVO_SOM_VACA, DEFAULT_SOM_VACA);
    lArquivoSomPato := lArquivoIni.ReadString(SECTION_CONFIG, VALUE_ARQUIVO_SOM_PATO, DEFAULT_SOM_PATO);
    lArquivoSomCachorro := lArquivoIni.ReadString(SECTION_CONFIG, VALUE_ARQUIVO_SOM_CACHORRO, DEFAULT_SOM_CACHORRO);
    lArquivoSomGalo := lArquivoIni.ReadString(SECTION_CONFIG, VALUE_ARQUIVO_SOM_GALO, DEFAULT_SOM_GALO);
    lArquivoSomCavalo := lArquivoIni.ReadString(SECTION_CONFIG, VALUE_ARQUIVO_SOM_CAVALO, DEFAULT_SOM_CAVALO);
  finally
    FreeAndNil(lArquivoIni);
  end;

  // Carrega o PATH dos ARQUIVOS DE SOM (se a pasta não existir ela será criada)
  FCaminhoArquivosSom := IncludeTrailingPathDelimiter(CaminhoAplicacao + lPastaArquivosSom);
  ForceDirectory(CaminhoArquivosSom);

  // Carrega o nome dos ARQUIVOS DE SOM para uso posterior via as propriedades
  FSomGato := FCaminhoArquivosSom + lArquivoSomGato;
  FSomVaca := FCaminhoArquivosSom + lArquivoSomVaca;
  FSomPato := FCaminhoArquivosSom + lArquivoSomPato;
  FSomCachorro := FCaminhoArquivosSom + lArquivoSomCachorro;
  FSomGalo := FCaminhoArquivosSom + lArquivoSomGalo;
  FSomCavalo := FCaminhoArquivosSom + lArquivoSomCavalo;
end;

// Criando automaticamente o ARQUIVO INI no PATH da aplicação eu evito erros pela falta do arquivo e retiro do usuário a responsabilidade
// de ter que copiá-lo e colocá-lo na pasta. Para o usuário só fica a tarefa de editá-lo, isso se ele quiser customizar alguma coisa.
procedure TDmGpsToy.CriarArquivoIniPadrao;
var
  lArquivoIni: TIniFile;
begin
  if not FileExists(CaminhoAplicacao + ARQUIVO_INI) then begin
    lArquivoIni := TIniFile.Create(FCaminhoAplicacao + ARQUIVO_INI);
    try
      lArquivoIni.WriteString(SECTION_CONFIG, VALUE_PASTA_SONS, DEFAULT_PASTA_SONS);
      lArquivoIni.WriteString(SECTION_CONFIG, VALUE_ARQUIVO_SOM_GATO, DEFAULT_SOM_GATO);
      lArquivoIni.WriteString(SECTION_CONFIG, VALUE_ARQUIVO_SOM_VACA, DEFAULT_SOM_VACA);
      lArquivoIni.WriteString(SECTION_CONFIG, VALUE_ARQUIVO_SOM_PATO, DEFAULT_SOM_PATO);
      lArquivoIni.WriteString(SECTION_CONFIG, VALUE_ARQUIVO_SOM_CACHORRO, DEFAULT_SOM_CACHORRO);
      lArquivoIni.WriteString(SECTION_CONFIG, VALUE_ARQUIVO_SOM_GALO, DEFAULT_SOM_GALO);
      lArquivoIni.WriteString(SECTION_CONFIG, VALUE_ARQUIVO_SOM_CAVALO, DEFAULT_SOM_CAVALO);
    finally
      FreeAndNil(lArquivoIni);
    end;
  end;
end;

procedure TDmGpsToy.InicializaForm(const pForm: TForm);
var
  lBotaoMenu: TSpeedButton;
begin
  with pForm do begin
    // Configura manualmente o Form para ocupar a tela inteira (poderia deixar automático, mas quero forçar 800x480)
    Top := 0;
    Left := 0;
    Width := LARGURA_TELA;
    Height := ALTURA_TELA;

    // Configura o botão de menu, que fica no canto superior direito da tela
    lBotaoMenu := TSpeedButton(pForm.FindComponent('btnMenu'));
    if Assigned(lBotaoMenu) then begin
      lBotaoMenu.Top := 5;
      lBotaoMenu.Left := LARGURA_TELA - lBotaoMenu.Width - 5;
      lBotaoMenu.Flat := True;
      lstIcones.GetBitmap(ICONE_MENU, lBotaoMenu.Glyph);
    end;

    // Joga o Form para exibição em primeiro plano
    BringToFront;
  end;
end;

end.

