// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Bsawebbrowser.pas' rev: 10.00

#ifndef BsawebbrowserHPP
#define BsawebbrowserHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Extdlgs.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Clipbrd.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit
#include <Syncobjs.hpp>	// Pascal unit
#include <Bsskindata.hpp>	// Pascal unit
#include <Bsskinctrls.hpp>	// Pascal unit
#include <Bsaadapter.hpp>	// Pascal unit
#include <Shdocvw.hpp>	// Pascal unit
#include <Shlobj.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Mshtml.hpp>	// Pascal unit
#include <Olectrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Bsawebbrowser
{
//-- type declarations -------------------------------------------------------
struct TDOCHOSTUIINFO;
typedef TDOCHOSTUIINFO *PDOCHOSTUIINFO;

#pragma pack(push,1)
struct TDOCHOSTUIINFO
{
	
public:
	unsigned cbSize;
	unsigned dwFlags;
	unsigned dwDoubleClick;
	WideChar *pchHostCss;
	WideChar *pchHostNS;
} ;
#pragma pack(pop)

class DELPHICLASS TEnhancedWebBrowserUI;
class PASCALIMPLEMENTATION TEnhancedWebBrowserUI : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FlatScrollBar;
	bool IE3DBorder;
	bool RightClickMenu;
	bool ScrollBar;
	
public:
	__fastcall TEnhancedWebBrowserUI(void);
	
__published:
	__property bool EnableScrollBars = {read=ScrollBar, write=ScrollBar, nodefault};
	__property bool EnableFlatScrollBars = {read=FlatScrollBar, write=FlatScrollBar, nodefault};
	__property bool EnableContextMenu = {read=RightClickMenu, write=RightClickMenu, nodefault};
	__property bool Enable3DBorder = {read=IE3DBorder, write=IE3DBorder, nodefault};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TEnhancedWebBrowserUI(void) { }
	#pragma option pop
	
};


__interface IDocHostUIHandler;
typedef System::DelphiInterface<IDocHostUIHandler> _di_IDocHostUIHandler;
__interface  INTERFACE_UUID("{BD3F23C0-D43E-11CF-893B-00AA00BDCE1A}") IDocHostUIHandler  : public IInterface 
{
	
public:
	virtual HRESULT __stdcall ShowContextMenu(const unsigned dwID, const Types::PPoint ppt, const System::_di_IInterface pcmdtReserved, const _di_IDispatch pdispReserved) = 0 ;
	virtual HRESULT __stdcall GetHostInfo(TDOCHOSTUIINFO &pInfo) = 0 ;
	virtual HRESULT __stdcall ShowUI(const unsigned dwID, const _di_IOleInPlaceActiveObject pActiveObject, const _di_IOleCommandTarget pCommandTarget, const _di_IOleInPlaceFrame pFrame, const _di_IOleInPlaceUIWindow pDoc) = 0 ;
	virtual HRESULT __stdcall HideUI(void) = 0 ;
	virtual HRESULT __stdcall UpdateUI(void) = 0 ;
	virtual HRESULT __stdcall EnableModeless(const BOOL fEnable) = 0 ;
	virtual HRESULT __stdcall OnDocWindowActivate(const BOOL fActivate) = 0 ;
	virtual HRESULT __stdcall OnFrameWindowActivate(const BOOL fActivate) = 0 ;
	virtual HRESULT __stdcall ResizeBorder(const Types::PRect prcBorder, const _di_IOleInPlaceUIWindow pUIWindow, const BOOL FrameWindow) = 0 ;
	virtual HRESULT __stdcall TranslateAccelerator(const Windows::PMsg lpMsg, const System::PGUID pguidCmdGroup, const unsigned nCmdID) = 0 ;
	virtual HRESULT __stdcall GetOptionKeyPath(WideChar * &pchKey, const unsigned dw) = 0 ;
/*virtual HRESULT __stdcall GetDropTarget(const _di_IDropTarget pDropTarget, _di_IDropTarget &ppDropTarget) = 0 ;*/
	virtual HRESULT __stdcall GetExternal(/* out */ _di_IDispatch &ppDispatch) = 0 ;
	virtual HRESULT __stdcall TranslateUrl(const unsigned dwTranslate, const WideChar * pchURLIn, WideChar * &ppchURLOut) = 0 ;
	virtual HRESULT __stdcall FilterDataObject(const _di_IDataObject pDO, /* out */ _di_IDataObject &ppDORet) = 0 ;
};

class DELPHICLASS TScrollWinControl;
class PASCALIMPLEMENTATION TScrollWinControl : public Controls::TWinControl 
{
	typedef Controls::TWinControl inherited;
	
protected:
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Msg);
	
public:
	Bsskindata::TbsSkinData* SkinData;
	__fastcall virtual TScrollWinControl(Classes::TComponent* AOwner);
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TScrollWinControl(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TWinControl.Destroy */ inline __fastcall virtual ~TScrollWinControl(void) { }
	#pragma option pop
	
};


class DELPHICLASS TbsaWebBrowser;
class PASCALIMPLEMENTATION TbsaWebBrowser : public Shdocvw::TWebBrowser 
{
	typedef Shdocvw::TWebBrowser inherited;
	
private:
	bool FFrameDoc;
	TScrollWinControl* FVScrollWnd;
	TScrollWinControl* FHScrollWnd;
	TScrollWinControl* FSizeGrip;
	Bsskinctrls::TbsSkinScrollBar* FVScroll;
	Bsskinctrls::TbsSkinScrollBar* FHScroll;
	Bsskindata::TbsSkinData* FSkinData;
	TEnhancedWebBrowserUI* UIProperties;
	Shdocvw::TWebBrowserProgressChange FOnNewProgressChange;
	Shdocvw::TWebBrowserNavigateComplete2 FOnNewNavigateComplete2;
	Shdocvw::TWebBrowserBeforeNavigate2 FOnNewBeforeNavigate2;
	Shdocvw::TWebBrowserCommandStateChange FOnNewCommandStateChange;
	Shdocvw::TWebBrowserDocumentComplete FOnNewDocumentComplete;
	void __fastcall SetSkinData(const Bsskindata::TbsSkinData* Value);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Messages::TMessage &MSg);
	
protected:
	void __fastcall DoBeforeNavigate2(System::TObject* Sender, const _di_IDispatch pDisp, OleVariant &URL, OleVariant &Flags, OleVariant &TargetFrameName, OleVariant &PostData, OleVariant &Headers, Word &Cancel);
	void __fastcall DoCommandStateChange(System::TObject* Sender, int Command, Word Enable);
	void __fastcall DoNavigateComplete2(System::TObject* Sender, const _di_IDispatch pDisp, OleVariant &URL);
	void __fastcall DoDocumentComplete(System::TObject* Sender, const _di_IDispatch pDisp, OleVariant &URL);
	void __fastcall DoProgressChange(System::TObject* Sender, int Progress, int ProgressMax);
	void __fastcall DoVScrollScroll(System::TObject* Sender);
	void __fastcall DoHScrollScroll(System::TObject* Sender);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	virtual void __fastcall Loaded(void);
	HIDESBASE MESSAGE void __fastcall WMSIZE(Messages::TWMSize &Message);
	
public:
	__fastcall virtual TbsaWebBrowser(Classes::TComponent* AOwner);
	__fastcall virtual ~TbsaWebBrowser(void);
	void __fastcall ChangeSkinData(void);
	void __fastcall UpdateScrollbars(void);
	HRESULT __stdcall ShowContextMenu(const unsigned dwID, const Types::PPoint ppt, const System::_di_IInterface pcmdtReserved, const _di_IDispatch pdispReserved);
	HRESULT __stdcall GetHostInfo(TDOCHOSTUIINFO &pInfo);
	HRESULT __stdcall ShowUI(const unsigned dwID, const _di_IOleInPlaceActiveObject pActiveObject, const _di_IOleCommandTarget pCommandTarget, const _di_IOleInPlaceFrame pFrame, const _di_IOleInPlaceUIWindow pDoc);
	HRESULT __stdcall HideUI(void);
	HRESULT __stdcall UpdateUI(void);
	HIDESBASE HRESULT __stdcall EnableModeless(const BOOL fEnable);
	HRESULT __stdcall OnDocWindowActivate(const BOOL fActivate);
	HRESULT __stdcall OnFrameWindowActivate(const BOOL fActivate);
	HRESULT __stdcall ResizeBorder(const Types::PRect prcBorder, const _di_IOleInPlaceUIWindow pUIWindow, const BOOL fRameWindow);
	HRESULT __stdcall TranslateAccelerator(const Windows::PMsg lpMsg, const System::PGUID pguidCmdGroup, const unsigned nCmdID);
	HRESULT __stdcall GetOptionKeyPath(WideChar * &pchKey, const unsigned dw);
/*RESULT __stdcall GetDropTarget(const _di_IDropTarget pDropTarget, _di_IDropTarget &ppDropTarget);*/
	HRESULT __stdcall GetExternal(/* out */ _di_IDispatch &ppDispatch);
	HRESULT __stdcall TranslateUrl(const unsigned dwTranslate, const WideChar * pchURLIn, WideChar * &ppchURLOut);
	HRESULT __stdcall FilterDataObject(const _di_IDataObject pDO, /* out */ _di_IDataObject &ppDORet);
	__property TEnhancedWebBrowserUI* UISettings = {read=UIProperties, write=UIProperties};
	
__published:
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property Bsskindata::TbsSkinData* SkinData = {read=FSkinData, write=SetSkinData};
	__property Shdocvw::TWebBrowserProgressChange OnNewProgressChange = {read=FOnNewProgressChange, write=FOnNewProgressChange};
	__property Shdocvw::TWebBrowserNavigateComplete2 OnNewNavigateComplete2 = {read=FOnNewNavigateComplete2, write=FOnNewNavigateComplete2};
	__property Shdocvw::TWebBrowserBeforeNavigate2 OnNewBeforeNavigate2 = {read=FOnNewBeforeNavigate2, write=FOnNewBeforeNavigate2};
	__property Shdocvw::TWebBrowserCommandStateChange OnNewCommandStateChange = {read=FOnNewCommandStateChange, write=FOnNewCommandStateChange};
	__property Shdocvw::TWebBrowserDocumentComplete OnNewDocumentComplete = {read=FOnNewDocumentComplete, write=FOnNewDocumentComplete};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TbsaWebBrowser(HWND ParentWindow) : Shdocvw::TWebBrowser(ParentWindow) { }
	#pragma option pop
	
private:
	void *__IDocHostUIHandler;	/* Bsawebbrowser::IDocHostUIHandler */
	
public:
	operator IDocHostUIHandler*(void) { return (IDocHostUIHandler*)&__IDocHostUIHandler; }
	
};


//-- var, const, procedure ---------------------------------------------------
static const Shortint DOCHOSTUIFLAG_SCROLL_NO = 0x8;
static const Byte DOCHOSTUIFLAG_FLAT_SCROLLBAR = 0x80;
static const Shortint DOCHOSTUIFLAG_NO3DBORDER = 0x4;
extern PACKAGE void __fastcall Register(void);

}	/* namespace Bsawebbrowser */
using namespace Bsawebbrowser;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Bsawebbrowser
