{*******************************************************************}
{                                                                   }
{       SkinAdapter                                                 }
{       BusinessSkinForm                                            }
{       Version 5.25                                                }
{                                                                   }
{       Copyright (c) 2005-2012 Almediadev                          }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{       Home:  http://www.almdev.com                                }
{       Support: support@almdev.com                                 }
{                                                                   }
{*******************************************************************}

unit bsaDevExSkin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs{$IFNDEF DELPHI5},Types{$ENDIF},
  cxLookAndFeelPainters, cxGraphics, cxClasses, ImgList, dxCore, bsSkinData;

type

  { TcxbsaLookAndFeelPainter }
  TcxbsaLookAndFeelPainter = class(TcxStandardLookAndFeelPainter)
  protected
    function FilterDropDownButtonBorderColor(AState: TcxButtonState): TColor; virtual;
    function TabBorderHighlightColor: TColor; virtual;
    function TabBorderDarkColor: TColor; virtual;
  public
    function LookAndFeelName: string; override;
    function LookAndFeelStyle: TcxLookAndFeelStyle; override;
    function DefaultSelectionColor: TColor; override;
    function DefaultSelectionTextColor: TColor; override;
    function DefaultInactiveColor: TColor; override;
    function DefaultInactiveTextColor: TColor; override;
    function DefaultDateNavigatorHeaderColor: TColor; override;
    function DefaultDateNavigatorSelectionColor: TColor; override;
    function DefaultDateNavigatorSelectionTextColor: TColor; override;
    function DefaultFilterBoxColor: TColor; override;
    function DefaultFilterBoxTextColor: TColor; override;
    function DefaultHeaderBackgroundColor: TColor; override;
    function DefaultHeaderBackgroundTextColor: TColor; override;
    function DefaultHeaderColor: TColor; override;
    function DefaultHeaderTextColor: TColor; override;
    function DefaultSchedulerBorderColor: TColor; override;
    function DefaultGroupColor: TColor; override;
    function DefaultGroupTextColor: TColor; override;
    function DefaultContentColor: TColor; override;
    function DefaultContentTextColor: TColor; override;
    function DefaultGroupByBoxColor: TColor; override;
    function DefaultGroupByBoxTextColor: TColor; override;
    function DefaultFooterColor: TColor; override;
    function DefaultFooterTextColor: TColor; override;
    function DefaultGridLineColor: TColor; override;
    function FooterSeparatorColor: TColor; override;
    function DefaultSizeGripAreaColor: TColor; override;
    function CheckButtonColor(AState: TcxButtonState): TColor; override;

    function DefaultEditorBackgroundColor(AIsDisabled: Boolean): TColor; override;
    function DefaultEditorBackgroundColorEx(AKind: TcxEditStateColorKind): TColor; override;
    function DefaultEditorTextColor(AIsDisabled: Boolean): TColor; override;
    function DefaultEditorTextColorEx(AKind: TcxEditStateColorKind): TColor; override;

    procedure DrawRadioButton(ACanvas: TcxCanvas; X, Y: Integer;
      AButtonState: TcxButtonState; AChecked, AFocused: Boolean;
      ABrushColor: TColor;  AIsDesigning: Boolean = False); override;
    function RadioButtonBodyColor(AState: TcxButtonState): TColor; override;
    function RadioButtonSize: TSize; override;

    procedure DrawCheckButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState;
      AChecked: Boolean); override;
    procedure DrawCheckButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState;
      ACheckState: TcxCheckBoxState); overload; override;
    function CheckButtonSize: TSize; override;   

    function BorderHighlightColor: TColor; virtual;
    function BorderSize: Integer; override;
    procedure DrawBorder(ACanvas: TcxCanvas; R: TRect); override;
    procedure DrawContainerBorder(ACanvas: TcxCanvas; const R: TRect; AStyle: TcxContainerBorderStyle;
      AWidth: Integer; AColor: TColor; ABorders: TcxBorders); override;
    function ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer; override;
    function ButtonColor(AState: TcxButtonState): TColor; override;
    function ButtonFocusRect(ACanvas: TcxCanvas; R: TRect): TRect; override;
    function ButtonSymbolColor(AState: TcxButtonState;
      ADefaultColor: TColor = clDefault): TColor; override;
    function ButtonSymbolState(AState: TcxButtonState): TcxButtonState; override;
    function ButtonTextOffset: Integer; override;
    function ButtonTextShift: Integer; override;
    procedure DrawButtonBorder(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    procedure DrawSmallExpandButton(ACanvas: TcxCanvas; R: TRect; AExpanded: Boolean;
      ABorderColor: TColor; AColor: TColor = clDefault); override;
    procedure DrawExpandButton(ACanvas: TcxCanvas; const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault); override;
    procedure DrawHeaderControlSectionBorder(ACanvas: TcxCanvas; const R: TRect;
      ABorders: TcxBorders; AState: TcxButtonState); override;
    procedure DrawHeaderControlSectionContent(ACanvas: TcxCanvas; const ABounds,
      ATextAreaBounds: TRect; AState: TcxButtonState; AAlignmentHorz: TAlignment;
      AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor); override;
    function ExpandButtonSize: Integer; override;
    function IsButtonHotTrack: Boolean; override;
    procedure DrawButton(ACanvas: TcxCanvas; R: TRect; const ACaption: string;
      AState: TcxButtonState; ADrawBorder: Boolean = True; AColor: TColor = clDefault;
      ATextColor: TColor = clDefault; AWordWrap: Boolean = False; AIsToolButton: Boolean = False); override;
    procedure DrawCheckBorder(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    procedure DrawHeaderPressed(ACanvas: TcxCanvas;
     const ABounds: TRect); override;
    procedure DrawHeader(ACanvas: TcxCanvas;
     const ABounds, ATextAreaBounds: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders;
      AState: TcxButtonState; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
      AMultiLine, AShowEndEllipsis: Boolean; const AText: string; AFont: TFont;
      ATextColor, ABkColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil;
      AIsLast: Boolean = False; AIsGroup: Boolean = False); override;

    procedure DrawContent1(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect; AState: Integer;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsFooter: Boolean = False);

    procedure DrawHeaderBorder(ACanvas: TcxCanvas; const R: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders); override;
    procedure DrawHeaderEx(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
      ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil); override;
    procedure DrawSortingMark(ACanvas: TcxCanvas; const R: TRect; AAscendingSorting: Boolean); override;
    function HeaderBorders(ANeighbors: TcxNeighbors): TcxBorders; override;
    function HeaderBorderSize: Integer; override;
    function SortingMarkSize: TPoint; override;
    procedure DrawFooterBorder(ACanvas: TcxCanvas; const R: TRect); override;
    procedure DrawFooterCellBorder(ACanvas: TcxCanvas; const R: TRect); override;
    function FooterBorders: TcxBorders; override;
    function FooterBorderSize: Integer; override;
    function FooterCellBorderSize: Integer; override;
    function FooterCellOffset: Integer; override;
    procedure DrawFilterCloseButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    procedure DrawFilterDropDownButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean); override;
    function FilterCloseButtonSize: TPoint; override;
    procedure DrawTab(ACanvas: TcxCanvas; R: TRect; ABorders: TcxBorders;
      const AText: string; AState: TcxButtonState; AVertical: Boolean; AFont: TFont;
      ATextColor, ABkColor: TColor; AShowPrefix: Boolean = False); override;
    function DefaultTabColor: TColor; override;
    function DefaultTabTextColor: TColor; override;
    function DefaultTabsBackgroundColor: TColor; override;
    procedure DrawTabBorder(ACanvas: TcxCanvas; R: TRect; ABorder: TcxBorder; ABorders: TcxBorders; AVertical: Boolean); override;
    procedure DrawTabsRoot(ACanvas: TcxCanvas; const R: TRect; ABorders: TcxBorders; AVertical: Boolean); override;
    function TabBorderSize(AVertical: Boolean): Integer; override;
    procedure DrawScrollBarPart(ACanvas: TcxCanvas; AHorizontal: Boolean;
      R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState); override;
    procedure DrawSchedulerNavigatorButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    procedure DrawSchedulerSplitterBorder(ACanvas: TcxCanvas; R: TRect; const AViewParams: TcxViewParams; AIsHorizontal: Boolean); override;
    procedure DrawEditorButton(ACanvas: TcxCanvas; const ARect: TRect;
      AButtonKind: TcxEditBtnKind; AState: TcxButtonState;
      APosition: TcxEditBtnPosition = cxbpRight); override;
  end;

  var
    DevExSkinData: TbsSkinData = nil;

implementation

uses
  cxControls, cxLookAndFeels, dxSkinInfo,
    dxThemeConsts, Math, cxDrawTextUtils, bsUtils, bsEffects;

const
  s_BSFSkin = 'BSFSkin';

  FilterDropDownButtonWidth = 15;

  SortingMarkAreaWidth = 16;
  FilterActiveButtonWidth = 13;
  FilterActiveButtonHeight = 13;
  FilterCloseButtonWidth = 16;
  FilterCloseButtonHeight = 14;

  ActiveFilterButtonArrowColor = clBlue;

var
  StdScrollBitmaps: array[Boolean] of TBitmap;

procedure DrawSkinButton(ASkinDataName: String; Buffer: TBitMap; AState: TcxButtonState; var ATextColor: TColor);
var
  I, XO, YO: Integer;
  R, NewClRect: TRect;
  ButtonData: TbsDataSkinButtonControl;
  NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
  FSkinPicture: TBitMap;
begin
 I := DevExSkinData.GetControlIndex(ASkinDataName);
 if I = -1 then
   I := DevExSkinData.GetControlIndex('resizebutton');
 if I <> -1 then ButtonData := TbsDataSkinButtonControl(DevExSkinData.CtrlList[I]) else Exit;
 R := Rect(0, 0, Buffer.Width, Buffer.Height);
 with ButtonData do
 begin
    XO := RectWidth(R) - RectWidth(SkinRect);
    YO := RectHeight(R) - RectHeight(SkinRect);
    NewLTPoint := LTPoint;
    NewRTPoint := Point(RTPoint.X + XO, RTPoint.Y);
    NewLBPoint := Point(LBPoint.X, LBPoint.Y + YO);
    NewRBPoint := Point(RBPoint.X + XO, RBPoint.Y + YO);
    NewClRect := Rect(CLRect.Left, ClRect.Top, CLRect.Right + XO, ClRect.Bottom + YO);
    FSkinPicture := TBitMap(DevExSkinData.FActivePictures.Items[ButtonData.PictureIndex]);
    case AState of
      cxbsDefault, cxbsNormal, cxbsDisabled:
        begin
          CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
            NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
            Buffer, FSkinPicture, SkinRect, Buffer.Width, Buffer.Height, True,
            LeftStretch, TopStretch, RightStretch, BottomStretch,
            StretchEffect, StretchType);
          ATextColor := FontColor;
          if AState = cxbsDisabled then ATextColor := DisabledFontColor;
        end;
      cxbsHot:
        begin
          R := ActiveSkinRect;
          if IsNullRect(R) then R := SkinRect;
          CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
            NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
            Buffer, FSkinPicture, R, Buffer.Width, Buffer.Height, True,
            LeftStretch, TopStretch, RightStretch, BottomStretch,
            StretchEffect, StretchType);
          ATextColor := ActiveFontColor;
        end;
      cxbsPressed:
        begin
          R := DownSkinRect;
          if IsNullRect(R) then R := ActiveSkinRect;
          if IsNullRect(R) then R := SkinRect;
          CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
            NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
            Buffer, FSkinPicture, R, Buffer.Width, Buffer.Height, True,
            LeftStretch, TopStretch, RightStretch, BottomStretch,
            StretchEffect, StretchType);
          ATextColor := DownFontColor;
        end;
    end;
  end;
end;

function TcxbsaLookAndFeelPainter.LookAndFeelName: string;
begin
  Result := s_BSFSkin;
end;

function TcxbsaLookAndFeelPainter.LookAndFeelStyle: TcxLookAndFeelStyle;
begin
  Result := lfsSkin;
end;

function TcxbsaLookAndFeelPainter.DefaultEditorBackgroundColor(AIsDisabled: Boolean): TColor;
begin
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    Result := DevExSkindata.SkinColors.cWindow
  else
    Result := clWindow;
end;

function TcxbsaLookAndFeelPainter.DefaultEditorBackgroundColorEx(AKind: TcxEditStateColorKind): TColor; 
begin
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    Result := DevExSkindata.SkinColors.cWindow
  else
    Result := clWindow;
end;

function TcxbsaLookAndFeelPainter.DefaultEditorTextColor(AIsDisabled: Boolean): TColor;
begin
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    Result := DevExSkindata.SkinColors.cWindowText
  else
    Result := clWindowText;
end;

function TcxbsaLookAndFeelPainter.DefaultEditorTextColorEx(AKind: TcxEditStateColorKind): TColor;
begin
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    Result := DevExSkindata.SkinColors.cWindowText
  else
    Result := clWindowText;
end;

function TcxbsaLookAndFeelPainter.DefaultSelectionTextColor: TColor;
begin
   if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    Result := DevExSkindata.SkinColors.cHighLightText
  else
    Result := clHighlightText;
end;

function TcxbsaLookAndFeelPainter.DefaultSelectionColor: TColor;
begin
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    Result := DevExSkindata.SkinColors.cHighLight
  else
    Result := clHighlight;
end;

function TcxbsaLookAndFeelPainter.DefaultInactiveColor: TColor;
begin
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    Result := DevExSkindata.SkinColors.cBtnFace
  else
    Result := clBtnFace;
end;

function TcxbsaLookAndFeelPainter.DefaultInactiveTextColor: TColor;
begin
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    Result := DevExSkindata.SkinColors.cBtnText
  else
    Result := clBtnText;
end;

procedure TcxbsaLookAndFeelPainter.DrawEditorButton(ACanvas: TcxCanvas; const ARect: TRect;
      AButtonKind: TcxEditBtnKind; AState: TcxButtonState;
      APosition: TcxEditBtnPosition = cxbpRight);

procedure DrawEllipsis(ACanvas: TCanvas; R: TRect; AColor: TColor);
var
  X, Y: Integer;
begin
  X := R.Left + RectWidth(R) div 2 - 5;
  Y := R.Top + RectHeight(R) div 2 - 1;
  ACanvas.Brush.Color := AColor;
  ACanvas.Brush.Style := bsSolid;
  ACanvas.FillRect(Rect(X, Y, X + 2, Y + 2));
  ACanvas.FillRect(Rect(X + 2 + 2, Y, X + 2 * 2 + 2, Y + 2));
  ACanvas.FillRect(Rect(X + 2 * 2 + 4, Y, X + 2 * 3 + 4, Y + 2));
end;

var
  Buffer: TBitmap;
  C: TColor;
  R: TRect;
begin
   Buffer := TBitMap.Create;
   Buffer.Width := RectWidth(ARect);
   Buffer.Height := RectHeight(ARect);
   if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
   then
     DrawSkinButton('combobutton', Buffer, AState, C)
   else
     with Buffer.Canvas do
     begin
       Brush.Color := clBtnFace;
       FillRect(Rect(0, 0, Buffer.Width, Buffer.Height));
       C := clBtnText;
     end;
  R := Rect(0, 0, Buffer.Width, Buffer.Height);   
  case AButtonKind of
   cxbkComboBtn:
     bsUtils.DrawArrowImage(Buffer.Canvas, R, C, 4);
   cxbkSpinUpBtn:
     bsUtils.DrawArrowImage(Buffer.Canvas, R, C, 3);
   cxbkSpinDownBtn:
     bsUtils.DrawArrowImage(Buffer.Canvas, R, C, 4);
   cxbkSpinLeftBtn:
     bsUtils.DrawArrowImage(Buffer.Canvas, R, C, 1);
   cxbkSpinRightBtn:
     bsUtils.DrawArrowImage(Buffer.Canvas, R, C, 2);
   cxbkEllipsisBtn:
     DrawEllipsis(Buffer.Canvas, R, C);
  end; 
  ACanvas.Draw(ARect.Left, ARect.Top, Buffer);
  Buffer.Free;
end;

procedure TcxbsaLookAndFeelPainter.DrawTab(ACanvas: TcxCanvas; R: TRect; ABorders: TcxBorders;
      const AText: string; AState: TcxButtonState; AVertical: Boolean; AFont: TFont;
     ATextColor, ABkColor: TColor; AShowPrefix: Boolean = False);
begin
  inherited;
end;

function TcxbsaLookAndFeelPainter.DefaultTabColor: TColor;
begin
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    Result := DevExSkindata.SkinColors.cBtnFace
  else
    Result := inherited DefaultTabColor;
end;

function TcxbsaLookAndFeelPainter.DefaultTabTextColor: TColor;
begin
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    Result := DevExSkindata.SkinColors.cBtnText
  else
    Result := inherited DefaultTabTextColor;
end;

function TcxbsaLookAndFeelPainter.DefaultTabsBackgroundColor: TColor;
begin
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    Result := DevExSkindata.SkinColors.cBtnFace
  else
    Result := inherited DefaultTabsBackgroundColor;
end;

function TcxbsaLookAndFeelPainter.DefaultDateNavigatorHeaderColor: TColor;
begin
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    Result := DevExSkindata.SkinColors.cBtnFace
  else
    Result := inherited DefaultDateNavigatorHeaderColor;
end;


function TcxbsaLookAndFeelPainter.DefaultSizeGripAreaColor: TColor;
begin
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    Result := DevExSkindata.SkinColors.cBtnFace
  else
    Result := inherited DefaultSizeGripAreaColor;
end;

function TcxbsaLookAndFeelPainter.FooterSeparatorColor: TColor;
begin
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    Result := DevExSkindata.SkinColors.cBtnHighlight
  else
    Result := inherited  FooterSeparatorColor;
end;

function TcxbsaLookAndFeelPainter.DefaultDateNavigatorSelectionColor: TColor;
begin
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    Result := DevExSkindata.SkinColors.cHighlight
  else
    Result := clHighlight;
end;

function TcxbsaLookAndFeelPainter.DefaultDateNavigatorSelectionTextColor: TColor;
begin
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    Result := DevExSkindata.SkinColors.cHighlightText
  else
    Result := clHighlightText;
end;

procedure TcxbsaLookAndFeelPainter.DrawSmallExpandButton(ACanvas: TcxCanvas;
  R: TRect; AExpanded: Boolean; ABorderColor: TColor; AColor: TColor = clDefault);
begin
  DrawExpandButton(ACanvas, R, AExpanded, AColor);
end;

procedure TcxbsaLookAndFeelPainter.DrawFilterCloseButton(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState);
var
  Buffer: TBitMap;
  C: TColor;
begin
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := RectWidth(R);
      Buffer.Height := RectHeight(R);
      DrawSkinButton('resizebutton', Buffer, AState, C);
      ACanvas.Draw(R.LEft, R.Top, Buffer);
      DrawButtonCross(ACanvas, R, C, ButtonSymbolState(AState));
      Buffer.Free;
    end
   else
     inherited;
end;

procedure TcxbsaLookAndFeelPainter.DrawRadioButton(ACanvas: TcxCanvas; X, Y: Integer;
      AButtonState: TcxButtonState; AChecked, AFocused: Boolean;
      ABrushColor: TColor;  AIsDesigning: Boolean = False);

procedure SkinDrawCheckImage(X, Y: Integer; Cnvs: TCanvas; IR: TRect; DestCnvs: TCanvas);
var
  B: TBitMap;
begin
  B := TBitMap.Create;
  B.Width := RectWidth(IR);
  B.Height := RectHeight(IR);
  B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), Cnvs, IR);
  B.Transparent := True;
  DestCnvs.Draw(X, Y, B);
  B.Free;
end;

var
  I: Integer;
  ButtonData: TbsDataSkinCheckRadioControl;
  Picture: TBitmap;
begin
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    begin
      I := DevExSkinData.GetControlIndex('radiobox');
      if I <> -1 then ButtonData := TbsDataSkinCheckRadioControl(DevExSkinData.CtrlList[I]) else Exit;
      Picture := TBitMap(DevExSkinData.FActivePictures.Items[ButtonData.PictureIndex]);
      if AChecked then
       case AButtonState of
         cxbsNormal:
           SkinDrawCheckImage(X, Y, Picture.Canvas, ButtonData.CheckImageRect,
             ACanvas.Canvas);
         cxbsHot, cxbsPressed:
           if not IsNullRect(ButtonData.ActiveCheckImageRect)
           then
             SkinDrawCheckImage(X, Y, Picture.Canvas, ButtonData.ActiveCheckImageRect,
               ACanvas.Canvas)
           else
             SkinDrawCheckImage(X, Y, Picture.Canvas, ButtonData.CheckImageRect,
             ACanvas.Canvas);
       end
     else
       case AButtonState of
         cxbsNormal:
           SkinDrawCheckImage(X, Y, Picture.Canvas, ButtonData.UnCheckImageRect,
             ACanvas.Canvas);
         cxbsHot, cxbsPressed:
           if not IsNullRect(ButtonData.ActiveCheckImageRect)
           then
             SkinDrawCheckImage(X, Y, Picture.Canvas, ButtonData.ActiveUnCheckImageRect,
               ACanvas.Canvas)
           else
             SkinDrawCheckImage(X, Y, Picture.Canvas, ButtonData.UnCheckImageRect,
             ACanvas.Canvas);
       end;
    end
  else
    inherited;
end;

function TcxbsaLookAndFeelPainter.RadioButtonBodyColor(AState: TcxButtonState): TColor;
begin
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    Result := DevExSkindata.SkinColors.cBtnFace
  else
    Result := inherited RadioButtonBodyColor(AState);
end;

function TcxbsaLookAndFeelPainter.RadioButtonSize: TSize;
var
  I: Integer;
  ButtonData: TbsDataSkinCheckRadioControl;
begin
  Result := inherited RadioButtonSize;
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    begin
      I := DevExSkinData.GetControlIndex('radiobox');
      if I <> -1 then ButtonData := TbsDataSkinCheckRadioControl(DevExSkinData.CtrlList[I]) else Exit;
      with ButtonData do
      begin
        Result.cx := RectWidth(CheckImageRect);
        Result.cy := RectHeight(CheckImageRect);
      end;
    end;
end;

function TcxbsaLookAndFeelPainter.CheckButtonSize: TSize; 
var
  I: Integer;
  ButtonData: TbsDataSkinCheckRadioControl;
begin
  Result := inherited CheckButtonSize;
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    begin
      I := DevExSkinData.GetControlIndex('checkbox');
      if I <> -1 then ButtonData := TbsDataSkinCheckRadioControl(DevExSkinData.CtrlList[I]) else Exit;
      with ButtonData do
      begin
        Result.cx := RectWidth(CheckImageRect);
        Result.cy := RectHeight(CheckImageRect);
      end;
    end;
end;


procedure TcxbsaLookAndFeelPainter.DrawCheckButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState;
      ACheckState: TcxCheckBoxState);

procedure SkinDrawCheckImage(X, Y: Integer; Cnvs: TCanvas; IR: TRect; DestCnvs: TCanvas);
var
  B: TBitMap;
begin
  B := TBitMap.Create;
  B.Width := RectWidth(IR);
  B.Height := RectHeight(IR);
  B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), Cnvs, IR);
  B.Transparent := True;
  DestCnvs.Draw(X, Y, B);
  B.Free;
end;

procedure SkinDrawCheckImageGrayed(X, Y: Integer; Cnvs: TCanvas; IR: TRect; DestCnvs: TCanvas);
var
  B: TBitMap;
  Buffer: TbsEffectBmp;
begin
  B := TBitMap.Create;
  B.Width := RectWidth(IR);
  B.Height := RectHeight(IR);
  B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), Cnvs, IR);
  //
  B.Width := RectWidth(IR);
  B.Height := RectHeight(IR);
  B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), Cnvs, IR);
  Buffer := TbsEffectBmp.CreateFromhWnd(B.Handle);
  Buffer.ChangeBrightness(0.5);
  Buffer.Draw(B.Canvas.Handle, 0, 0);
  Buffer.Free;
  //
  B.Transparent := True;
  DestCnvs.Draw(X, Y, B);
  B.Free;
end;

var
  I: Integer;
  ButtonData: TbsDataSkinCheckRadioControl;
  Picture: TBitmap;
begin
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    begin
      I := DevExSkinData.GetControlIndex('checkbox');
      if I <> -1 then ButtonData := TbsDataSkinCheckRadioControl(DevExSkinData.CtrlList[I]) else Exit;
      Picture := TBitMap(DevExSkinData.FActivePictures.Items[ButtonData.PictureIndex]);
      if ACheckState = cbsChecked then
       case AState of
         cxbsNormal:
           SkinDrawCheckImage(R.Left, R.Top, Picture.Canvas, ButtonData.CheckImageRect,
             ACanvas.Canvas);
         cxbsHot, cxbsPressed:
           if not IsNullRect(ButtonData.ActiveCheckImageRect)
           then
             SkinDrawCheckImage(R.Left, R.Top, Picture.Canvas, ButtonData.ActiveCheckImageRect,
               ACanvas.Canvas)
           else
             SkinDrawCheckImage(R.Left, R.Top, Picture.Canvas, ButtonData.CheckImageRect,
             ACanvas.Canvas);
       end
     else
     if ACheckState = cbsUnChecked then
       case AState of
         cxbsNormal:
           SkinDrawCheckImage(R.Left, R.Top, Picture.Canvas, ButtonData.UnCheckImageRect,
             ACanvas.Canvas);
         cxbsHot, cxbsPressed:
           if not IsNullRect(ButtonData.ActiveCheckImageRect)
           then
             SkinDrawCheckImage(R.Left, R.Top, Picture.Canvas, ButtonData.ActiveUnCheckImageRect,
               ACanvas.Canvas)
           else
             SkinDrawCheckImage(R.Left, R.Top, Picture.Canvas, ButtonData.UnCheckImageRect,
             ACanvas.Canvas);
       end
     else
     if ACheckState = cbsGrayed then
      case AState of
         cxbsNormal:

           if IsNullRect(ButtonData.GrayedCheckImageRect)
           then
             SkinDrawCheckImageGrayed(R.Left, R.Top, Picture.Canvas, ButtonData.CheckImageRect,
               ACanvas.Canvas)
           else
             SkinDrawCheckImage(R.Left, R.Top, Picture.Canvas, ButtonData.GrayedCheckImageRect,
               ACanvas.Canvas);

         cxbsHot, cxbsPressed:
           if IsNullRect(ButtonData.GrayedCheckImageRect)
           then
             begin
               if not IsNullRect(ButtonData.ActiveCheckImageRect)
               then
                 SkinDrawCheckImageGrayed(R.Left, R.Top, Picture.Canvas, ButtonData.ActiveCheckImageRect,
                   ACanvas.Canvas)
               else
                SkinDrawCheckImageGrayed(R.Left, R.Top, Picture.Canvas, ButtonData.CheckImageRect,
                  ACanvas.Canvas);
             end
           else
           if not IsNullRect(ButtonData.ActiveGrayedCheckImageRect)
           then
             SkinDrawCheckImage(R.Left, R.Top, Picture.Canvas, ButtonData.ActiveGrayedCheckImageRect,
               ACanvas.Canvas)
           else
             SkinDrawCheckImage(R.Left, R.Top, Picture.Canvas, ButtonData.GrayedCheckImageRect,
             ACanvas.Canvas);
       end;
    end
  else
    inherited;
end;


procedure TcxbsaLookAndFeelPainter.DrawCheckButton(ACanvas: TcxCanvas; R: TRect;
           AState: TcxButtonState;  AChecked: Boolean);

procedure SkinDrawCheckImage(X, Y: Integer; Cnvs: TCanvas; IR: TRect; DestCnvs: TCanvas);
var
  B: TBitMap;
begin
  B := TBitMap.Create;
  B.Width := RectWidth(IR);
  B.Height := RectHeight(IR);
  B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), Cnvs, IR);
  B.Transparent := True;
  DestCnvs.Draw(X, Y, B);
  B.Free;
end;

var
  I: Integer;
  ButtonData: TbsDataSkinCheckRadioControl;
  Picture: TBitmap;
begin
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    begin
      I := DevExSkinData.GetControlIndex('checkbox');
      if I <> -1 then ButtonData := TbsDataSkinCheckRadioControl(DevExSkinData.CtrlList[I]) else Exit;
      Picture := TBitMap(DevExSkinData.FActivePictures.Items[ButtonData.PictureIndex]);
      if AChecked then
       case AState of
         cxbsNormal:
           SkinDrawCheckImage(R.Left, R.Top, Picture.Canvas, ButtonData.CheckImageRect,
             ACanvas.Canvas);
         cxbsHot, cxbsPressed:
           if not IsNullRect(ButtonData.ActiveCheckImageRect)
           then
             SkinDrawCheckImage(R.Left, R.Top, Picture.Canvas, ButtonData.ActiveCheckImageRect,
               ACanvas.Canvas)
           else
             SkinDrawCheckImage(R.Left, R.Top, Picture.Canvas, ButtonData.CheckImageRect,
             ACanvas.Canvas);
       end
     else
       case AState of
         cxbsNormal:
           SkinDrawCheckImage(R.Left, R.Top, Picture.Canvas, ButtonData.UnCheckImageRect,
             ACanvas.Canvas);
         cxbsHot, cxbsPressed:
           if not IsNullRect(ButtonData.ActiveCheckImageRect)
           then
             SkinDrawCheckImage(R.Left, R.Top, Picture.Canvas, ButtonData.ActiveUnCheckImageRect,
               ACanvas.Canvas)
           else
             SkinDrawCheckImage(R.Left, R.Top, Picture.Canvas, ButtonData.UnCheckImageRect,
             ACanvas.Canvas);
       end;
    end
  else
    inherited;
end;

function TcxbsaLookAndFeelPainter.CheckButtonColor(AState: TcxButtonState): TColor;
begin
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    begin
      if AState = cxbsPressed
      then Result := DevExSkindata.SkinColors.cBtnFace
      else Result := DevExSkindata.SkinColors.cWindow;
     end
  else
    Result := inherited CheckButtonColor(AState);
end;

procedure TcxbsaLookAndFeelPainter.DrawHeaderPressed(ACanvas: TcxCanvas;
  const ABounds: TRect);
begin
  if (DevExSkindata = nil) or DevExSkindata.Empty then inherited;
end;

procedure TcxbsaLookAndFeelPainter.DrawHeader(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders;
  AState: TcxButtonState; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine, AShowEndEllipsis: Boolean; const AText: string; AFont: TFont;
  ATextColor, ABkColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil;
  AIsLast: Boolean = False; AIsGroup: Boolean = False );
var
  Buffer: TBitMap;
  C: TColor;
begin
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := RectWidth(ABounds);
      Buffer.Height := RectHeight(ABounds);
      DrawSkinButton('resizebutton', Buffer, AState, C);
      ACanvas.Draw(ABounds.Left, ABounds.Top, Buffer);
      Buffer.Free;
      DrawContent1(ACanvas, HeaderContentBounds(ABounds, ABorders), ATextAreaBounds, Integer(AState),
       AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis, AText,
       AFont, C, ABkColor, AOnDrawBackground);
    end
  else
    inherited;
end;

procedure TcxbsaLookAndFeelPainter.DrawContent1(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect; AState: Integer;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsFooter: Boolean = False);
const
  AlignmentsHorz: array[TAlignment] of Integer =
    (cxAlignLeft, cxAlignRight, cxAlignHCenter);
  AlignmentsVert: array[TcxAlignmentVert] of Integer =
    (cxAlignTop, cxAlignBottom, cxAlignVCenter);
  MultiLines: array[Boolean] of Integer = (cxSingleLine, cxWordBreak);
  ShowEndEllipsises: array[Boolean] of Integer = (0, cxShowEndEllipsis);
begin
  with ACanvas do
  begin
    if AText <> '' then
    begin
      Brush.Style := bsClear;
      Font := AFont;
      Font.Color := ATextColor;
      DrawText(AText, ATextAreaBounds, AlignmentsHorz[AAlignmentHorz] or
        AlignmentsVert[AAlignmentVert] or MultiLines[AMultiLine] or
        ShowEndEllipsises[AShowEndEllipsis]);
      Brush.Style := bsSolid;
    end;
  end;
end;

function TcxbsaLookAndFeelPainter.DefaultGridLineColor: TColor;
begin
  if (DevExSkinData <> nil) and not (DevExSkinData.Empty)
  then
    begin
      Result := DevExSkinData.SkinColors.cBtnShadow
    end
  else
    Result := inherited DefaultGridLineColor;
end;

function TcxbsaLookAndFeelPainter.DefaultFilterBoxColor: TColor;
begin
  if (DevExSkinData <> nil) and not (DevExSkinData.Empty)
  then
    Result := DevExSkinData.SkinColors.cBtnShadow
  else
    Result := inherited DefaultFilterBoxColor;
end;

function TcxbsaLookAndFeelPainter.DefaultFilterBoxTextColor: TColor; 
begin
  if (DevExSkinData <> nil) and not (DevExSkinData.Empty)
  then
    Result := DevExSkinData.SkinColors.cBtnHighLight
  else
    Result := inherited DefaultFilterBoxTextColor;
end;


function TcxbsaLookAndFeelPainter.DefaultFooterColor: TColor;
begin
  if (DevExSkinData <> nil) and not (DevExSkinData.Empty)
  then
    Result := DevExSkinData.SkinColors.cBtnFace
  else
    Result := inherited DefaultFooterColor;
end;

function TcxbsaLookAndFeelPainter.DefaultFooterTextColor: TColor; 
begin
  if (DevExSkinData <> nil) and not (DevExSkinData.Empty)
  then
    Result := DevExSkinData.SkinColors.cBtnText
  else
    Result := inherited DefaultFooterTextColor;
end;

function TcxbsaLookAndFeelPainter.DefaultGroupByBoxColor: TColor;
begin
  if (DevExSkinData <> nil) and not (DevExSkinData.Empty)
  then
    Result := DevExSkinData.SkinColors.cBtnShadow
  else
    Result := inherited DefaultGroupByBoxColor;
end;

function TcxbsaLookAndFeelPainter.DefaultGroupByBoxTextColor: TColor;
begin
  if (DevExSkinData <> nil) and not (DevExSkinData.Empty)
  then
    Result := DevExSkinData.SkinColors.cBtnHighLight
  else
    Result := inherited DefaultGroupByBoxTextColor;
end;

function TcxbsaLookAndFeelPainter.DefaultContentColor: TColor;
begin
  if (DevExSkinData <> nil) and not (DevExSkinData.Empty)
  then
    Result := DevExSkinData.SkinColors.cWindow
  else
    Result := inherited DefaultContentColor;
end;

function TcxbsaLookAndFeelPainter.DefaultContentTextColor: TColor;
begin
  if (DevExSkinData <> nil) and not (DevExSkinData.Empty)
  then
    Result := DevExSkinData.SkinColors.cWindowText
  else
    Result := inherited DefaultContentTextColor;
end;

function TcxbsaLookAndFeelPainter.DefaultGroupColor: TColor;
begin
  if (DevExSkinData <> nil) and not (DevExSkinData.Empty)
  then
    Result := DevExSkinData.SkinColors.cBtnFace
  else
    Result := inherited DefaultGroupColor;
end;

function TcxbsaLookAndFeelPainter.DefaultGroupTextColor: TColor;
begin
  if (DevExSkinData <> nil) and not (DevExSkinData.Empty)
  then
    Result := DevExSkinData.SkinColors.cBtnText
  else
    Result := inherited DefaultGroupTextColor;
end;

function TcxbsaLookAndFeelPainter.DefaultSchedulerBorderColor: TColor;
begin
  if (DevExSkinData <> nil) and not (DevExSkinData.Empty)
  then
    Result := DevExSkinData.SkinColors.cBtnShadow
  else
    Result := clBtnShadow;
end;

function TcxbsaLookAndFeelPainter.DefaultHeaderBackgroundColor: TColor;
begin
   if (DevExSkinData <> nil) and not (DevExSkinData.Empty)
  then
    Result := DevExSkinData.SkinColors.cBtnFace
  else
    Result := inherited DefaultHeaderBackgroundColor;
end;

function TcxbsaLookAndFeelPainter.DefaultHeaderBackgroundTextColor: TColor; 
begin
  if (DevExSkinData <> nil) and not (DevExSkinData.Empty)
  then
    Result := DevExSkinData.SkinColors.cBtnText
  else
    Result := inherited DefaultHeaderBackgroundTextColor;
end;

function TcxbsaLookAndFeelPainter.DefaultHeaderTextColor: TColor; 
begin
  if (DevExSkinData <> nil) and not (DevExSkinData.Empty)
  then
    Result := DevExSkinData.SkinColors.cBtnText
  else
    Result := inherited DefaultHeaderTextColor;
end;

function TcxbsaLookAndFeelPainter.DefaultHeaderColor: TColor;
begin
  if (DevExSkinData <> nil) and not (DevExSkinData.Empty)
  then
    Result := DevExSkinData.SkinColors.cBtnFace
  else
    Result := inherited DefaultHeaderColor;
end;

procedure TcxbsaLookAndFeelPainter.DrawButton(ACanvas: TcxCanvas; R: TRect; const ACaption: string;
      AState: TcxButtonState; ADrawBorder: Boolean = True; AColor: TColor = clDefault;
      ATextColor: TColor = clDefault; AWordWrap: Boolean = False; AIsToolButton: Boolean = False); 
var
  Buffer: TBitMap;
  C: TColor;
begin
  if (DevExSkinData <> nil) and not (DevExSkinData.Empty)
  then
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := RectWidth(R);
      Buffer.Height := RectHeight(R);
      DrawSkinButton('resizebutton', Buffer, AState, C);
      ACanvas.Draw(R.Left, R.Top, Buffer);
      //
      with R do 
      begin
        Dec(Bottom, Ord(Odd(Bottom - Top)));
        if (Bottom - Top) < 18 then Dec(Top);
      end;
      if AState = cxbsPressed then
       OffsetRect(R, ButtonTextShift, ButtonTextShift);
      ACanvas.Brush.Style := bsClear;
      ACanvas.Font.Color := C;
      if Length(ACaption) > 0 then
        ACanvas.DrawText(ACaption, R, cxAlignHCenter or cxAlignVCenter or cxSingleLine or
         cxShowPrefix, AState <> cxbsDisabled);
      ACanvas.Brush.Style := bsSolid;
      //
      Buffer.Free;
    end
  else
    inherited;
end;


function TcxbsaLookAndFeelPainter.BorderHighlightColor: TColor;
begin
  if (DevExSkinData <> nil) and not (DevExSkinData.Empty)
  then
    Result := DevExSkinData.SkinColors.cHighLight
  else
    Result := clHighlight;
end;

function TcxbsaLookAndFeelPainter.BorderSize: Integer;
begin
  Result := 1;
end;

procedure TcxbsaLookAndFeelPainter.DrawContainerBorder(ACanvas: TcxCanvas; const R: TRect; AStyle: TcxContainerBorderStyle;
      AWidth: Integer; AColor: TColor; ABorders: TcxBorders); 
var
  R1: TRect;
begin
  if (DevExSkinData <> nil) and not (DevExSkinData.Empty)
  then
    begin
      case AStyle of
        cbsSingle, cbsThick:
          ACanvas.FrameRect(R, DevExSkinData.SkinColors.cBtnShadow, AWidth);
        cbsFlat, cbs3D:
          begin
            ACanvas.FrameRect(R, DevExSkinData.SkinColors.cBtnShadow, 1);
            R1 := R;
            InflateRect(R1, -1, -1);
            ACanvas.FrameRect(R1, DevExSkinData.SkinColors.cBtnFace, 1);
          end;
      end;
    end
  else
   inherited;
end;

procedure TcxbsaLookAndFeelPainter.DrawBorder(ACanvas: TcxCanvas; R: TRect);
begin
  if (DevExSkinData <> nil) and not (DevExSkinData.Empty)
  then
    ACanvas.FrameRect(R, DevExSkinData.SkinColors.cBtnShadow)
  else
    ACanvas.FrameRect(R, clBtnShadow);
end;

function TcxbsaLookAndFeelPainter.ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer;
begin
  if AState = cxbsDefault then Result := 2 else Result := 1;
end;

function TcxbsaLookAndFeelPainter.ButtonColor(AState: TcxButtonState): TColor;
begin
  if (DevExSkinData <> nil) and not (DevExSkinData.Empty)
  then
    begin
      Result := DevExSkinData.SkinColors.cBtnFace;
    end
  else
  case AState of
    cxbsHot:
      Result := GetLightSelColor;
    cxbsPressed:
      Result := GetLightDownedSelColor;
  else
    Result := inherited ButtonColor(AState);
  end;
end;

function TcxbsaLookAndFeelPainter.ButtonFocusRect(ACanvas: TcxCanvas; R: TRect): TRect;
begin
  Result := R;
  InflateRect(Result, -3, -3);
  if IsRectEmpty(Result) then
    Result := R;
end;

function TcxbsaLookAndFeelPainter.ButtonSymbolColor(
  AState: TcxButtonState; ADefaultColor: TColor = clDefault): TColor;
begin
  if (DevExSkindata <> nil) and (not DevExSkindata.Empty)
  then
    Result := DevExSkindata.SkinColors.cBtnText
  else
  if AState = cxbsPressed then
    Result := clHighlightText
  else
    Result := inherited ButtonSymbolColor(AState, ADefaultColor);
end;

function TcxbsaLookAndFeelPainter.ButtonSymbolState(AState: TcxButtonState): TcxButtonState;
begin
  Result := cxbsNormal;
end;

function TcxbsaLookAndFeelPainter.ButtonTextOffset: Integer;
begin
  Result := 2;
end;

function TcxbsaLookAndFeelPainter.ButtonTextShift: Integer;
begin
  Result := 0;
end;

procedure TcxbsaLookAndFeelPainter.DrawButtonBorder(ACanvas: TcxCanvas; R: TRect;
  AState: TcxButtonState);

  function GetBorderColor: TColor;
  begin
    case AState of
      cxbsDisabled:
        Result := clBtnShadow;
      cxbsNormal:
        Result := clBtnText;
    else
      Result := clHighlight;
    end;    
  end;

begin
  if (DevExSkinData <> nil) and not (DevExSkinData.Empty)
  then
    begin
      ACanvas.FrameRect(R, DevExSkinData.SkinColors.cBtnShadow);
    end
  else
  if AState = cxbsDefault then
  begin
    ACanvas.FrameRect(R, clWindowFrame);
    InflateRect(R, -1, -1);
    ACanvas.FrameRect(R, clWindowFrame);
  end
  else
    ACanvas.FrameRect(R, GetBorderColor);
end;

procedure TcxbsaLookAndFeelPainter.DrawExpandButton(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault);
var
  ARect: TRect;
begin
  if (DevExSkinData <> nil) and not (DevExSkinData.Empty)
  then
    begin
      ARect := R;
      ACanvas.FrameRect(ARect, DevExSkinData.SkinColors.cBtnShadow);
      InflateRect(ARect, -1, -1);
      ACanvas.Brush.Color := DevExSkinData.SkinColors.cBtnFace;
      ACanvas.FillRect(ARect);
      DrawExpandButtonCross(ACanvas, ARect, AExpanded, DevExSkinData.SkinColors.cBtnText);
      ACanvas.ExcludeClipRect(R);
      Exit;
    end;
  ARect := R;
  ACanvas.FrameRect(ARect, clBtnShadow);
  InflateRect(ARect, -1, -1);
  if AColor = clDefault then
    ACanvas.Brush.Color := clBtnFace
  else
    ACanvas.Brush.Color := AColor;
  ACanvas.FillRect(ARect);
  DrawExpandButtonCross(ACanvas, ARect, AExpanded, clBtnText);
  ACanvas.ExcludeClipRect(R);
end;

procedure TcxbsaLookAndFeelPainter.DrawHeaderControlSectionBorder(
  ACanvas: TcxCanvas; const R: TRect; ABorders: TcxBorders; AState: TcxButtonState);
begin
  if AState <> cxbsDisabled then
    ACanvas.DrawComplexFrame(R, clBlack, clBlack, ABorders)
  else
    ACanvas.DrawComplexFrame(R, clBtnShadow, clBtnShadow, ABorders);
end;

procedure TcxbsaLookAndFeelPainter.DrawHeaderControlSectionContent(
  ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
  AState: TcxButtonState; AAlignmentHorz: TAlignment;
  AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
  const AText: string; AFont: TFont; ATextColor, ABkColor: TColor);
begin
  if AState in [cxbsDefault, cxbsNormal] then
    ACanvas.SetBrushColor(ABkColor)
  else
    ACanvas.SetBrushColor(ButtonColor(AState));
  ACanvas.FillRect(ABounds);
  ACanvas.Font.Color := ATextColor;
  DrawHeaderControlSectionText(ACanvas, ATextAreaBounds, AState, AAlignmentHorz,
    AAlignmentVert, AMultiLine, AShowEndEllipsis, AText, AFont, ATextColor);
end;

function TcxbsaLookAndFeelPainter.ExpandButtonSize: Integer;
begin
  Result := 11;
end;

function TcxbsaLookAndFeelPainter.IsButtonHotTrack: Boolean;
begin
  Result := True;
end;

procedure TcxbsaLookAndFeelPainter.DrawCheckBorder(ACanvas: TcxCanvas; R: TRect;
  AState: TcxButtonState);
begin
  ACanvas.FrameRect(R, clBtnText);
  InflateRect(R, -1, -1);
  ACanvas.FrameRect(R, CheckButtonColor(AState));
end;

procedure TcxbsaLookAndFeelPainter.DrawHeaderBorder(ACanvas: TcxCanvas;
  const R: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders);
begin
  if (DevExSkinData <> nil) and not DevExSkinData.Empty
  then
    ACanvas.Brush.Color := DevExSkinData.SkinColors.cBtnText
  else
    ACanvas.Brush.Color := clBtnText;
  with R do
  begin
    if bLeft in ABorders then
      ACanvas.FillRect(Rect(Left, Top, Left + 1, Bottom));
    if bTop in ABorders then
      ACanvas.FillRect(Rect(Left, Top, Right, Top + 1));
    ACanvas.FillRect(Rect(Right - 1, Top, Right, Bottom));
    ACanvas.FillRect(Rect(Left, Bottom - 1, Right, Bottom));
  end;
end;

procedure TcxbsaLookAndFeelPainter.DrawHeaderEx(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders;
  AState: TcxButtonState; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine, AShowEndEllipsis: Boolean; const AText: string; AFont: TFont;
  ATextColor, ABkColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil);
var
  R: TRect;
begin
  R := ATextAreaBounds;
  InflateRect(R, -1, -1);
  DrawContent(ACanvas, ABounds, R, Integer(AState),
    AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis, AText,
      AFont, ATextColor, ABkColor, AOnDrawBackground);
  R := ABounds;
  InflateRect(R, -1, -1);
  DrawHeaderBorder(ACanvas, R, ANeighbors, ABorders);
end;

procedure TcxbsaLookAndFeelPainter.DrawSortingMark(ACanvas: TcxCanvas;
  const R: TRect; AAscendingSorting: Boolean);
begin
  if (DevExSkinData <> nil) and not DevExSkinData.Empty
  then
    DrawSortingArrow(ACanvas, R, DevExSkinData.SkinColors.cBtnShadow, DevExSkinData.SkinColors.cBtnShadow, AAscendingSorting)
  else
    DrawSortingArrow(ACanvas, R, clBtnShadow, clBtnShadow, AAscendingSorting);
end;

function TcxbsaLookAndFeelPainter.HeaderBorders(ANeighbors: TcxNeighbors): TcxBorders;
begin
  Result := inherited HeaderBorders(ANeighbors);
  if nLeft in ANeighbors then Exclude(Result, bLeft);
  if nTop in ANeighbors then Exclude(Result, bTop);
end;

function TcxbsaLookAndFeelPainter.HeaderBorderSize: Integer;
begin
  Result := 1;
end;

function TcxbsaLookAndFeelPainter.SortingMarkSize: TPoint;
begin
  Result := Point(7, 8);
end;

procedure TcxbsaLookAndFeelPainter.DrawFooterBorder(ACanvas: TcxCanvas;
  const R: TRect);
begin
  ACanvas.Brush.Color := FooterSeparatorColor;
  with R do
  begin
    ACanvas.FillRect(Rect(Right - 1, Top, Right, Bottom));
    ACanvas.FillRect(Rect(Left, Bottom - 1, Right, Bottom));
  end;
end;

procedure TcxbsaLookAndFeelPainter.DrawFooterCellBorder(ACanvas: TcxCanvas;
  const R: TRect);
begin
  ACanvas.FrameRect(R, FooterSeparatorColor);
end;

function TcxbsaLookAndFeelPainter.FooterBorders: TcxBorders;
begin
  Result := [bRight, bBottom];
end;

function TcxbsaLookAndFeelPainter.FooterBorderSize: Integer;
begin
  Result := 1;
end;

function TcxbsaLookAndFeelPainter.FooterCellBorderSize: Integer;
begin
  Result := 1;
end;

function TcxbsaLookAndFeelPainter.FooterCellOffset: Integer;
begin
  Result := 2;
end;

procedure TcxbsaLookAndFeelPainter.DrawFilterDropDownButton(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean);

  function GetArrowColor: TColor;
  begin
    if AIsFilterActive then
      Result := ActiveFilterButtonArrowColor
    else
      Result := ButtonSymbolColor(AState);
  end;

var
  C: TColor;
  Buffer: TBitMap;
begin
  if (DevExSkinData <> nil) and not DevExSkinData.Empty
  then
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := RectWidth(R);
      Buffer.Height := RectHeight(R);
      DrawSkinButton('resizebutton', Buffer, AState, C);
      ACanvas.Draw(R.Left, R.Top, Buffer);
      DrawButtonArrow(ACanvas, R, C);
      Buffer.Free;
    end
  else
    begin
      ACanvas.FrameRect(R, FilterDropDownButtonBorderColor(AState));
      InflateRect(R, -1, -1);
      ACanvas.Brush.Color := ButtonColor(AState);
      ACanvas.FillRect(R);
      DrawButtonArrow(ACanvas, R, GetArrowColor);
    end;  
end;

function TcxbsaLookAndFeelPainter.FilterCloseButtonSize: TPoint;
begin
  Result := inherited FilterCloseButtonSize;
  Inc(Result.Y);
end;

procedure TcxbsaLookAndFeelPainter.DrawTabBorder(ACanvas: TcxCanvas; R: TRect;
  ABorder: TcxBorder; ABorders: TcxBorders; AVertical: Boolean);
begin
  if AVertical and (ABorder = bBottom) or not AVertical and (ABorder = bRight) then
  begin
    if not AVertical then
      Dec(R.Bottom, TabBorderSize(AVertical));
    ACanvas.Brush.Color := TabBorderDarkColor;
  end
  else
    ACanvas.Brush.Color := TabBorderHighlightColor;
  ACanvas.FillRect(R);
end;

procedure TcxbsaLookAndFeelPainter.DrawTabsRoot(ACanvas: TcxCanvas;
  const R: TRect; ABorders: TcxBorders; AVertical: Boolean);
begin
  ACanvas.DrawComplexFrame(R, TabBorderHighlightColor, TabBorderHighlightColor, ABorders, TabBorderSize(AVertical));
end;

function TcxbsaLookAndFeelPainter.TabBorderSize(AVertical: Boolean): Integer;
begin
  Result := 1;
end;

procedure TcxbsaLookAndFeelPainter.DrawScrollBarPart(ACanvas: TcxCanvas;
  AHorizontal: Boolean; R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState);
var
  ScrollBarData: TbsDataSkinScrollbarControl;
  I, Cnt: Integer;
  Buffer, Buffer2, GlyphB: TBitMap;
  Rct, Rct1: TRect;
  Picture: TBitMap;
  C: TColor;
  ArrowCode: Integer;
procedure DrawTrackArea;
var
  J: Integer;
  TR: TRect;
  B: TBitMap;
begin
  with ScrollBarData do
  begin
  TR := TrackArea;
  if AHorizontal
  then
     begin
       TR.Left := LTPoint.X;
       TR.Right := RTPoint.X;
     end
  else
    begin
      TR.Top := LTPoint.Y;
      TR.Bottom := LBPoint.Y;
    end;
  OffsetRect(TR, SkinRect.Left, SkinRect.Top);
  B := TBitMap.Create;
  if AHorizontal
  then
  begin
    B.Width := Buffer.Width;
    B.Height := RectHeight(TR);
    Cnt := Buffer.Width div RectWidth(TR);
    for J := 0 to Cnt do
    begin
      B.Canvas.CopyRect(Rect(J * RectWidth(TR), 0,
        J * RectWidth(TR) + RectWidth(TR), B.Height),
        Picture.Canvas, TR);
     end;
  end
  else
  begin
    B.Width := RectWidth(TR);
    B.Height := Buffer.Height;
    Cnt := Buffer.Height div RectHeight(TR);
    for J := 0 to Cnt do
    begin
      B.Canvas.CopyRect(Rect(0, J * RectHeight(TR), B.Width,
      J * RectHeight(TR) + RectHeight(TR)),
      Picture.Canvas, TR);
    end;
  end;
  Buffer.Canvas.StretchDraw(Rect(0, 0, Buffer.Width, Buffer.Height), B);
  B.Free;
  end;
end;

begin
  if IsRectEmpty(R) or ((APart = sbpThumbnail) and (AState = cxbsDisabled)) then Exit;
  if (DevExSkinData <> nil) and (not DevExSkinData.Empty)
  then
    begin
      if AHorizontal
      then I := DevExSkinData.GetControlIndex('hscrollbar')
      else I := DevExSkinData.GetControlIndex('vscrollbar');
      if I <> -1
      then
        begin
          ScrollBarData := TbsDataSkinScrollbarControl(DevExSkinData.CtrlList[I]);
          Picture := TBitMap(DevExSkinData.FActivePictures.Items[ScrollBarData.PictureIndex]);
          Buffer := TBitMap.Create;
          Buffer.Width := RectWidth(R);
          Buffer.Height := RectHeight(R);
          with ScrollBarData do
          case APart of
            sbpLineDown:
              if (AHorizontal and (RectHeight(R) > RectWidth(R) * 2)) or
                 (not AHorizontal and (RectWidth(R) > RectHeight(R) * 2))
              then
                begin
                  if AHorizontal then ArrowCode := 2 else  ArrowCode := 4;
                  DrawSkinButton('resizebutton', Buffer, AState, C);
                  DrawArrowImage(Buffer.Canvas, Rect(0, 0, Buffer.Width, Buffer.Height),
                  C, ArrowCode);
                end
              else
              begin
                case AState of
                  cxbsDefault, cxbsNormal:
                   begin
                     Rct := UpButtonRect;
                     OffsetRect(Rct, SkinRect.Left, SkinRect.Top);
                   end;
                  cxbsHot:
                    begin
                      Rct := ActiveUpButtonRect;
                      if IsNullRect(Rct)
                      then
                        begin
                          Rct := UpButtonRect;
                          OffsetRect(Rct, SkinRect.Left, SkinRect.Top);
                        end;
                    end;
                  cxbsPressed:
                    begin
                      Rct := DownUpButtonRect;
                      if IsNullRect(Rct)
                      then
                        begin
                          Rct := ActiveUpButtonRect;
                          if IsNullRect(Rct)
                          then
                            begin
                              Rct := UpButtonRect;
                              OffsetRect(Rct, SkinRect.Left, SkinRect.Top);
                            end;
                        end;
                    end;
                end;
                 //
                DrawTrackArea;
                 //
                 if (RectWidth(Rct) < Buffer.Width) and
                    (RectHeight(Rct) < Buffer.Height)
                 then
                   begin
                     Rct1.Left := Buffer.Width div 2 - RectWidth(Rct) div 2;
                     Rct1.Top := Buffer.Height div 2 - RectHeight(Rct) div 2;
                     Rct1.Right := Rct1.Left + RectWidth(Rct);
                     Rct1.Bottom := Rct1.Top + RectHeight(Rct);
                     Buffer.Canvas.CopyRect(Rct1, Picture.Canvas, Rct);
                   end
                 else
                  Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height),
                   Picture.Canvas, Rct);
                 //
              end;
            sbpLineUp:
              if (AHorizontal and (RectHeight(R) > RectWidth(R) * 2)) or
                   (not AHorizontal and (RectWidth(R) > RectHeight(R) * 2))
                 then
                   begin
                     if AHorizontal then ArrowCode := 1 else  ArrowCode := 3;
                     DrawSkinButton('resizebutton', Buffer, AState, C);
                     DrawArrowImage(Buffer.Canvas, Rect(0, 0, Buffer.Width, Buffer.Height),
                     C, ArrowCode);
                   end
                else
              begin
                case AState of
                  cxbsDefault, cxbsNormal:
                   begin
                     Rct := DownButtonRect;
                     OffsetRect(Rct, SkinRect.Left, SkinRect.Top);
                   end;
                  cxbsHot:
                    begin
                      Rct := ActiveDownButtonRect;
                      if IsNullRect(Rct)
                      then
                        begin
                          Rct := DownButtonRect;
                          OffsetRect(Rct, SkinRect.Left, SkinRect.Top);
                        end;
                    end;
                  cxbsPressed:
                    begin
                      Rct := DownDownButtonRect;
                      if IsNullRect(Rct)
                      then
                        begin
                          Rct := ActiveDownButtonRect;
                          if IsNullRect(Rct)
                          then
                            begin
                              Rct := DownButtonRect;
                              OffsetRect(Rct, SkinRect.Left, SkinRect.Top);
                            end;
                        end;
                    end;
                end;
                //
                DrawTrackArea;
                //
                if (RectWidth(Rct) < Buffer.Width) and
                    (RectHeight(Rct) < Buffer.Height)
                 then
                   begin
                     Rct1.Left := Buffer.Width div 2 - RectWidth(Rct) div 2;
                     Rct1.Top := Buffer.Height div 2 - RectHeight(Rct) div 2;
                     Rct1.Right := Rct1.Left + RectWidth(Rct);
                     Rct1.Bottom := Rct1.Top + RectHeight(Rct);
                     if AHorizontal
                     then OffsetRect(Rct1, 1, 0) else OffsetRect(Rct1, 0, 1);
                     Buffer.Canvas.CopyRect(Rct1, Picture.Canvas, Rct);
                   end
                 else
                   Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height),
                     Picture.Canvas, Rct);
                 //
              end;
            sbpPageUp, sbpPageDown:
              begin
                DrawTrackArea;
              end;
            sbpThumbnail:
              begin
                Rct1 := Rect(0, 0, 0, 0);
                case AState of
                  cxbsDefault, cxbsNormal:
                   begin
                     Rct := ThumbRect;
                     Rct1 := GlyphRect;
                   end;
                  cxbsHot:
                    begin
                      Rct := ActiveThumbRect;
                      if IsNullRect(Rct) then Rct := ThumbRect;
                      Rct1 := ActiveGlyphRect;
                      if IsNullRect(Rct1) then Rct1 := GlyphRect;
                    end;
                  cxbsPressed:
                    begin
                      Rct := DownThumbRect;
                      if IsNullRect(Rct)
                      then
                        begin
                          Rct := ActiveThumbRect;
                          if IsNullRect(Rct)
                          then
                             Rct := ThumbRect;
                        end;
                      Rct1 := DownGlyphRect;
                      if IsNullRect(Rct1) then Rct1 := ActiveGlyphRect;
                      if IsNullRect(Rct1) then Rct1 := GlyphRect;
                    end;
                 end;

                Buffer2 := TBitMap.Create;
                if AHorizontal
                then
                  CreateHSkinImage(ThumbOffset1, ThumbOffset2, Buffer2, Picture, Rct, Buffer.Width, Buffer.Height, ThumbStretchEffect)
                else
                  CreateVSkinImage(ThumbOffset1, ThumbOffset2, Buffer2, Picture, Rct, Buffer.Width, Buffer.Height, ThumbStretchEffect);

                if ThumbTransparent
                then
                  begin
                    Buffer2.Transparent := True;
                    Buffer2.TransparentMode := tmFixed;
                    Buffer2.TransparentColor := ThumbTransparentColor;
                  end;

                if ThumbTransparent or (((Buffer2.Height < Buffer.Height) and AHorizontal) or
                   ((Buffer2.Width < Buffer.Width) and not AHorizontal))
                then
                  begin
                    DrawTrackArea;
                  end;


                if ((Buffer2.Height < Buffer.Height) and AHorizontal) or
                   ((Buffer2.Width < Buffer.Width) and not AHorizontal)
                then
                  begin
                    if AHorizontal
                    then
                      begin
                        Buffer.Canvas.Draw(0, Buffer.Height div 2 - Buffer2.Height div 2, Buffer2);
                      end
                    else
                      begin
                        Buffer.Canvas.Draw(Buffer.Width div 2 - Buffer2.Width div 2, 0,  Buffer2);
                      end;
                  end
                   else
                     Buffer.Canvas.StretchDraw(Rect(0, 0, Buffer.Width, Buffer.Height), Buffer2);
                Buffer2.Free;

                if not IsNullRect(Rct1)
                then
                 begin
                   if GlyphTransparent
                   then
                     begin
                       GlyphB := TBitMap.Create;
                       GlyphB.Width := RectWidth(Rct1);
                       GlyphB.Height := RectHeight(Rct1);
                       GlyphB.Canvas.CopyRect(Rect(0, 0, GlyphB.Width, GlyphB.Height),
                         Picture.Canvas, Rct1);
                       GlyphB.Transparent := True;
                       GlyphB.TransparentMode := tmFixed;
                       GlyphB.TransparentColor := GlyphTransparentColor;
                       Buffer.Canvas.Draw(Buffer.Width div 2 - RectWidth(Rct1) div 2,
                         Buffer.Height div 2 - RectHeight(Rct1) div 2,
                           GlyphB);
                       GlyphB.Free;
                     end
                   else
                     Buffer.Canvas.CopyRect(Rect(Buffer.Width div 2 - RectWidth(Rct1) div 2,
                         Buffer.Height div 2 - RectHeight(Rct1) div 2,
                         Buffer.Width div 2 - RectWidth(Rct1) div 2 + RectWidth(Rct1),
                         Buffer.Height div 2 - RectHeight(Rct1) div 2 + RectHeight(Rct1)),
                         Picture.Canvas, Rct1);
                 end;
              end;
          end;
          ACanvas.Draw(R.Left, R.Top, Buffer);
          Buffer.Free;
        end;
    end
  else
  case APart of
    sbpThumbnail, sbpLineUp, sbpLineDown:
      begin
        DrawButton(ACanvas, R, '', AState);
        if APart <> sbpThumbnail then
          DrawScrollBarArrow(ACanvas, R, AState, GetArrowDirection(AHorizontal, APart));
      end;
    sbpPageUp, sbpPageDown:
      begin
        ACanvas.Brush.Bitmap := StdScrollBitmaps[AState = cxbsPressed];
        ACanvas.FillRect(R);
        ACanvas.Brush.Bitmap := nil;
        ACanvas.Brush.Style := bsSolid;
      end;
  end;
end;

function TcxbsaLookAndFeelPainter.FilterDropDownButtonBorderColor(AState: TcxButtonState): TColor;
begin
  if (DevExSkinData <> nil) and not DevExSkinData.Empty
  then
    Result := DevExSkinData.SkinColors.cBtnShadow
  else  
  if AState = cxbsNormal then
    Result := clBtnShadow
  else
    Result := clHighlight;
end;

function TcxbsaLookAndFeelPainter.TabBorderHighlightColor: TColor;
begin
  if (DevExSkinData <> nil) and not DevExSkinData.Empty
  then
    Result := DevExSkinData.SkinColors.cBtnHighLight
  else
    Result := clBtnShadow;
end;

function TcxbsaLookAndFeelPainter.TabBorderDarkColor: TColor;
begin
   if (DevExSkinData <> nil) and not DevExSkinData.Empty
  then
    Result := DevExSkinData.SkinColors.cBtnShadow
  else
    Result := clBtnText;
end;

procedure TcxbsaLookAndFeelPainter.DrawSchedulerNavigatorButton(
  ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState);
begin
  DrawButton(ACanvas, R, '', AState, AState in [cxbsHot, cxbsPressed]);
end;

procedure TcxbsaLookAndFeelPainter.DrawSchedulerSplitterBorder(
  ACanvas: TcxCanvas; R: TRect; const AViewParams: TcxViewParams;
  AIsHorizontal: Boolean);
begin
  ACanvas.SetBrushColor(DefaultSchedulerBorderColor);
  if AIsHorizontal then
  begin
    ACanvas.FillRect(Rect(R.Left, R.Top, R.Right, R.Top + 1));
    ACanvas.FillRect(Rect(R.Left, R.Bottom - 1, R.Right, R.Bottom));
    InflateRect(R, 1, -1);
  end
  else
  begin
    ACanvas.FillRect(Rect(R.Left, R.Top, R.Left + 1, R.Bottom));
    ACanvas.FillRect(Rect(R.Right - 1, R.Top, R.Right, R.Bottom));
    InflateRect(R, -1, 1);
  end;
  ACanvas.FillRect(R, AViewParams);
end;

procedure RegsterPainterClass;
begin
  cxLookAndFeelPaintersManager.Register(TcxbsaLookAndFeelPainter.Create);
end;

initialization

 RegsterPainterClass;

end.
