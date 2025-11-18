object frmHTTPSDemo: TfrmHTTPSDemo
  Left = 0
  Top = 0
  Caption = 'frmHTTPSDemo'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  DesignSize = (
    624
    441)
  TextHeight = 15
  object lblURL: TLabel
    Left = 80
    Top = 19
    Width = 24
    Height = 15
    Caption = '&URL:'
    FocusControl = edtURL
  end
  object edtURL: TEdit
    Left = 120
    Top = 16
    Width = 385
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object btnGo: TButton
    Left = 528
    Top = 16
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&Go'
    TabOrder = 1
    OnClick = btnGoClick
  end
  object btnChiniesWebsite: TButton
    Left = 8
    Top = 56
    Width = 105
    Height = 25
    Caption = '&Chinies Website'
    TabOrder = 2
    OnClick = btnChiniesWebsiteClick
  end
  object mmoResults: TMemo
    Left = 8
    Top = 96
    Width = 595
    Height = 313
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 3
    WordWrap = False
  end
  object TaurusTLSIOHandlerSocket1: TTaurusTLSIOHandlerSocket
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 100
    Left = 288
    Top = 200
  end
  object IdHTTP1: TIdHTTP
    IOHandler = TaurusTLSIOHandlerSocket1
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 176
    Top = 200
  end
end
