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

unit se_reg;

{$I se_define.inc}

interface

uses
  Classes, SysUtils, TypInfo,
  {$IFDEF SE_COMPILER6_UP} DesignIntf, DesignEditors {$ELSE} DsgnIntf {$ENDIF};

type
  TseAnimationPropertyEditor = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: String; override;
  end;

  TsePNGPropertyEditor = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: String; override;
  end;

procedure Register;

implementation

uses se_effect, se_ani, se_anilistdesigner,
  se_image, se_form, se_imagelist, se_anidesignerform, se_controls,
  se_zlib, se_pngimage, se_pngimagelist, se_pngimageeditor,
  se_NBPagesEditor;

type
  TseSetPagesProperty = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
   end;

procedure TseSetPagesProperty.Edit;
var
  NB: TseNoteBook;
begin
  try
    NB := TseNoteBook(GetComponent(0));
    se_NBPagesEditor.Execute(NB);
  finally
  end;
end;

function TseSetPagesProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

function TseSetPagesProperty.GetValue: string;
begin
  Result := '(Pages)';
end;

procedure TseSetPagesProperty.SetValue(const Value: string);
begin
  if Value = '' then SetOrdValue(0);
end;


  procedure TsePNGPropertyEditor.Edit;
  begin
    if PropCount <> 1 then Exit;
    ExecutePngEditor(TsePngImageItem(GetComponent(0)).PngImage);
    Designer.Modified;
  end;

  function TsePNGPropertyEditor.GetAttributes: TPropertyAttributes;
  begin
    Result := inherited GetAttributes + [paDialog, paReadOnly];
  end;

  function TsePNGPropertyEditor.GetValue: String;
  var
    P: TsePngImage;
  begin
    P := TsePngImageItem(GetComponent(0)).PngImage;
    if not P.Empty
    then
      Result := 'PNG image'
    else
      Result := '(none)';
  end;


procedure TseAnimationPropertyEditor.Edit;
begin
  if PropCount <> 1 then Exit;
  ShowDesignerForm(TseAnimation(GetComponent(0)));
end;

function TseAnimationPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog, paReadOnly];
end;

function TseAnimationPropertyEditor.GetValue: String;
var
  AniComp: TseAnimation;
begin
  AniComp := TseAnimation(GetComponent(0));

  if AniComp <> nil then
    Result := AniComp.Effect
  else
    Result := '(none)';
end;

procedure RewritePublishedProperty(ComponentClass: TClass; const PropertyName: string);
var
   LPropInfo: PPropInfo;
begin
  LPropInfo := GetPropInfo(ComponentClass, PropertyName);
  if LPropInfo <> nil
  then
    RegisterPropertyEditor(LPropInfo^.PropType^, ComponentClass, PropertyName, TsePNGPropertyEditor);
end;

procedure Register;
begin
  RegisterComponents('SmartEffects', [
    TseAnimationList,
    TseAnimationForm, TseLayeredSplashForm,
    TseImageList,
    TseImage, TseXButton, TseButtonLabel, TseXLabel, TseReflectLabel, TsePngImageList,
      TsePngXButton,
      TsePngImageStorage,
      TsePngImageView, TsePanel, TseNoteBook, TseToolBarEx, TsePngImagePanel]);

  RegisterNoIcon([TseAnimation]);
  RegisterComponentEditor(TseAnimationList, TseAnimationListEditor);
  RegisterPropertyEditor(TypeInfo(string), TseAnimation, 'Animation', TseAnimationPropertyEditor);
  RewritePublishedProperty(TsePngImageItem, 'PngImage');
  RewritePublishedProperty(TsePngStorageImageItem, 'PngImage');
  RegisterPropertyEditor(TypeInfo(TStrings),  TseNoteBook, 'Pages', TseSetPagesProperty);
end;

end.

