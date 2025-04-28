unit uFrameGif;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, UnitPadrao, FMX.Ani, FMX.Objects,
  System.ImageList, FMX.ImgList, FMX.GifUtils, System.IOUtils;

type
  TFrmPadrao1 = class(TFrmPadrao)
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FGifPlayer: TGifPlayer;
  public
    { Public declarations }
  end;

var
  FrmPadrao1: TFrmPadrao1;

implementation

{$R *.fmx}


procedure TFrmPadrao1.FormCreate(Sender: TObject);
begin
  inherited;
  FGifPlayer := TGifPlayer.Create(Self);
  FGifPlayer.Image := Image1;

  // {$IFDEF MSWINDOWS}
  // // FGifPlayer.LoadFromFile('D:\Sistemas\Delphi\Apps\Polyglot\Fontes\Mobile\Images\loading.gif');
  // // FGifPlayer.LoadFromFile('D:\Sistemas\Delphi\Apps\Polyglot\Fontes\Mobile\Images\Earth-rotating.gif');
  //
  // {$ENDIF}
  // {$IFDEF ANDROID}
  // // FGifPlayer.LoadFromFile(TPath.Combine
  // // (TPath.GetDocumentsPath, 'loading.gif'));
  // FGifPlayer.LoadFromFile(TPath.Combine
  // (TPath.GetDocumentsPath, 'Earth-rotating.gif'));
  // {$ENDIF}
  // if FGifPlayer.IsPlaying then
  // FGifPlayer.Pause
  // else
  // FGifPlayer.Play;
end;

end.
