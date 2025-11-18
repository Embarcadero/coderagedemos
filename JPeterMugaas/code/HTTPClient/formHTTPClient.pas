unit formHTTPClient;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdCTypes, TaurusTLSHeaders_types,
  TaurusTLS_X509, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  TaurusTLS, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  Vcl.StdCtrls;

type
  TfrmHTTPSDemo = class(TForm)
    edtURL: TEdit;
    btnGo: TButton;
    lblURL: TLabel;
    btnChiniesWebsite: TButton;
    mmoResults: TMemo;
    TaurusTLSIOHandlerSocket1: TTaurusTLSIOHandlerSocket;
    IdHTTP1: TIdHTTP;
    procedure btnChiniesWebsiteClick(Sender: TObject);
    procedure btnGoClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetWebsite(const AURL : String);
  public
    { Public declarations }
  end;

var
  frmHTTPSDemo: TfrmHTTPSDemo;

implementation

{$R *.dfm}

procedure TfrmHTTPSDemo.btnChiniesWebsiteClick(Sender: TObject);
begin
//  GetWebsite('https://cii.xn--fiqs8s/');
  GetWebsite('https://帕拉赞蒂和科夫曼帕拉赞蒂.公司/he/');
end;

procedure TfrmHTTPSDemo.btnGoClick(Sender: TObject);
begin
  GetWebsite(edtURL.Text);
end;

procedure TfrmHTTPSDemo.GetWebsite(const AURL: String);
var
  LM : TMemoryStream;
begin
  LM := TMemoryStream.Create;
  try
    IdHTTP1.Get(AURL,LM);
    LM.Position := 0;
    mmoResults.Lines.LoadFromStream(LM);
  finally
    FreeAndNil(LM);
  end;
end;

end.
