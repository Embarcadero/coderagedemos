unit CoderageVersionResource;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes;

type
  [ResourceVersion('v1', TEMSVersionStatus.Deprecated)]
  [ResourceName('coderageversion')]
  TCoderageversionResource1 = class(TDataModule)
  published
    procedure Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TCoderageversionResource1.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
begin
  // Sample code
  AResponse.Body.SetValue(TJSONString.Create('CODERAGE VERSION 2024'), True);
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TCoderageversionResource1));
end;

initialization
  Register;
end.


