unit CodeRage2025Resource;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes;

type
  [ResourceVersion('v2', TEMSVersionStatus.Default)]
  [ResourceName('coderageversion')]
  TCoderageResource1 = class(TDataModule)
  published
    procedure Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TCoderageResource1.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
begin
  // Sample code
  AResponse.Body.SetValue(TJSONString.Create('CODERAGE VERSION 2025'), True);
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TCoderageResource1));
end;

initialization
  Register;
end.


