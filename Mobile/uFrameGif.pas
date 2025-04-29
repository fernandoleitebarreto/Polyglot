unit uFrameGif;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, UnitPadrao, FMX.Ani, FMX.Objects,
  System.ImageList, FMX.ImgList, FMX.GifUtils, System.IOUtils, System.Skia,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Skia;

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
end;

end.
