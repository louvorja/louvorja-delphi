object seNBPagesForm: TseNBPagesForm
  Left = 415
  Top = 341
  BorderStyle = bsDialog
  Caption = 'Pages'
  ClientHeight = 265
  ClientWidth = 278
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 72
    Width = 73
    Height = 13
    Alignment = taRightJustify
    Caption = 'BGImageIndex:'
  end
  object Label2: TLabel
    Left = 14
    Top = 100
    Width = 67
    Height = 13
    Alignment = taRightJustify
    Caption = 'BGDrawType:'
  end
  object Label3: TLabel
    Left = 54
    Top = 40
    Width = 27
    Height = 13
    Alignment = taRightJustify
    Caption = 'Color:'
  end
  object Shape1: TShape
    Left = 88
    Top = 34
    Width = 56
    Height = 25
    OnMouseUp = Shape1MouseUp
  end
  object PageListBox: TListBox
    Left = 8
    Top = 128
    Width = 169
    Height = 121
    ItemHeight = 13
    TabOrder = 0
    OnClick = PageListBoxClick
  end
  object CaptionEdit: TEdit
    Left = 8
    Top = 8
    Width = 169
    Height = 21
    TabOrder = 1
    OnChange = CaptionEditChange
  end
  object AddButton: TButton
    Left = 192
    Top = 128
    Width = 75
    Height = 25
    Caption = '&Add'
    TabOrder = 2
    OnClick = AddButtonClick
  end
  object DeleteButton: TButton
    Left = 192
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Del&ete'
    TabOrder = 3
    OnClick = DeleteButtonClick
  end
  object MoveUpButton: TButton
    Left = 192
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Move &Up'
    TabOrder = 4
    OnClick = MoveUpButtonClick
  end
  object MoveDownButton: TButton
    Left = 192
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Move &Down'
    TabOrder = 5
    OnClick = MoveDownButtonClick
  end
  object IIndexBox: TComboBox
    Left = 88
    Top = 69
    Width = 57
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    TabOrder = 6
    OnChange = IIndexBoxChange
  end
  object BGDType: TComboBox
    Left = 88
    Top = 98
    Width = 145
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    TabOrder = 7
    OnChange = BGDTypeChange
    Items.Strings = (
      'seBGTile'
      'seBGStretch'
      'seBGVertStretch'
      'seBGHorzStretch')
  end
  object ColorDialog1: TColorDialog
    Ctl3D = True
    Left = 152
    Top = 32
  end
end
