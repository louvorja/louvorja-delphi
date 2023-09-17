{*******************************************************************}
{                                                                   }
{       SkinAdapter                                                 }
{       BusinessSkinForm                                            }
{       Version 5.30                                                }
{                                                                   }
{       Copyright (c) 2005-2016 Almediadev                          }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{       Home:  http://www.almdev.com                                }
{       Support: support@almdev.com                                 }
{                                                                   }
{*******************************************************************}

unit bsareg;


interface

uses
  Dialogs, Forms, Classes, SysUtils, Controls,
  {$IFNDEF  VER130} DesignEditors, DesignIntf {$ELSE} DsgnIntf {$ENDIF};

procedure Register;

implementation {===============================================================}

{$IFNDEF VER130}
{$IFNDEF VER185}
{$R *.dcr}
{$ENDIF}
{$ENDIF}

uses bsaadapter;

{ Register classes ============================================================}

type


  TbsSASkinDataNameProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TbsSAButtonSkinDataNameProperty = class(TbsSASkinDataNameProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  TbsSAPanelSkinDataNameProperty = class(TbsSASkinDataNameProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  procedure TbsSASkinDataNameProperty.GetValueList(List: TStrings);
  begin
  end;

  procedure TbsSASkinDataNameProperty.GetValues(Proc: TGetStrProc);
  var
    I: Integer;
    Values: TStringList;
  begin
    Values := TStringList.Create;
    try
      GetValueList(Values);
      for I := 0 to Values.Count - 1 do Proc(Values[I]);
    finally
      Values.Free;
    end;
  end;

  function TbsSASkinDataNameProperty.GetAttributes: TPropertyAttributes;
  begin
    Result := [paValueList, paMultiSelect];
  end;

  procedure TbsSAButtonSkinDataNameProperty.GetValueList(List: TStrings);
  begin
    List.Add('resizebutton');
    List.Add('resizetoolbutton');
    List.Add('button');
  end;

  procedure TbsSAPanelSkinDataNameProperty.GetValueList(List: TStrings);
  begin
    List.Add('panel');
    List.Add('resizetoolpanel');
  end;

procedure Register;
begin
  RegisterComponents('BusinessSkinForm VCL Tools', [TbsaSkinAdapter]);
  RegisterPropertyEditor(TypeInfo(string), TbsaSkinAdapter, 'ButtonSkinDataName', TbsSAButtonSkinDataNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TbsaSkinAdapter, 'SpeedButtonSkinDataName', TbsSAButtonSkinDataNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TbsaSkinAdapter, 'PanelSkinDataName', TbsSAPanelSkinDataNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TbsaSkinAdapter, 'CoolBarSkinDataName', TbsSAPanelSkinDataNameProperty);
end;

end.

