{*******************************************************************}
{                                                                   }
{       Almediadev Visual Component Library                         }
{       SmartEffects                                                }
{       Version 2.98                                                }
{                                                                   }
{       Copyright (c) 2007-2016 Almediadev                          }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{       Home:  http://www.almdev.com                                }
{       Support: support@almdev.com                                 }
{                                                                   }
{*******************************************************************}

unit se_grabclass;

{$I se_define.inc}
{$T-,W-,X+,P+}
{$WARNINGS OFF}
{$HINTS OFF}


interface

uses
  Windows, Messages, Graphics, Controls, Forms, StdCtrls, ExtCtrls, Buttons,
  CommCtrl, ComCtrls, FlatSB, ToolWin,
  Classes, SysUtils, se_effect, se_utils, se_grab, se_bitmap;


type

{ Default WinControl }

  TseWControlGrabber = class(TseGrabber)
  private
  public
    procedure GrabToBitmap(ABitmap: TBitmap; X, Y: integer; AControl: TControl;
        ARect: TRect); override;
    class function GetGrabberClassType: TseGrabberControlClass; override;
    class function GetGrabberClassName: string; override;
  end;

const
  CM_SEPAINT  = CM_BASE + 456;
  CM_SENCPAINT  = CM_BASE + 457;
  SE_RESULT = $3233;

implementation {===============================================================}

uses se_winapi;

var
  CurDC: cardinal;
type
  THookWinControl = class(TWinControl);
{ TseWControlGrabber =========================================================}

class function TseWControlGrabber.GetGrabberClassName: string;
begin
  Result := LowerCase('TWinControl;TCustomControl');
end;

class function TseWControlGrabber.GetGrabberClassType:
        TseGrabberControlClass;
begin
  Result := TWinControl;
end;

procedure TseWControlGrabber.GrabToBitmap(ABitmap: TBitmap; X, Y: integer;
  AControl: TControl; ARect: TRect);
const
  InnerStyles: array[TEdgeStyle] of Integer = (0, BDR_RAISEDINNER, BDR_SUNKENINNER);
  OuterStyles: array[TEdgeStyle] of Integer = (0, BDR_RAISEDOUTER, BDR_SUNKENOUTER);
  Ctl3DStyles: array[Boolean] of Integer = (BF_MONO, 0);
var
  SaveIndex, SaveIndex2: Integer;
  COrigin: TPoint;
  DC: HDC;
  RC, RW: TRect;
begin
  DC := ABitmap.Canvas.Handle;
  ABitmap.Canvas.Lock;
  try
    with AControl do
    begin
      SaveIndex := SaveDC(DC);
      CurDC := DC;

      COrigin := GetClientOrigin(AControl);

      MoveWindowOrg(DC, X, Y);

      if AControl is TCustomForm
      then
        begin
          SaveIndex2 := SaveDC(DC);
          if SendMessage(TWinControl(AControl).Handle, CM_SENCPAINT, DC, 0) = SE_RESULT then
          begin
            RestoreDC(DC, SaveIndex2);
            MoveWindowOrg(DC, COrigin.X, COrigin.Y);
            SaveIndex2 := SaveDC(DC);
            IntersectClipRect(DC, 0, 0, AControl.ClientWidth, AControl.ClientHeight);
            SendMessage(TWinControl(AControl).Handle, WM_ERASEBKGND, DC, 0);
            RestoreDC(DC, SaveIndex2);
            SendMessage(TWinControl(AControl).Handle, WM_PAINT, DC, 0);
          end
          else
          begin
            RestoreDC(DC, SaveIndex2);
            SendMessage(TWinControl(AControl).Handle, WM_PRINT, DC, PRF_ERASEBKGND or PRF_CLIENT or PRF_NONCLIENT);
            MoveWindowOrg(DC, COrigin.X, COrigin.Y);
            SendMessage(TWinControl(AControl).Handle, WM_PAINT, DC, 0);
          end;
        end
        else
        if (AControl is TWinControl) then
        begin
          SaveIndex2 := SaveDC(DC);
          if SendMessage(TWinControl(AControl).Handle, CM_SENCPAINT, DC, 0) = SE_RESULT then
          begin
            RestoreDC(DC, SaveIndex2);
            MoveWindowOrg(DC, COrigin.X, COrigin.Y);
            SaveIndex2 := SaveDC(DC);
            IntersectClipRect(DC, 0, 0, AControl.ClientWidth, AControl.ClientHeight);
            SendMessage(TWinControl(AControl).Handle, WM_ERASEBKGND, DC, 0);
            SendMessage(TWinControl(AControl).Handle, WM_PAINT, DC, 0);
            SendMessage(TWinControl(AControl).Handle, CM_SEPAINT, DC, 0);
            RestoreDC(DC, SaveIndex2);
          end
          else
          if (AControl is TCustomListBox) or (AControl is TCustomComboBox) or
             (AControl is TCustomListView) or (AControl is TCustomTreeView)
          then
            begin
              RestoreDC(DC, SaveIndex2);
              SendMessage(TWinControl(AControl).Handle, WM_PRINT, DC, PRF_ERASEBKGND or PRF_CLIENT or PRF_NONCLIENT or PRF_CHILDREN);
            end
          else
          if (AControl is TToolbar)
          then
            begin
              RestoreDC(DC, SaveIndex2);
              { Get window DC that is clipped to the non-client area }
              if not TToolbar(AControl).Transparent then
              begin
                SaveIndex2 := SaveDC(DC);
                Windows.GetClientRect(TWinControl(AControl).Handle, RC);
                GetWindowRect(TWinControl(AControl).Handle, RW);
                MapWindowPoints(0, TWinControl(AControl).Handle, RW, 2);
                OffsetRect(RC, -RW.Left, -RW.Top);
                ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
                { Draw borders in non-client area }
                OffsetRect(RW, -RW.Left, -RW.Top);
                Windows.DrawEdge(DC, RW, InnerStyles[TToolWindow(AControl).EdgeInner] or OuterStyles[TToolWindow(AControl).EdgeOuter],
                  Byte(TToolWindow(AControl).EdgeBorders) or Ctl3DStyles[false] or BF_ADJUST);
              end;

              { draw other }
              RestoreDC(DC, SaveIndex2);
              SendMessage(TWinControl(AControl).Handle, WM_PRINT, DC, PRF_ERASEBKGND or PRF_CLIENT or PRF_NONCLIENT or PRF_CHILDREN);
            end
          else
          if (AControl is TCoolbar)
          then
            begin
              RestoreDC(DC, SaveIndex2);
              { Get window DC that is clipped to the non-client area }
              if (TCoolbar(AControl).HandleAllocated and
                 not (TCoolbar(AControl).AutoSize and ((TCoolbar(AControl).Vertical and (Align in [alNone, alLeft, alRight])) or
                      not TCoolbar(AControl).Vertical and (TCoolbar(AControl).Align in [alNone, alTop, alBottom]))) or
                 (TCoolbar(AControl).AutoSize and ((TCoolbar(AControl).Vertical and (Align in [alNone, alLeft, alRight])) or
                      not TCoolbar(AControl).Vertical and (TCoolbar(AControl).Align in [alNone, alTop, alBottom])) and (TCoolbar(AControl).Bands.Count = 0))) then
              begin
                SaveIndex2 := SaveDC(DC);
                Windows.GetClientRect(TWinControl(AControl).Handle, RC);
                GetWindowRect(TWinControl(AControl).Handle, RW);
                MapWindowPoints(0, TWinControl(AControl).Handle, RW, 2);
                OffsetRect(RC, -RW.Left, -RW.Top);
                ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
                { Draw borders in non-client area }
                OffsetRect(RW, -RW.Left, -RW.Top);
                Windows.DrawEdge(DC, RW, InnerStyles[TToolWindow(AControl).EdgeInner] or OuterStyles[TToolWindow(AControl).EdgeOuter],
                  Byte(TToolWindow(AControl).EdgeBorders) or Ctl3DStyles[false] or BF_ADJUST);
              end;

              { draw other }
              RestoreDC(DC, SaveIndex2);
              SendMessage(TWinControl(AControl).Handle, WM_PRINT, DC, PRF_ERASEBKGND or PRF_CLIENT or PRF_NONCLIENT or PRF_CHILDREN);
            end
          else
          begin
            RestoreDC(DC, SaveIndex2);
            SendMessage(TWinControl(AControl).Handle, WM_PRINT, DC, PRF_NONCLIENT);
            MoveWindowOrg(DC, COrigin.X, COrigin.Y);
            SaveIndex2 := SaveDC(DC);
            IntersectClipRect(DC, 0, 0, AControl.ClientWidth, AControl.ClientHeight);
            SendMessage(TWinControl(AControl).Handle, WM_ERASEBKGND, DC, 0);
            SendMessage(TWinControl(AControl).Handle, WM_PAINT, DC, 0);
            RestoreDC(DC, SaveIndex2);
          end;
        end;

       if csAcceptsControls in AControl.ControlStyle
       then
         SendMessage(TWinControl(AControl).Handle, WM_PAINT, DC, 0);

      CurDC := 0;
      RestoreDC(DC, SaveIndex);
    end;
  finally
    ABitmap.Canvas.Unlock;
    CurDC := 0;
  end;
end;

initialization
  RegisterGrabber(TseWControlGrabber);
end.
