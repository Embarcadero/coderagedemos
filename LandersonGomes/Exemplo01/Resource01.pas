unit Resource01;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes;

type
  [ResourceName('coderage202501')]
  TCoderageResource1 = class(TDataModule)
  published
    procedure Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('{item}')]
    procedure GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    procedure Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('{item}')]
    procedure PutItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('{item}')]
    procedure DeleteItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TCoderageResource1.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
begin
  // Sample code
  AResponse.Body.SetValue(TJSONString.Create('Welcome to CODERAGE 2025 - Sample 01'), True);
end;

procedure TCoderageResource1.GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LItem: string;
begin
  LItem := ARequest.Params.Values['item'];
  // Sample code
  AResponse.Body.SetValue(TJSONString.Create('coderage202501 ' + LItem), True);
end;

procedure TCoderageResource1.Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
begin
  AResponse.Body.SetValue(TJSONString.Create('POST - CODERAGE 2025 - Sample 01'), True);
end;

procedure TCoderageResource1.PutItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LItem: string;
begin
  LItem := ARequest.Params.Values['item'];
  AResponse.Body.SetValue(TJSONString.Create('PUT - CODERAGE 2025 - Sample 01 - ' + LItem), True);
end;

procedure TCoderageResource1.DeleteItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LItem: string;
begin
  LItem := ARequest.Params.Values['item'];
 AResponse.Body.SetValue(TJSONString.Create('DELETE - CODERAGE 2025 - Sample 01 - ' + LItem), True);
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TCoderageResource1));
end;

initialization
  Register;
end.


