unit hashdemoform;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  System.ImageList, Vcl.ImgList;

type
  TfrmHash = class(TForm)
    lblFileName: TLabel;
    edtFileName: TEdit;
    odlgFileName: TOpenDialog;
    SpeedButton1: TSpeedButton;
    imglstProgram: TImageList;
    btnHash: TButton;
    mmoResults: TMemo;
    procedure btnHashClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHash: TfrmHash;

implementation
uses
  IdHash,
  IdHashSHA,
  {This unit self-registers hash algorithms.}
  TaurusTLSFIPS,
  {required to load OpenSSL through documented
  GetOpenSSLLoader.Load method}
  TaurusTLSLoader;

const
  Hashes : array[0..3] of TIdHashClass = (TIdHashSHA512, TIdHashSHA384,
    TIdHashSHA256, TIdHashSHA224);
  Hashes_str : array[0..3] of string = ('SHA512','SHA384',
    'SHA256', 'SHA224');

{$R *.dfm}

procedure TfrmHash.btnHashClick(Sender: TObject);
var
  LH : TIdHash;
  LF : TStream;
  i : Integer;
begin
  mmoResults.Lines.Clear;
  if not GetOpenSSLLoader.Load then
  begin
    mmoResults.Lines.Add('OpenSSL not loaded.');
  end;
  for i := Low(Hashes) to High(Hashes) do
  begin
    if Hashes[i].IsAvailable then
    begin
      LH := Hashes[i].Create;
      try
        LF := TFileStream.Create( Self.edtFileName.Text, fmOpenRead or fmShareDenyNone );
        try
          mmoResults.Lines.Add( Hashes_str[i] + ' Checksum: '+ LH.HashStreamAsHex(LF));
        finally
          FreeAndNil(LF);
        end;
      finally
        FreeAndNil(LH);
      end;
    end;
  end;
end;

procedure TfrmHash.SpeedButton1Click(Sender: TObject);
begin
  if odlgFileName.Execute then
  begin
     edtFileName.Text := odlgFileName.FileName;
  end;
end;

end.
