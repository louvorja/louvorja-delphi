Do this steps to adapt colors of VTV header to skin colors:

1. Open VirtualTrees.pas, find TVirtualTreeColumns.PaintHeader method and

copy this DrawEdge method to it:

====================================================================================

function DrawEdge(hdc: HDC; var qrc: TRect; edge: UINT; grfFlags: UINT): BOOL;

procedure Frm3D(Canvas: TCanvas; Rect: TRect; TopColor, BottomColor: TColor);

  procedure DoRect;
  var
    TopRight, BottomLeft: TPoint;
  begin
    with Canvas, Rect do
    begin
      TopRight.X := Right;
      TopRight.Y := Top;
      BottomLeft.X := Left;
      BottomLeft.Y := Bottom;
      Pen.Color := TopColor;
      PolyLine([BottomLeft, TopLeft, TopRight]);
      Pen.Color := BottomColor;
      Dec(BottomLeft.X);
      PolyLine([TopRight, BottomRight, BottomLeft]);
    end;
  end;

begin
    Canvas.Pen.Width := 1;
    Dec(Rect.Bottom); Dec(Rect.Right);
    DoRect;
end;

function Darker(Color:TColor; Percent:Byte):TColor;
var
  r, g, b: Byte;
begin
  Color:=ColorToRGB(Color);
  r:=GetRValue(Color);
  g:=GetGValue(Color);
  b:=GetBValue(Color);
  r:=r-muldiv(r,Percent,100);
  g:=g-muldiv(g,Percent,100);
  b:=b-muldiv(b,Percent,100);
  result:=RGB(r,g,b);
end;

function Lighter(Color:TColor; Percent:Byte):TColor;
var
  r, g, b: Byte;
begin
  Color:=ColorToRGB(Color);
  r:=GetRValue(Color);
  g:=GetGValue(Color);
  b:=GetBValue(Color);
  r:=r+muldiv(255-r,Percent,100); 
  g:=g+muldiv(255-g,Percent,100);
  b:=b+muldiv(255-b,Percent,100);
  result:=RGB(r,g,b);
end;


var
  C: TCanvas;
  LightColor, DarkColor: TColor;
  R, G, B: Byte;
begin
  C := TCanvas.Create;
  C.Handle := HDC;
  C.Brush.Color := Self.FHeader.FBackground;
  C.Brush.Style := bsSolid;
  C.FillRect(qrc);
  LightColor := Lighter(C.Brush.Color, 10);
  DarkColor := Darker(C.Brush.Color, 10);
  if edge = BDR_SUNKENOUTER
  then
    begin
      InFlateRect(qrc, -2, -2);
      Frm3D(C, qrc, DarkColor, LightColor);
    end
  else
    Frm3D(C, qrc, LightColor, DarkColor);
  C.Handle := 0;
  C.Free;
end;

====================================================================================

2. Set VTV.Header.Style to 'hsFlatButtons' value.

3. Use TbsaSkinAdapter.OnChangeSkinData event 
   to apply skincolor to VTV.Header.Background and VTV.Header.Font.Color properties:

procedure TForm1.bsaSkinAdapter1ChangeSkinData(Sender: TObject);
begin
  VTV.Header.Background := bsSkinData1.SkinColors.cBtnFace;
  VTV.Header.Font.Color := bsSkinData1.SkinColors.cBtnText;
  // to adapt color of VTV use:
  VTV.Color := bsSkinData1.SkinColors.cWindow; 
end;

