// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SHDocVw.pas' rev: 6.00

#ifndef SHDocVwHPP
#define SHDocVwHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <StdVCL.hpp>	// Pascal unit
#include <OleCtrls.hpp>	// Pascal unit
#include <OleServer.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <ActiveX.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Shdocvw
{
//-- type declarations -------------------------------------------------------
typedef Activex::TOleEnum CommandStateChangeConstants;

typedef Activex::TOleEnum OLECMDID;

typedef Activex::TOleEnum OLECMDF;

typedef Activex::TOleEnum OLECMDEXECOPT;

typedef Activex::TOleEnum tagREADYSTATE;

typedef Activex::TOleEnum ShellWindowTypeConstants;

typedef Activex::TOleEnum ShellWindowFindWindowOptions;

typedef Activex::TOleEnum RefreshConstants;

typedef Activex::TOleEnum BrowserNavConstants;

__interface IWebBrowser;
typedef System::DelphiInterface<IWebBrowser> _di_IWebBrowser;
typedef IWebBrowser WebBrowser_V1;
;

__interface IWebBrowser2;
typedef System::DelphiInterface<IWebBrowser2> _di_IWebBrowser2;
typedef IWebBrowser2 WebBrowser;
;

typedef IWebBrowser2 InternetExplorer;
;

typedef IWebBrowser2 ShellBrowserWindow;
;

__interface IShellWindows;
typedef System::DelphiInterface<IShellWindows> _di_IShellWindows;
typedef IShellWindows ShellWindows;
;

__interface IShellUIHelper;
typedef System::DelphiInterface<IShellUIHelper> _di_IShellUIHelper;
typedef IShellUIHelper ShellUIHelper;
;

__interface IShellFavoritesNameSpace;
typedef System::DelphiInterface<IShellFavoritesNameSpace> _di_IShellFavoritesNameSpace;
typedef IShellFavoritesNameSpace ShellFavoritesNameSpace;
;

__interface IScriptErrorList;
typedef System::DelphiInterface<IScriptErrorList> _di_IScriptErrorList;
typedef IScriptErrorList CScriptErrorList;
;

__interface ISearchAssistantOC;
typedef System::DelphiInterface<ISearchAssistantOC> _di_ISearchAssistantOC;
typedef ISearchAssistantOC SearchAssistantOC;
;

typedef OleVariant *POleVariant1;

__interface INTERFACE_UUID("{EAB22AC1-30C1-11CF-A7EB-0000C05BAE0B}") IWebBrowser  : public IDispatch 
{
	
public:
	virtual HRESULT __safecall GoBack(void) = 0 ;
	virtual HRESULT __safecall GoForward(void) = 0 ;
	virtual HRESULT __safecall GoHome(void) = 0 ;
	virtual HRESULT __safecall GoSearch(void) = 0 ;
	virtual HRESULT __safecall Navigate(const WideString URL, OleVariant &Flags, OleVariant &TargetFrameName, OleVariant &PostData, OleVariant &Headers) = 0 ;
	virtual HRESULT __safecall Refresh(void) = 0 ;
	virtual HRESULT __safecall Refresh2(OleVariant &Level) = 0 ;
	virtual HRESULT __safecall Stop(void) = 0 ;
	virtual HRESULT __safecall Get_Application(_di_IDispatch &Get_Application_result) = 0 ;
	virtual HRESULT __safecall Get_Parent(_di_IDispatch &Get_Parent_result) = 0 ;
	virtual HRESULT __safecall Get_Container(_di_IDispatch &Get_Container_result) = 0 ;
	virtual HRESULT __safecall Get_Document(_di_IDispatch &Get_Document_result) = 0 ;
	virtual HRESULT __safecall Get_TopLevelContainer(Word &Get_TopLevelContainer_result) = 0 ;
	virtual HRESULT __safecall Get_Type_(WideString &Get_Type__result) = 0 ;
	virtual HRESULT __safecall Get_Left(int &Get_Left_result) = 0 ;
	virtual HRESULT __safecall Set_Left(int pl) = 0 ;
	virtual HRESULT __safecall Get_Top(int &Get_Top_result) = 0 ;
	virtual HRESULT __safecall Set_Top(int pl) = 0 ;
	virtual HRESULT __safecall Get_Width(int &Get_Width_result) = 0 ;
	virtual HRESULT __safecall Set_Width(int pl) = 0 ;
	virtual HRESULT __safecall Get_Height(int &Get_Height_result) = 0 ;
	virtual HRESULT __safecall Set_Height(int pl) = 0 ;
	virtual HRESULT __safecall Get_LocationName(WideString &Get_LocationName_result) = 0 ;
	virtual HRESULT __safecall Get_LocationURL(WideString &Get_LocationURL_result) = 0 ;
	virtual HRESULT __safecall Get_Busy(Word &Get_Busy_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IDispatch _scw_Get_Application() { _di_IDispatch r; HRESULT hr = Get_Application(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property _di_IDispatch Application = {read=_scw_Get_Application};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IDispatch _scw_Get_Parent() { _di_IDispatch r; HRESULT hr = Get_Parent(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property _di_IDispatch Parent = {read=_scw_Get_Parent};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IDispatch _scw_Get_Container() { _di_IDispatch r; HRESULT hr = Get_Container(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property _di_IDispatch Container = {read=_scw_Get_Container};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IDispatch _scw_Get_Document() { _di_IDispatch r; HRESULT hr = Get_Document(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property _di_IDispatch Document = {read=_scw_Get_Document};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Word _scw_Get_TopLevelContainer() { Word r; HRESULT hr = Get_TopLevelContainer(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Word TopLevelContainer = {read=_scw_Get_TopLevelContainer};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_Type_() { WideString r; HRESULT hr = Get_Type_(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString Type_ = {read=_scw_Get_Type_};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_Left() { int r; HRESULT hr = Get_Left(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property int Left = {read=_scw_Get_Left, write=Set_Left};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_Top() { int r; HRESULT hr = Get_Top(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property int Top = {read=_scw_Get_Top, write=Set_Top};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_Width() { int r; HRESULT hr = Get_Width(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property int Width = {read=_scw_Get_Width, write=Set_Width};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_Height() { int r; HRESULT hr = Get_Height(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property int Height = {read=_scw_Get_Height, write=Set_Height};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_LocationName() { WideString r; HRESULT hr = Get_LocationName(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString LocationName = {read=_scw_Get_LocationName};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_LocationURL() { WideString r; HRESULT hr = Get_LocationURL(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString LocationURL = {read=_scw_Get_LocationURL};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Word _scw_Get_Busy() { Word r; HRESULT hr = Get_Busy(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Word Busy = {read=_scw_Get_Busy};
};

__dispinterface IWebBrowserDisp;
typedef System::DelphiInterface<IWebBrowserDisp> _di_IWebBrowserDisp;
__dispinterface INTERFACE_UUID("{EAB22AC1-30C1-11CF-A7EB-0000C05BAE0B}") IWebBrowserDisp  : public IDispatch 
{
	
};

__dispinterface DWebBrowserEvents;
typedef System::DelphiInterface<DWebBrowserEvents> _di_DWebBrowserEvents;
__dispinterface INTERFACE_UUID("{EAB22AC2-30C1-11CF-A7EB-0000C05BAE0B}") DWebBrowserEvents  : public IDispatch 
{
	
};

__interface IWebBrowserApp;
typedef System::DelphiInterface<IWebBrowserApp> _di_IWebBrowserApp;
__interface INTERFACE_UUID("{0002DF05-0000-0000-C000-000000000046}") IWebBrowserApp  : public IWebBrowser 
{
	
public:
	virtual HRESULT __safecall Quit(void) = 0 ;
	virtual HRESULT __safecall ClientToWindow(int &pcx, int &pcy) = 0 ;
	virtual HRESULT __safecall PutProperty(const WideString Property_, const OleVariant vtValue) = 0 ;
	virtual HRESULT __safecall GetProperty(const WideString Property_, OleVariant &GetProperty_result) = 0 ;
	virtual HRESULT __safecall Get_Name(WideString &Get_Name_result) = 0 ;
	virtual HRESULT __safecall Get_HWND(int &Get_HWND_result) = 0 ;
	virtual HRESULT __safecall Get_FullName(WideString &Get_FullName_result) = 0 ;
	virtual HRESULT __safecall Get_Path(WideString &Get_Path_result) = 0 ;
	virtual HRESULT __safecall Get_Visible(Word &Get_Visible_result) = 0 ;
	virtual HRESULT __safecall Set_Visible(Word pBool) = 0 ;
	virtual HRESULT __safecall Get_StatusBar(Word &Get_StatusBar_result) = 0 ;
	virtual HRESULT __safecall Set_StatusBar(Word pBool) = 0 ;
	virtual HRESULT __safecall Get_StatusText(WideString &Get_StatusText_result) = 0 ;
	virtual HRESULT __safecall Set_StatusText(const WideString StatusText) = 0 ;
	virtual HRESULT __safecall Get_ToolBar(int &Get_ToolBar_result) = 0 ;
	virtual HRESULT __safecall Set_ToolBar(int Value) = 0 ;
	virtual HRESULT __safecall Get_MenuBar(Word &Get_MenuBar_result) = 0 ;
	virtual HRESULT __safecall Set_MenuBar(Word Value) = 0 ;
	virtual HRESULT __safecall Get_FullScreen(Word &Get_FullScreen_result) = 0 ;
	virtual HRESULT __safecall Set_FullScreen(Word pbFullScreen) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_Name() { WideString r; HRESULT hr = Get_Name(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString Name = {read=_scw_Get_Name};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_HWND() { int r; HRESULT hr = Get_HWND(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property int HWND = {read=_scw_Get_HWND};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_FullName() { WideString r; HRESULT hr = Get_FullName(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString FullName = {read=_scw_Get_FullName};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_Path() { WideString r; HRESULT hr = Get_Path(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString Path = {read=_scw_Get_Path};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Word _scw_Get_Visible() { Word r; HRESULT hr = Get_Visible(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Word Visible = {read=_scw_Get_Visible, write=Set_Visible};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Word _scw_Get_StatusBar() { Word r; HRESULT hr = Get_StatusBar(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Word StatusBar = {read=_scw_Get_StatusBar, write=Set_StatusBar};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_StatusText() { WideString r; HRESULT hr = Get_StatusText(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString StatusText = {read=_scw_Get_StatusText, write=Set_StatusText};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_ToolBar() { int r; HRESULT hr = Get_ToolBar(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property int ToolBar = {read=_scw_Get_ToolBar, write=Set_ToolBar};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Word _scw_Get_MenuBar() { Word r; HRESULT hr = Get_MenuBar(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Word MenuBar = {read=_scw_Get_MenuBar, write=Set_MenuBar};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Word _scw_Get_FullScreen() { Word r; HRESULT hr = Get_FullScreen(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Word FullScreen = {read=_scw_Get_FullScreen, write=Set_FullScreen};
};

__dispinterface IWebBrowserAppDisp;
typedef System::DelphiInterface<IWebBrowserAppDisp> _di_IWebBrowserAppDisp;
__dispinterface INTERFACE_UUID("{0002DF05-0000-0000-C000-000000000046}") IWebBrowserAppDisp  : public IDispatch 
{
	
};

__interface INTERFACE_UUID("{D30C1661-CDAF-11D0-8A3E-00C04FC9E26E}") IWebBrowser2  : public IWebBrowserApp 
{
	
public:
	virtual HRESULT __safecall Navigate2(OleVariant &URL, OleVariant &Flags, OleVariant &TargetFrameName, OleVariant &PostData, OleVariant &Headers) = 0 ;
	virtual HRESULT __safecall QueryStatusWB(Activex::TOleEnum cmdID, Activex::TOleEnum &QueryStatusWB_result) = 0 ;
	virtual HRESULT __safecall ExecWB(Activex::TOleEnum cmdID, Activex::TOleEnum cmdexecopt, OleVariant &pvaIn, OleVariant &pvaOut) = 0 ;
	virtual HRESULT __safecall ShowBrowserBar(OleVariant &pvaClsid, OleVariant &pvarShow, OleVariant &pvarSize) = 0 ;
	virtual HRESULT __safecall Get_ReadyState(Activex::TOleEnum &Get_ReadyState_result) = 0 ;
	virtual HRESULT __safecall Get_Offline(Word &Get_Offline_result) = 0 ;
	virtual HRESULT __safecall Set_Offline(Word pbOffline) = 0 ;
	virtual HRESULT __safecall Get_Silent(Word &Get_Silent_result) = 0 ;
	virtual HRESULT __safecall Set_Silent(Word pbSilent) = 0 ;
	virtual HRESULT __safecall Get_RegisterAsBrowser(Word &Get_RegisterAsBrowser_result) = 0 ;
	virtual HRESULT __safecall Set_RegisterAsBrowser(Word pbRegister) = 0 ;
	virtual HRESULT __safecall Get_RegisterAsDropTarget(Word &Get_RegisterAsDropTarget_result) = 0 ;
	virtual HRESULT __safecall Set_RegisterAsDropTarget(Word pbRegister) = 0 ;
	virtual HRESULT __safecall Get_TheaterMode(Word &Get_TheaterMode_result) = 0 ;
	virtual HRESULT __safecall Set_TheaterMode(Word pbRegister) = 0 ;
	virtual HRESULT __safecall Get_AddressBar(Word &Get_AddressBar_result) = 0 ;
	virtual HRESULT __safecall Set_AddressBar(Word Value) = 0 ;
	virtual HRESULT __safecall Get_Resizable(Word &Get_Resizable_result) = 0 ;
	virtual HRESULT __safecall Set_Resizable(Word Value) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_ReadyState() { Activex::TOleEnum r; HRESULT hr = Get_ReadyState(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum ReadyState = {read=_scw_Get_ReadyState};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Word _scw_Get_Offline() { Word r; HRESULT hr = Get_Offline(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Word Offline = {read=_scw_Get_Offline, write=Set_Offline};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Word _scw_Get_Silent() { Word r; HRESULT hr = Get_Silent(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Word Silent = {read=_scw_Get_Silent, write=Set_Silent};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Word _scw_Get_RegisterAsBrowser() { Word r; HRESULT hr = Get_RegisterAsBrowser(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Word RegisterAsBrowser = {read=_scw_Get_RegisterAsBrowser, write=Set_RegisterAsBrowser};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Word _scw_Get_RegisterAsDropTarget() { Word r; HRESULT hr = Get_RegisterAsDropTarget(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Word RegisterAsDropTarget = {read=_scw_Get_RegisterAsDropTarget, write=Set_RegisterAsDropTarget};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Word _scw_Get_TheaterMode() { Word r; HRESULT hr = Get_TheaterMode(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Word TheaterMode = {read=_scw_Get_TheaterMode, write=Set_TheaterMode};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Word _scw_Get_AddressBar() { Word r; HRESULT hr = Get_AddressBar(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Word AddressBar = {read=_scw_Get_AddressBar, write=Set_AddressBar};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Word _scw_Get_Resizable() { Word r; HRESULT hr = Get_Resizable(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Word Resizable = {read=_scw_Get_Resizable, write=Set_Resizable};
};

__dispinterface IWebBrowser2Disp;
typedef System::DelphiInterface<IWebBrowser2Disp> _di_IWebBrowser2Disp;
__dispinterface INTERFACE_UUID("{D30C1661-CDAF-11D0-8A3E-00C04FC9E26E}") IWebBrowser2Disp  : public IDispatch 
{
	
};

__dispinterface DWebBrowserEvents2;
typedef System::DelphiInterface<DWebBrowserEvents2> _di_DWebBrowserEvents2;
__dispinterface INTERFACE_UUID("{34A715A0-6587-11D0-924A-0020AFC7AC4D}") DWebBrowserEvents2  : public IDispatch 
{
	
};

__dispinterface DShellWindowsEvents;
typedef System::DelphiInterface<DShellWindowsEvents> _di_DShellWindowsEvents;
__dispinterface INTERFACE_UUID("{FE4106E0-399A-11D0-A48C-00A0C90A8F39}") DShellWindowsEvents  : public IDispatch 
{
	
};

__interface INTERFACE_UUID("{85CB6900-4D95-11CF-960C-0080C7F4EE85}") IShellWindows  : public IDispatch 
{
	
public:
	virtual HRESULT __safecall Get_Count(int &Get_Count_result) = 0 ;
	virtual HRESULT __safecall Item(const OleVariant index, _di_IDispatch &Item_result) = 0 ;
	virtual HRESULT __safecall _NewEnum(System::_di_IInterface &_NewEnum_result) = 0 ;
	virtual HRESULT __safecall Register(const _di_IDispatch pid, int HWND, int swClass, /* out */ int &plCookie) = 0 ;
	virtual HRESULT __safecall RegisterPending(int lThreadId, OleVariant &pvarloc, OleVariant &pvarlocRoot, int swClass, /* out */ int &plCookie) = 0 ;
	virtual HRESULT __safecall Revoke(int lCookie) = 0 ;
	virtual HRESULT __safecall OnNavigate(int lCookie, OleVariant &pvarloc) = 0 ;
	virtual HRESULT __safecall OnActivated(int lCookie, Word fActive) = 0 ;
	virtual HRESULT __safecall FindWindow(OleVariant &pvarloc, OleVariant &pvarlocRoot, int swClass, /* out */ int &pHWND, int swfwOptions, _di_IDispatch &FindWindow_result) = 0 ;
	virtual HRESULT __safecall OnCreated(int lCookie, const System::_di_IInterface punk) = 0 ;
	virtual HRESULT __safecall ProcessAttachDetach(Word fAttach) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_Count() { int r; HRESULT hr = Get_Count(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property int Count = {read=_scw_Get_Count};
};

__dispinterface IShellWindowsDisp;
typedef System::DelphiInterface<IShellWindowsDisp> _di_IShellWindowsDisp;
__dispinterface INTERFACE_UUID("{85CB6900-4D95-11CF-960C-0080C7F4EE85}") IShellWindowsDisp  : public IDispatch 
{
	
};

__interface INTERFACE_UUID("{729FE2F8-1EA8-11D1-8F85-00C04FC2FBE1}") IShellUIHelper  : public IDispatch 
{
	
public:
	virtual HRESULT __safecall ResetFirstBootMode(void) = 0 ;
	virtual HRESULT __safecall ResetSafeMode(void) = 0 ;
	virtual HRESULT __safecall RefreshOfflineDesktop(void) = 0 ;
	virtual HRESULT __safecall AddFavorite(const WideString URL, OleVariant &Title) = 0 ;
	virtual HRESULT __safecall AddChannel(const WideString URL) = 0 ;
	virtual HRESULT __safecall AddDesktopComponent(const WideString URL, const WideString Type_, OleVariant &Left, OleVariant &Top, OleVariant &Width, OleVariant &Height) = 0 ;
	virtual HRESULT __safecall IsSubscribed(const WideString URL, Word &IsSubscribed_result) = 0 ;
	virtual HRESULT __safecall NavigateAndFind(const WideString URL, const WideString strQuery, OleVariant &varTargetFrame) = 0 ;
	virtual HRESULT __safecall ImportExportFavorites(Word fImport, const WideString strImpExpPath) = 0 ;
	virtual HRESULT __safecall AutoCompleteSaveForm(OleVariant &Form) = 0 ;
	virtual HRESULT __safecall AutoScan(const WideString strSearch, const WideString strFailureUrl, OleVariant &pvarTargetFrame) = 0 ;
	virtual HRESULT __safecall AutoCompleteAttach(OleVariant &Reserved) = 0 ;
	virtual HRESULT __safecall ShowBrowserUI(const WideString bstrName, OleVariant &pvarIn, OleVariant &ShowBrowserUI_result) = 0 ;
};

__dispinterface IShellUIHelperDisp;
typedef System::DelphiInterface<IShellUIHelperDisp> _di_IShellUIHelperDisp;
__dispinterface INTERFACE_UUID("{729FE2F8-1EA8-11D1-8F85-00C04FC2FBE1}") IShellUIHelperDisp  : public IDispatch 
{
	
};

__dispinterface _ShellFavoritesNameSpaceEvents;
typedef System::DelphiInterface<_ShellFavoritesNameSpaceEvents> _di__ShellFavoritesNameSpaceEvents;
__dispinterface INTERFACE_UUID("{55136806-B2DE-11D1-B9F2-00A0C98BC547}") _ShellFavoritesNameSpaceEvents  : public IDispatch 
{
	
};

__interface INTERFACE_UUID("{55136804-B2DE-11D1-B9F2-00A0C98BC547}") IShellFavoritesNameSpace  : public IDispatch 
{
	
public:
	virtual HRESULT __safecall MoveSelectionUp(void) = 0 ;
	virtual HRESULT __safecall MoveSelectionDown(void) = 0 ;
	virtual HRESULT __safecall ResetSort(void) = 0 ;
	virtual HRESULT __safecall NewFolder(void) = 0 ;
	virtual HRESULT __safecall Synchronize(void) = 0 ;
	virtual HRESULT __safecall Import(void) = 0 ;
	virtual HRESULT __safecall Export(void) = 0 ;
	virtual HRESULT __safecall InvokeContextMenuCommand(const WideString strCommand) = 0 ;
	virtual HRESULT __safecall MoveSelectionTo(void) = 0 ;
	virtual HRESULT __safecall Get_FOfflinePackInstalled(Word &Get_FOfflinePackInstalled_result) = 0 ;
	virtual HRESULT __safecall CreateSubscriptionForSelection(Word &CreateSubscriptionForSelection_result) = 0 ;
	virtual HRESULT __safecall DeleteSubscriptionForSelection(Word &DeleteSubscriptionForSelection_result) = 0 ;
	virtual HRESULT __safecall SetRoot(const WideString bstrFullPath) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline Word _scw_Get_FOfflinePackInstalled() { Word r; HRESULT hr = Get_FOfflinePackInstalled(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Word FOfflinePackInstalled = {read=_scw_Get_FOfflinePackInstalled};
};

__dispinterface IShellFavoritesNameSpaceDisp;
typedef System::DelphiInterface<IShellFavoritesNameSpaceDisp> _di_IShellFavoritesNameSpaceDisp;
__dispinterface INTERFACE_UUID("{55136804-B2DE-11D1-B9F2-00A0C98BC547}") IShellFavoritesNameSpaceDisp  : public IDispatch 
{
	
};

__interface INTERFACE_UUID("{F3470F24-15FD-11D2-BB2E-00805FF7EFCA}") IScriptErrorList  : public IDispatch 
{
	
public:
	virtual HRESULT __safecall advanceError(void) = 0 ;
	virtual HRESULT __safecall retreatError(void) = 0 ;
	virtual HRESULT __safecall canAdvanceError(int &canAdvanceError_result) = 0 ;
	virtual HRESULT __safecall canRetreatError(int &canRetreatError_result) = 0 ;
	virtual HRESULT __safecall getErrorLine(int &getErrorLine_result) = 0 ;
	virtual HRESULT __safecall getErrorChar(int &getErrorChar_result) = 0 ;
	virtual HRESULT __safecall getErrorCode(int &getErrorCode_result) = 0 ;
	virtual HRESULT __safecall getErrorMsg(WideString &getErrorMsg_result) = 0 ;
	virtual HRESULT __safecall getErrorUrl(WideString &getErrorUrl_result) = 0 ;
	virtual HRESULT __safecall getAlwaysShowLockState(int &getAlwaysShowLockState_result) = 0 ;
	virtual HRESULT __safecall getDetailsPaneOpen(int &getDetailsPaneOpen_result) = 0 ;
	virtual HRESULT __safecall setDetailsPaneOpen(int fDetailsPaneOpen) = 0 ;
	virtual HRESULT __safecall getPerErrorDisplay(int &getPerErrorDisplay_result) = 0 ;
	virtual HRESULT __safecall setPerErrorDisplay(int fPerErrorDisplay) = 0 ;
};

__dispinterface IScriptErrorListDisp;
typedef System::DelphiInterface<IScriptErrorListDisp> _di_IScriptErrorListDisp;
__dispinterface INTERFACE_UUID("{F3470F24-15FD-11D2-BB2E-00805FF7EFCA}") IScriptErrorListDisp  : public IDispatch 
{
	
};

__interface ISearch;
typedef System::DelphiInterface<ISearch> _di_ISearch;
__interface INTERFACE_UUID("{BA9239A4-3DD5-11D2-BF8B-00C04FB93661}") ISearch  : public IDispatch 
{
	
public:
	virtual HRESULT __safecall Get_Title(WideString &Get_Title_result) = 0 ;
	virtual HRESULT __safecall Get_Id(WideString &Get_Id_result) = 0 ;
	virtual HRESULT __safecall Get_URL(WideString &Get_URL_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_Title() { WideString r; HRESULT hr = Get_Title(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString Title = {read=_scw_Get_Title};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_Id() { WideString r; HRESULT hr = Get_Id(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString Id = {read=_scw_Get_Id};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_URL() { WideString r; HRESULT hr = Get_URL(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString URL = {read=_scw_Get_URL};
};

__dispinterface ISearchDisp;
typedef System::DelphiInterface<ISearchDisp> _di_ISearchDisp;
__dispinterface INTERFACE_UUID("{BA9239A4-3DD5-11D2-BF8B-00C04FB93661}") ISearchDisp  : public IDispatch 
{
	
};

__interface ISearches;
typedef System::DelphiInterface<ISearches> _di_ISearches;
__interface INTERFACE_UUID("{47C922A2-3DD5-11D2-BF8B-00C04FB93661}") ISearches  : public IDispatch 
{
	
public:
	virtual HRESULT __safecall Get_Count(int &Get_Count_result) = 0 ;
	virtual HRESULT __safecall Get_Default(WideString &Get_Default_result) = 0 ;
	virtual HRESULT __safecall Item(const OleVariant index, _di_ISearch &Item_result) = 0 ;
	virtual HRESULT __safecall _NewEnum(System::_di_IInterface &_NewEnum_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_Count() { int r; HRESULT hr = Get_Count(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property int Count = {read=_scw_Get_Count};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_Default() { WideString r; HRESULT hr = Get_Default(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString Default = {read=_scw_Get_Default};
};

__dispinterface ISearchesDisp;
typedef System::DelphiInterface<ISearchesDisp> _di_ISearchesDisp;
__dispinterface INTERFACE_UUID("{47C922A2-3DD5-11D2-BF8B-00C04FB93661}") ISearchesDisp  : public IDispatch 
{
	
};

__interface INTERFACE_UUID("{72423E8F-8011-11D2-BE79-00A0C9A83DA1}") ISearchAssistantOC  : public IDispatch 
{
	
public:
	virtual HRESULT __safecall AddNextMenuItem(const WideString bstrText, int idItem) = 0 ;
	virtual HRESULT __safecall SetDefaultSearchUrl(const WideString bstrUrl) = 0 ;
	virtual HRESULT __safecall NavigateToDefaultSearch(void) = 0 ;
	virtual HRESULT __safecall IsRestricted(const WideString bstrGuid, Word &IsRestricted_result) = 0 ;
	virtual HRESULT __safecall Get_ShellFeaturesEnabled(Word &Get_ShellFeaturesEnabled_result) = 0 ;
	virtual HRESULT __safecall Get_SearchAssistantDefault(Word &Get_SearchAssistantDefault_result) = 0 ;
	virtual HRESULT __safecall Get_Searches(_di_ISearches &Get_Searches_result) = 0 ;
	virtual HRESULT __safecall Get_InWebFolder(Word &Get_InWebFolder_result) = 0 ;
	virtual HRESULT __safecall PutProperty(Word bPerLocale, const WideString bstrName, const WideString bstrValue) = 0 ;
	virtual HRESULT __safecall GetProperty(Word bPerLocale, const WideString bstrName, WideString &GetProperty_result) = 0 ;
	virtual HRESULT __safecall Set_EventHandled(Word Param1) = 0 ;
	virtual HRESULT __safecall ResetNextMenu(void) = 0 ;
	virtual HRESULT __safecall FindOnWeb(void) = 0 ;
	virtual HRESULT __safecall FindFilesOrFolders(void) = 0 ;
	virtual HRESULT __safecall FindComputer(void) = 0 ;
	virtual HRESULT __safecall FindPrinter(void) = 0 ;
	virtual HRESULT __safecall FindPeople(void) = 0 ;
	virtual HRESULT __safecall GetSearchAssistantURL(Word bSubstitute, Word bCustomize, WideString &GetSearchAssistantURL_result) = 0 ;
	virtual HRESULT __safecall NotifySearchSettingsChanged(void) = 0 ;
	virtual HRESULT __safecall Set_ASProvider(const WideString pProvider) = 0 ;
	virtual HRESULT __safecall Get_ASProvider(WideString &Get_ASProvider_result) = 0 ;
	virtual HRESULT __safecall Set_ASSetting(int pSetting) = 0 ;
	virtual HRESULT __safecall Get_ASSetting(int &Get_ASSetting_result) = 0 ;
	virtual HRESULT __safecall NETDetectNextNavigate(void) = 0 ;
	virtual HRESULT __safecall PutFindText(const WideString FindText) = 0 ;
	virtual HRESULT __safecall Get_Version(int &Get_Version_result) = 0 ;
	virtual HRESULT __safecall EncodeString(const WideString bstrValue, const WideString bstrCharSet, Word bUseUTF8, WideString &EncodeString_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline Word _scw_Get_ShellFeaturesEnabled() { Word r; HRESULT hr = Get_ShellFeaturesEnabled(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Word ShellFeaturesEnabled = {read=_scw_Get_ShellFeaturesEnabled};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Word _scw_Get_SearchAssistantDefault() { Word r; HRESULT hr = Get_SearchAssistantDefault(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Word SearchAssistantDefault = {read=_scw_Get_SearchAssistantDefault};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_ISearches _scw_Get_Searches() { _di_ISearches r; HRESULT hr = Get_Searches(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property _di_ISearches Searches = {read=_scw_Get_Searches};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Word _scw_Get_InWebFolder() { Word r; HRESULT hr = Get_InWebFolder(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Word InWebFolder = {read=_scw_Get_InWebFolder};
	__property Word EventHandled = {write=Set_EventHandled};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_ASProvider() { WideString r; HRESULT hr = Get_ASProvider(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString ASProvider = {read=_scw_Get_ASProvider, write=Set_ASProvider};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_ASSetting() { int r; HRESULT hr = Get_ASSetting(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property int ASSetting = {read=_scw_Get_ASSetting, write=Set_ASSetting};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_Version() { int r; HRESULT hr = Get_Version(r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property int Version = {read=_scw_Get_Version};
};

__dispinterface ISearchAssistantOCDisp;
typedef System::DelphiInterface<ISearchAssistantOCDisp> _di_ISearchAssistantOCDisp;
__dispinterface INTERFACE_UUID("{72423E8F-8011-11D2-BE79-00A0C9A83DA1}") ISearchAssistantOCDisp  : public IDispatch 
{
	
};

__dispinterface _SearchAssistantEvents;
typedef System::DelphiInterface<_SearchAssistantEvents> _di__SearchAssistantEvents;
__dispinterface INTERFACE_UUID("{1611FDDA-445B-11D2-85DE-00C04FA35C89}") _SearchAssistantEvents  : public IDispatch 
{
	
};

typedef void __fastcall (__closure *TWebBrowser_V1BeforeNavigate)(System::TObject* Sender, const WideString URL, int Flags, const WideString TargetFrameName, OleVariant &PostData, const WideString Headers, Word &Cancel);

typedef void __fastcall (__closure *TWebBrowser_V1NavigateComplete)(System::TObject* Sender, const WideString URL);

typedef void __fastcall (__closure *TWebBrowser_V1StatusTextChange)(System::TObject* Sender, const WideString Text);

typedef void __fastcall (__closure *TWebBrowser_V1ProgressChange)(System::TObject* Sender, int Progress, int ProgressMax);

typedef void __fastcall (__closure *TWebBrowser_V1CommandStateChange)(System::TObject* Sender, int Command, Word Enable);

typedef void __fastcall (__closure *TWebBrowser_V1NewWindow)(System::TObject* Sender, const WideString URL, int Flags, const WideString TargetFrameName, OleVariant &PostData, const WideString Headers, Word &Processed);

typedef void __fastcall (__closure *TWebBrowser_V1TitleChange)(System::TObject* Sender, const WideString Text);

typedef void __fastcall (__closure *TWebBrowser_V1FrameBeforeNavigate)(System::TObject* Sender, const WideString URL, int Flags, const WideString TargetFrameName, OleVariant &PostData, const WideString Headers, Word &Cancel);

typedef void __fastcall (__closure *TWebBrowser_V1FrameNavigateComplete)(System::TObject* Sender, const WideString URL);

typedef void __fastcall (__closure *TWebBrowser_V1FrameNewWindow)(System::TObject* Sender, const WideString URL, int Flags, const WideString TargetFrameName, OleVariant &PostData, const WideString Headers, Word &Processed);

typedef void __fastcall (__closure *TWebBrowser_V1Quit)(System::TObject* Sender, Word &Cancel);

typedef void __fastcall (__closure *TWebBrowser_V1PropertyChange)(System::TObject* Sender, const WideString Property_);

class DELPHICLASS TWebBrowser_V1;
class PASCALIMPLEMENTATION TWebBrowser_V1 : public Olectrls::TOleControl 
{
	typedef Olectrls::TOleControl inherited;
	
private:
	TWebBrowser_V1BeforeNavigate FOnBeforeNavigate;
	TWebBrowser_V1NavigateComplete FOnNavigateComplete;
	TWebBrowser_V1StatusTextChange FOnStatusTextChange;
	TWebBrowser_V1ProgressChange FOnProgressChange;
	Classes::TNotifyEvent FOnDownloadComplete;
	TWebBrowser_V1CommandStateChange FOnCommandStateChange;
	Classes::TNotifyEvent FOnDownloadBegin;
	TWebBrowser_V1NewWindow FOnNewWindow;
	TWebBrowser_V1TitleChange FOnTitleChange;
	TWebBrowser_V1FrameBeforeNavigate FOnFrameBeforeNavigate;
	TWebBrowser_V1FrameNavigateComplete FOnFrameNavigateComplete;
	TWebBrowser_V1FrameNewWindow FOnFrameNewWindow;
	TWebBrowser_V1Quit FOnQuit;
	Classes::TNotifyEvent FOnWindowMove;
	Classes::TNotifyEvent FOnWindowResize;
	Classes::TNotifyEvent FOnWindowActivate;
	TWebBrowser_V1PropertyChange FOnPropertyChange;
	_di_IWebBrowser FIntf;
	_di_IWebBrowser __fastcall GetControlInterface();
	
protected:
	HIDESBASE void __fastcall CreateControl(void);
	virtual void __fastcall InitControlData(void);
	_di_IDispatch __fastcall Get_Application();
	_di_IDispatch __fastcall Get_Parent();
	_di_IDispatch __fastcall Get_Container();
	_di_IDispatch __fastcall Get_Document();
	
public:
	void __fastcall GoBack(void);
	void __fastcall GoForward(void);
	void __fastcall GoHome(void);
	void __fastcall GoSearch(void);
	void __fastcall Navigate(const WideString URL)/* overload */;
	void __fastcall Navigate(const WideString URL, OleVariant &Flags)/* overload */;
	void __fastcall Navigate(const WideString URL, OleVariant &Flags, OleVariant &TargetFrameName)/* overload */;
	void __fastcall Navigate(const WideString URL, OleVariant &Flags, OleVariant &TargetFrameName, OleVariant &PostData)/* overload */;
	void __fastcall Navigate(const WideString URL, OleVariant &Flags, OleVariant &TargetFrameName, OleVariant &PostData, OleVariant &Headers)/* overload */;
	HIDESBASE void __fastcall Refresh(void);
	void __fastcall Refresh2(void)/* overload */;
	void __fastcall Refresh2(OleVariant &Level)/* overload */;
	void __fastcall Stop(void);
	__property _di_IWebBrowser ControlInterface = {read=GetControlInterface};
	__property _di_IWebBrowser DefaultInterface = {read=GetControlInterface};
	__property _di_IDispatch Application = {read=GetIDispatchProp, index=200};
	__property _di_IDispatch Parent = {read=GetIDispatchProp, index=201};
	__property _di_IDispatch Container = {read=GetIDispatchProp, index=202};
	__property _di_IDispatch Document = {read=GetIDispatchProp, index=203};
	__property Word TopLevelContainer = {read=GetWordBoolProp, index=204, nodefault};
	__property WideString Type_ = {read=GetWideStringProp, index=205};
	__property WideString LocationName = {read=GetWideStringProp, index=210};
	__property WideString LocationURL = {read=GetWideStringProp, index=211};
	__property Word Busy = {read=GetWordBoolProp, index=212, nodefault};
	
__published:
	__property TabStop  = {default=1};
	__property Align  = {default=0};
	__property DragCursor  = {default=-12};
	__property DragMode  = {default=0};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property Visible  = {default=1};
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnStartDrag ;
	__property TWebBrowser_V1BeforeNavigate OnBeforeNavigate = {read=FOnBeforeNavigate, write=FOnBeforeNavigate};
	__property TWebBrowser_V1NavigateComplete OnNavigateComplete = {read=FOnNavigateComplete, write=FOnNavigateComplete};
	__property TWebBrowser_V1StatusTextChange OnStatusTextChange = {read=FOnStatusTextChange, write=FOnStatusTextChange};
	__property TWebBrowser_V1ProgressChange OnProgressChange = {read=FOnProgressChange, write=FOnProgressChange};
	__property Classes::TNotifyEvent OnDownloadComplete = {read=FOnDownloadComplete, write=FOnDownloadComplete};
	__property TWebBrowser_V1CommandStateChange OnCommandStateChange = {read=FOnCommandStateChange, write=FOnCommandStateChange};
	__property Classes::TNotifyEvent OnDownloadBegin = {read=FOnDownloadBegin, write=FOnDownloadBegin};
	__property TWebBrowser_V1NewWindow OnNewWindow = {read=FOnNewWindow, write=FOnNewWindow};
	__property TWebBrowser_V1TitleChange OnTitleChange = {read=FOnTitleChange, write=FOnTitleChange};
	__property TWebBrowser_V1FrameBeforeNavigate OnFrameBeforeNavigate = {read=FOnFrameBeforeNavigate, write=FOnFrameBeforeNavigate};
	__property TWebBrowser_V1FrameNavigateComplete OnFrameNavigateComplete = {read=FOnFrameNavigateComplete, write=FOnFrameNavigateComplete};
	__property TWebBrowser_V1FrameNewWindow OnFrameNewWindow = {read=FOnFrameNewWindow, write=FOnFrameNewWindow};
	__property TWebBrowser_V1Quit OnQuit = {read=FOnQuit, write=FOnQuit};
	__property Classes::TNotifyEvent OnWindowMove = {read=FOnWindowMove, write=FOnWindowMove};
	__property Classes::TNotifyEvent OnWindowResize = {read=FOnWindowResize, write=FOnWindowResize};
	__property Classes::TNotifyEvent OnWindowActivate = {read=FOnWindowActivate, write=FOnWindowActivate};
	__property TWebBrowser_V1PropertyChange OnPropertyChange = {read=FOnPropertyChange, write=FOnPropertyChange};
public:
	#pragma option push -w-inl
	/* TOleControl.Create */ inline __fastcall virtual TWebBrowser_V1(Classes::TComponent* AOwner) : Olectrls::TOleControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TOleControl.Destroy */ inline __fastcall virtual ~TWebBrowser_V1(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TWebBrowser_V1(HWND ParentWindow) : Olectrls::TOleControl(ParentWindow) { }
	#pragma option pop
	
};


typedef void __fastcall (__closure *TWebBrowserStatusTextChange)(System::TObject* Sender, const WideString Text);

typedef void __fastcall (__closure *TWebBrowserProgressChange)(System::TObject* Sender, int Progress, int ProgressMax);

typedef void __fastcall (__closure *TWebBrowserCommandStateChange)(System::TObject* Sender, int Command, Word Enable);

typedef void __fastcall (__closure *TWebBrowserTitleChange)(System::TObject* Sender, const WideString Text);

typedef void __fastcall (__closure *TWebBrowserPropertyChange)(System::TObject* Sender, const WideString szProperty);

typedef void __fastcall (__closure *TWebBrowserBeforeNavigate2)(System::TObject* Sender, const _di_IDispatch pDisp, OleVariant &URL, OleVariant &Flags, OleVariant &TargetFrameName, OleVariant &PostData, OleVariant &Headers, Word &Cancel);

typedef void __fastcall (__closure *TWebBrowserNewWindow2)(System::TObject* Sender, _di_IDispatch &ppDisp, Word &Cancel);

typedef void __fastcall (__closure *TWebBrowserNavigateComplete2)(System::TObject* Sender, const _di_IDispatch pDisp, OleVariant &URL);

typedef void __fastcall (__closure *TWebBrowserDocumentComplete)(System::TObject* Sender, const _di_IDispatch pDisp, OleVariant &URL);

typedef void __fastcall (__closure *TWebBrowserOnVisible)(System::TObject* Sender, Word Visible);

typedef void __fastcall (__closure *TWebBrowserOnToolBar)(System::TObject* Sender, Word ToolBar);

typedef void __fastcall (__closure *TWebBrowserOnMenuBar)(System::TObject* Sender, Word MenuBar);

typedef void __fastcall (__closure *TWebBrowserOnStatusBar)(System::TObject* Sender, Word StatusBar);

typedef void __fastcall (__closure *TWebBrowserOnFullScreen)(System::TObject* Sender, Word FullScreen);

typedef void __fastcall (__closure *TWebBrowserOnTheaterMode)(System::TObject* Sender, Word TheaterMode);

class DELPHICLASS TWebBrowser;
class PASCALIMPLEMENTATION TWebBrowser : public Olectrls::TOleControl 
{
	typedef Olectrls::TOleControl inherited;
	
private:
	TWebBrowserStatusTextChange FOnStatusTextChange;
	TWebBrowserProgressChange FOnProgressChange;
	TWebBrowserCommandStateChange FOnCommandStateChange;
	Classes::TNotifyEvent FOnDownloadBegin;
	Classes::TNotifyEvent FOnDownloadComplete;
	TWebBrowserTitleChange FOnTitleChange;
	TWebBrowserPropertyChange FOnPropertyChange;
	TWebBrowserBeforeNavigate2 FOnBeforeNavigate2;
	TWebBrowserNewWindow2 FOnNewWindow2;
	TWebBrowserNavigateComplete2 FOnNavigateComplete2;
	TWebBrowserDocumentComplete FOnDocumentComplete;
	Classes::TNotifyEvent FOnQuit;
	TWebBrowserOnVisible FOnVisible;
	TWebBrowserOnToolBar FOnToolBar;
	TWebBrowserOnMenuBar FOnMenuBar;
	TWebBrowserOnStatusBar FOnStatusBar;
	TWebBrowserOnFullScreen FOnFullScreen;
	TWebBrowserOnTheaterMode FOnTheaterMode;
	_di_IWebBrowser2 FIntf;
	_di_IWebBrowser2 __fastcall GetControlInterface();
	
protected:
	HIDESBASE void __fastcall CreateControl(void);
	virtual void __fastcall InitControlData(void);
	_di_IDispatch __fastcall Get_Application();
	_di_IDispatch __fastcall Get_Parent();
	_di_IDispatch __fastcall Get_Container();
	_di_IDispatch __fastcall Get_Document();
	
public:
	void __fastcall GoBack(void);
	void __fastcall GoForward(void);
	void __fastcall GoHome(void);
	void __fastcall GoSearch(void);
	void __fastcall Navigate(const WideString URL)/* overload */;
	void __fastcall Navigate(const WideString URL, OleVariant &Flags)/* overload */;
	void __fastcall Navigate(const WideString URL, OleVariant &Flags, OleVariant &TargetFrameName)/* overload */;
	void __fastcall Navigate(const WideString URL, OleVariant &Flags, OleVariant &TargetFrameName, OleVariant &PostData)/* overload */;
	void __fastcall Navigate(const WideString URL, OleVariant &Flags, OleVariant &TargetFrameName, OleVariant &PostData, OleVariant &Headers)/* overload */;
	HIDESBASE void __fastcall Refresh(void);
	void __fastcall Refresh2(void)/* overload */;
	void __fastcall Refresh2(OleVariant &Level)/* overload */;
	void __fastcall Stop(void);
	void __fastcall Quit(void);
	void __fastcall ClientToWindow(int &pcx, int &pcy);
	void __fastcall PutProperty(const WideString Property_, const OleVariant &vtValue);
	HIDESBASE OleVariant __fastcall GetProperty(const WideString Property_);
	void __fastcall Navigate2(OleVariant &URL)/* overload */;
	void __fastcall Navigate2(OleVariant &URL, OleVariant &Flags)/* overload */;
	void __fastcall Navigate2(OleVariant &URL, OleVariant &Flags, OleVariant &TargetFrameName)/* overload */;
	void __fastcall Navigate2(OleVariant &URL, OleVariant &Flags, OleVariant &TargetFrameName, OleVariant &PostData)/* overload */;
	void __fastcall Navigate2(OleVariant &URL, OleVariant &Flags, OleVariant &TargetFrameName, OleVariant &PostData, OleVariant &Headers)/* overload */;
	Activex::TOleEnum __fastcall QueryStatusWB(Activex::TOleEnum cmdID);
	void __fastcall ExecWB(Activex::TOleEnum cmdID, Activex::TOleEnum cmdexecopt)/* overload */;
	void __fastcall ExecWB(Activex::TOleEnum cmdID, Activex::TOleEnum cmdexecopt, OleVariant &pvaIn)/* overload */;
	void __fastcall ExecWB(Activex::TOleEnum cmdID, Activex::TOleEnum cmdexecopt, OleVariant &pvaIn, OleVariant &pvaOut)/* overload */;
	void __fastcall ShowBrowserBar(OleVariant &pvaClsid)/* overload */;
	void __fastcall ShowBrowserBar(OleVariant &pvaClsid, OleVariant &pvarShow)/* overload */;
	void __fastcall ShowBrowserBar(OleVariant &pvaClsid, OleVariant &pvarShow, OleVariant &pvarSize)/* overload */;
	__property _di_IWebBrowser2 ControlInterface = {read=GetControlInterface};
	__property _di_IWebBrowser2 DefaultInterface = {read=GetControlInterface};
	__property _di_IDispatch Application = {read=GetIDispatchProp, index=200};
	__property _di_IDispatch Parent = {read=GetIDispatchProp, index=201};
	__property _di_IDispatch Container = {read=GetIDispatchProp, index=202};
	__property _di_IDispatch Document = {read=GetIDispatchProp, index=203};
	__property Word TopLevelContainer = {read=GetWordBoolProp, index=204, nodefault};
	__property WideString Type_ = {read=GetWideStringProp, index=205};
	__property WideString LocationName = {read=GetWideStringProp, index=210};
	__property WideString LocationURL = {read=GetWideStringProp, index=211};
	__property Word Busy = {read=GetWordBoolProp, index=212, nodefault};
	__property WideString Name = {read=GetWideStringProp, index=0};
	__property int HWND = {read=GetIntegerProp, index=-515, nodefault};
	__property WideString FullName = {read=GetWideStringProp, index=400};
	__property WideString Path = {read=GetWideStringProp, index=401};
	__property Activex::TOleEnum ReadyState = {read=GetTOleEnumProp, index=-525, nodefault};
	
__published:
	__property TabStop  = {default=1};
	__property Align  = {default=0};
	__property DragCursor  = {default=-12};
	__property DragMode  = {default=0};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnStartDrag ;
	__property Word Visible = {read=GetWordBoolProp, write=SetWordBoolProp, stored=false, index=402, nodefault};
	__property Word StatusBar = {read=GetWordBoolProp, write=SetWordBoolProp, stored=false, index=403, nodefault};
	__property WideString StatusText = {read=GetWideStringProp, write=SetWideStringProp, stored=false, index=404};
	__property int ToolBar = {read=GetIntegerProp, write=SetIntegerProp, stored=false, index=405, nodefault};
	__property Word MenuBar = {read=GetWordBoolProp, write=SetWordBoolProp, stored=false, index=406, nodefault};
	__property Word FullScreen = {read=GetWordBoolProp, write=SetWordBoolProp, stored=false, index=407, nodefault};
	__property Word Offline = {read=GetWordBoolProp, write=SetWordBoolProp, stored=false, index=550, nodefault};
	__property Word Silent = {read=GetWordBoolProp, write=SetWordBoolProp, stored=false, index=551, nodefault};
	__property Word RegisterAsBrowser = {read=GetWordBoolProp, write=SetWordBoolProp, stored=false, index=552, nodefault};
	__property Word RegisterAsDropTarget = {read=GetWordBoolProp, write=SetWordBoolProp, stored=false, index=553, nodefault};
	__property Word TheaterMode = {read=GetWordBoolProp, write=SetWordBoolProp, stored=false, index=554, nodefault};
	__property Word AddressBar = {read=GetWordBoolProp, write=SetWordBoolProp, stored=false, index=555, nodefault};
	__property Word Resizable = {read=GetWordBoolProp, write=SetWordBoolProp, stored=false, index=556, nodefault};
	__property TWebBrowserStatusTextChange OnStatusTextChange = {read=FOnStatusTextChange, write=FOnStatusTextChange};
	__property TWebBrowserProgressChange OnProgressChange = {read=FOnProgressChange, write=FOnProgressChange};
	__property TWebBrowserCommandStateChange OnCommandStateChange = {read=FOnCommandStateChange, write=FOnCommandStateChange};
	__property Classes::TNotifyEvent OnDownloadBegin = {read=FOnDownloadBegin, write=FOnDownloadBegin};
	__property Classes::TNotifyEvent OnDownloadComplete = {read=FOnDownloadComplete, write=FOnDownloadComplete};
	__property TWebBrowserTitleChange OnTitleChange = {read=FOnTitleChange, write=FOnTitleChange};
	__property TWebBrowserPropertyChange OnPropertyChange = {read=FOnPropertyChange, write=FOnPropertyChange};
	__property TWebBrowserBeforeNavigate2 OnBeforeNavigate2 = {read=FOnBeforeNavigate2, write=FOnBeforeNavigate2};
	__property TWebBrowserNewWindow2 OnNewWindow2 = {read=FOnNewWindow2, write=FOnNewWindow2};
	__property TWebBrowserNavigateComplete2 OnNavigateComplete2 = {read=FOnNavigateComplete2, write=FOnNavigateComplete2};
	__property TWebBrowserDocumentComplete OnDocumentComplete = {read=FOnDocumentComplete, write=FOnDocumentComplete};
	__property Classes::TNotifyEvent OnQuit = {read=FOnQuit, write=FOnQuit};
	__property TWebBrowserOnVisible OnVisible = {read=FOnVisible, write=FOnVisible};
	__property TWebBrowserOnToolBar OnToolBar = {read=FOnToolBar, write=FOnToolBar};
	__property TWebBrowserOnMenuBar OnMenuBar = {read=FOnMenuBar, write=FOnMenuBar};
	__property TWebBrowserOnStatusBar OnStatusBar = {read=FOnStatusBar, write=FOnStatusBar};
	__property TWebBrowserOnFullScreen OnFullScreen = {read=FOnFullScreen, write=FOnFullScreen};
	__property TWebBrowserOnTheaterMode OnTheaterMode = {read=FOnTheaterMode, write=FOnTheaterMode};
public:
	#pragma option push -w-inl
	/* TOleControl.Create */ inline __fastcall virtual TWebBrowser(Classes::TComponent* AOwner) : Olectrls::TOleControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TOleControl.Destroy */ inline __fastcall virtual ~TWebBrowser(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented inline __fastcall TWebBrowser(HWND ParentWindow) : Olectrls::TOleControl(ParentWindow) { } */
	#pragma option pop
	
};


class DELPHICLASS CoInternetExplorer;
class PASCALIMPLEMENTATION CoInternetExplorer : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	/*         class method */ static _di_IWebBrowser2 __fastcall Create(TMetaClass* vmt);
	/*         class method */ static _di_IWebBrowser2 __fastcall CreateRemote(TMetaClass* vmt, const AnsiString MachineName);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall CoInternetExplorer(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~CoInternetExplorer(void) { }
	#pragma option pop
	
};


typedef void __fastcall (__closure *TInternetExplorerStatusTextChange)(System::TObject* Sender, OleVariant &Text);

typedef void __fastcall (__closure *TInternetExplorerProgressChange)(System::TObject* Sender, int Progress, int ProgressMax);

typedef void __fastcall (__closure *TInternetExplorerCommandStateChange)(System::TObject* Sender, int Command, Word Enable);

typedef void __fastcall (__closure *TInternetExplorerTitleChange)(System::TObject* Sender, OleVariant &Text);

typedef void __fastcall (__closure *TInternetExplorerPropertyChange)(System::TObject* Sender, OleVariant &szProperty);

typedef void __fastcall (__closure *TInternetExplorerBeforeNavigate2)(System::TObject* Sender, OleVariant &pDisp, OleVariant &URL, OleVariant &Flags, OleVariant &TargetFrameName, OleVariant &PostData, OleVariant &Headers, OleVariant &Cancel);

typedef void __fastcall (__closure *TInternetExplorerNewWindow2)(System::TObject* Sender, OleVariant &ppDisp, OleVariant &Cancel);

typedef void __fastcall (__closure *TInternetExplorerNavigateComplete2)(System::TObject* Sender, OleVariant &pDisp, OleVariant &URL);

typedef void __fastcall (__closure *TInternetExplorerDocumentComplete)(System::TObject* Sender, OleVariant &pDisp, OleVariant &URL);

typedef void __fastcall (__closure *TInternetExplorerOnVisible)(System::TObject* Sender, Word Visible);

typedef void __fastcall (__closure *TInternetExplorerOnToolBar)(System::TObject* Sender, Word ToolBar);

typedef void __fastcall (__closure *TInternetExplorerOnMenuBar)(System::TObject* Sender, Word MenuBar);

typedef void __fastcall (__closure *TInternetExplorerOnStatusBar)(System::TObject* Sender, Word StatusBar);

typedef void __fastcall (__closure *TInternetExplorerOnFullScreen)(System::TObject* Sender, Word FullScreen);

typedef void __fastcall (__closure *TInternetExplorerOnTheaterMode)(System::TObject* Sender, Word TheaterMode);

class DELPHICLASS TInternetExplorer;
class PASCALIMPLEMENTATION TInternetExplorer : public Oleserver::TOleServer 
{
	typedef Oleserver::TOleServer inherited;
	
private:
	TInternetExplorerStatusTextChange FOnStatusTextChange;
	TInternetExplorerProgressChange FOnProgressChange;
	TInternetExplorerCommandStateChange FOnCommandStateChange;
	Classes::TNotifyEvent FOnDownloadBegin;
	Classes::TNotifyEvent FOnDownloadComplete;
	TInternetExplorerTitleChange FOnTitleChange;
	TInternetExplorerPropertyChange FOnPropertyChange;
	TInternetExplorerBeforeNavigate2 FOnBeforeNavigate2;
	TInternetExplorerNewWindow2 FOnNewWindow2;
	TInternetExplorerNavigateComplete2 FOnNavigateComplete2;
	TInternetExplorerDocumentComplete FOnDocumentComplete;
	Classes::TNotifyEvent FOnQuit;
	TInternetExplorerOnVisible FOnVisible;
	TInternetExplorerOnToolBar FOnToolBar;
	TInternetExplorerOnMenuBar FOnMenuBar;
	TInternetExplorerOnStatusBar FOnStatusBar;
	TInternetExplorerOnFullScreen FOnFullScreen;
	TInternetExplorerOnTheaterMode FOnTheaterMode;
	_di_IWebBrowser2 FIntf;
	_di_IWebBrowser2 __fastcall GetDefaultInterface();
	
protected:
	virtual void __fastcall InitServerData(void);
	virtual void __fastcall InvokeEvent(int DispID, Oleserver::TVariantArray &Params);
	_di_IDispatch __fastcall Get_Application();
	_di_IDispatch __fastcall Get_Parent();
	_di_IDispatch __fastcall Get_Container();
	_di_IDispatch __fastcall Get_Document();
	Word __fastcall Get_TopLevelContainer(void);
	WideString __fastcall Get_Type_();
	int __fastcall Get_Left(void);
	void __fastcall Set_Left(int pl);
	int __fastcall Get_Top(void);
	void __fastcall Set_Top(int pl);
	int __fastcall Get_Width(void);
	void __fastcall Set_Width(int pl);
	int __fastcall Get_Height(void);
	void __fastcall Set_Height(int pl);
	WideString __fastcall Get_LocationName();
	WideString __fastcall Get_LocationURL();
	Word __fastcall Get_Busy(void);
	WideString __fastcall Get_Name();
	int __fastcall Get_HWND(void);
	WideString __fastcall Get_FullName();
	WideString __fastcall Get_Path();
	Word __fastcall Get_Visible(void);
	void __fastcall Set_Visible(Word pBool);
	Word __fastcall Get_StatusBar(void);
	void __fastcall Set_StatusBar(Word pBool);
	WideString __fastcall Get_StatusText();
	void __fastcall Set_StatusText(const WideString StatusText);
	int __fastcall Get_ToolBar(void);
	void __fastcall Set_ToolBar(int Value);
	Word __fastcall Get_MenuBar(void);
	void __fastcall Set_MenuBar(Word Value);
	Word __fastcall Get_FullScreen(void);
	void __fastcall Set_FullScreen(Word pbFullScreen);
	Activex::TOleEnum __fastcall Get_ReadyState(void);
	Word __fastcall Get_Offline(void);
	void __fastcall Set_Offline(Word pbOffline);
	Word __fastcall Get_Silent(void);
	void __fastcall Set_Silent(Word pbSilent);
	Word __fastcall Get_RegisterAsBrowser(void);
	void __fastcall Set_RegisterAsBrowser(Word pbRegister);
	Word __fastcall Get_RegisterAsDropTarget(void);
	void __fastcall Set_RegisterAsDropTarget(Word pbRegister);
	Word __fastcall Get_TheaterMode(void);
	void __fastcall Set_TheaterMode(Word pbRegister);
	Word __fastcall Get_AddressBar(void);
	void __fastcall Set_AddressBar(Word Value);
	Word __fastcall Get_Resizable(void);
	void __fastcall Set_Resizable(Word Value);
	
public:
	__fastcall virtual TInternetExplorer(Classes::TComponent* AOwner);
	__fastcall virtual ~TInternetExplorer(void);
	virtual void __fastcall Connect(void);
	void __fastcall ConnectTo(_di_IWebBrowser2 svrIntf);
	virtual void __fastcall Disconnect(void);
	void __fastcall GoBack(void);
	void __fastcall GoForward(void);
	void __fastcall GoHome(void);
	void __fastcall GoSearch(void);
	void __fastcall Navigate(const WideString URL)/* overload */;
	void __fastcall Navigate(const WideString URL, OleVariant &Flags)/* overload */;
	void __fastcall Navigate(const WideString URL, OleVariant &Flags, OleVariant &TargetFrameName)/* overload */;
	void __fastcall Navigate(const WideString URL, OleVariant &Flags, OleVariant &TargetFrameName, OleVariant &PostData)/* overload */;
	void __fastcall Navigate(const WideString URL, OleVariant &Flags, OleVariant &TargetFrameName, OleVariant &PostData, OleVariant &Headers)/* overload */;
	void __fastcall Refresh(void);
	void __fastcall Refresh2(void)/* overload */;
	void __fastcall Refresh2(OleVariant &Level)/* overload */;
	void __fastcall Stop(void);
	void __fastcall Quit(void);
	void __fastcall ClientToWindow(int &pcx, int &pcy);
	void __fastcall PutProperty(const WideString Property_, const OleVariant &vtValue);
	OleVariant __fastcall GetProperty(const WideString Property_);
	void __fastcall Navigate2(OleVariant &URL)/* overload */;
	void __fastcall Navigate2(OleVariant &URL, OleVariant &Flags)/* overload */;
	void __fastcall Navigate2(OleVariant &URL, OleVariant &Flags, OleVariant &TargetFrameName)/* overload */;
	void __fastcall Navigate2(OleVariant &URL, OleVariant &Flags, OleVariant &TargetFrameName, OleVariant &PostData)/* overload */;
	void __fastcall Navigate2(OleVariant &URL, OleVariant &Flags, OleVariant &TargetFrameName, OleVariant &PostData, OleVariant &Headers)/* overload */;
	Activex::TOleEnum __fastcall QueryStatusWB(Activex::TOleEnum cmdID);
	void __fastcall ExecWB(Activex::TOleEnum cmdID, Activex::TOleEnum cmdexecopt)/* overload */;
	void __fastcall ExecWB(Activex::TOleEnum cmdID, Activex::TOleEnum cmdexecopt, OleVariant &pvaIn)/* overload */;
	void __fastcall ExecWB(Activex::TOleEnum cmdID, Activex::TOleEnum cmdexecopt, OleVariant &pvaIn, OleVariant &pvaOut)/* overload */;
	void __fastcall ShowBrowserBar(OleVariant &pvaClsid)/* overload */;
	void __fastcall ShowBrowserBar(OleVariant &pvaClsid, OleVariant &pvarShow)/* overload */;
	void __fastcall ShowBrowserBar(OleVariant &pvaClsid, OleVariant &pvarShow, OleVariant &pvarSize)/* overload */;
	__property _di_IWebBrowser2 DefaultInterface = {read=GetDefaultInterface};
	__property _di_IDispatch Application = {read=Get_Application};
	__property _di_IDispatch Parent = {read=Get_Parent};
	__property _di_IDispatch Container = {read=Get_Container};
	__property _di_IDispatch Document = {read=Get_Document};
	__property Word TopLevelContainer = {read=Get_TopLevelContainer, nodefault};
	__property WideString Type_ = {read=Get_Type_};
	__property WideString LocationName = {read=Get_LocationName};
	__property WideString LocationURL = {read=Get_LocationURL};
	__property Word Busy = {read=Get_Busy, nodefault};
	__property WideString Name = {read=Get_Name};
	__property int HWND = {read=Get_HWND, nodefault};
	__property WideString FullName = {read=Get_FullName};
	__property WideString Path = {read=Get_Path};
	__property Activex::TOleEnum ReadyState = {read=Get_ReadyState, nodefault};
	__property int Left = {read=Get_Left, write=Set_Left, nodefault};
	__property int Top = {read=Get_Top, write=Set_Top, nodefault};
	__property int Width = {read=Get_Width, write=Set_Width, nodefault};
	__property int Height = {read=Get_Height, write=Set_Height, nodefault};
	__property Word Visible = {read=Get_Visible, write=Set_Visible, nodefault};
	__property Word StatusBar = {read=Get_StatusBar, write=Set_StatusBar, nodefault};
	__property WideString StatusText = {read=Get_StatusText, write=Set_StatusText};
	__property int ToolBar = {read=Get_ToolBar, write=Set_ToolBar, nodefault};
	__property Word MenuBar = {read=Get_MenuBar, write=Set_MenuBar, nodefault};
	__property Word FullScreen = {read=Get_FullScreen, write=Set_FullScreen, nodefault};
	__property Word Offline = {read=Get_Offline, write=Set_Offline, nodefault};
	__property Word Silent = {read=Get_Silent, write=Set_Silent, nodefault};
	__property Word RegisterAsBrowser = {read=Get_RegisterAsBrowser, write=Set_RegisterAsBrowser, nodefault};
	__property Word RegisterAsDropTarget = {read=Get_RegisterAsDropTarget, write=Set_RegisterAsDropTarget, nodefault};
	__property Word TheaterMode = {read=Get_TheaterMode, write=Set_TheaterMode, nodefault};
	__property Word AddressBar = {read=Get_AddressBar, write=Set_AddressBar, nodefault};
	__property Word Resizable = {read=Get_Resizable, write=Set_Resizable, nodefault};
	
__published:
	__property TInternetExplorerStatusTextChange OnStatusTextChange = {read=FOnStatusTextChange, write=FOnStatusTextChange};
	__property TInternetExplorerProgressChange OnProgressChange = {read=FOnProgressChange, write=FOnProgressChange};
	__property TInternetExplorerCommandStateChange OnCommandStateChange = {read=FOnCommandStateChange, write=FOnCommandStateChange};
	__property Classes::TNotifyEvent OnDownloadBegin = {read=FOnDownloadBegin, write=FOnDownloadBegin};
	__property Classes::TNotifyEvent OnDownloadComplete = {read=FOnDownloadComplete, write=FOnDownloadComplete};
	__property TInternetExplorerTitleChange OnTitleChange = {read=FOnTitleChange, write=FOnTitleChange};
	__property TInternetExplorerPropertyChange OnPropertyChange = {read=FOnPropertyChange, write=FOnPropertyChange};
	__property TInternetExplorerBeforeNavigate2 OnBeforeNavigate2 = {read=FOnBeforeNavigate2, write=FOnBeforeNavigate2};
	__property TInternetExplorerNewWindow2 OnNewWindow2 = {read=FOnNewWindow2, write=FOnNewWindow2};
	__property TInternetExplorerNavigateComplete2 OnNavigateComplete2 = {read=FOnNavigateComplete2, write=FOnNavigateComplete2};
	__property TInternetExplorerDocumentComplete OnDocumentComplete = {read=FOnDocumentComplete, write=FOnDocumentComplete};
	__property Classes::TNotifyEvent OnQuit = {read=FOnQuit, write=FOnQuit};
	__property TInternetExplorerOnVisible OnVisible = {read=FOnVisible, write=FOnVisible};
	__property TInternetExplorerOnToolBar OnToolBar = {read=FOnToolBar, write=FOnToolBar};
	__property TInternetExplorerOnMenuBar OnMenuBar = {read=FOnMenuBar, write=FOnMenuBar};
	__property TInternetExplorerOnStatusBar OnStatusBar = {read=FOnStatusBar, write=FOnStatusBar};
	__property TInternetExplorerOnFullScreen OnFullScreen = {read=FOnFullScreen, write=FOnFullScreen};
	__property TInternetExplorerOnTheaterMode OnTheaterMode = {read=FOnTheaterMode, write=FOnTheaterMode};
};


class DELPHICLASS CoShellBrowserWindow;
class PASCALIMPLEMENTATION CoShellBrowserWindow : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	/*         class method */ static _di_IWebBrowser2 __fastcall Create(TMetaClass* vmt);
	/*         class method */ static _di_IWebBrowser2 __fastcall CreateRemote(TMetaClass* vmt, const AnsiString MachineName);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall CoShellBrowserWindow(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~CoShellBrowserWindow(void) { }
	#pragma option pop
	
};


class DELPHICLASS CoShellWindows;
class PASCALIMPLEMENTATION CoShellWindows : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	/*         class method */ static _di_IShellWindows __fastcall Create(TMetaClass* vmt);
	/*         class method */ static _di_IShellWindows __fastcall CreateRemote(TMetaClass* vmt, const AnsiString MachineName);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall CoShellWindows(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~CoShellWindows(void) { }
	#pragma option pop
	
};


typedef void __fastcall (__closure *TShellWindowsWindowRegistered)(System::TObject* Sender, int lCookie);

typedef void __fastcall (__closure *TShellWindowsWindowRevoked)(System::TObject* Sender, int lCookie);

class DELPHICLASS TShellWindows;
class PASCALIMPLEMENTATION TShellWindows : public Oleserver::TOleServer 
{
	typedef Oleserver::TOleServer inherited;
	
private:
	TShellWindowsWindowRegistered FOnWindowRegistered;
	TShellWindowsWindowRevoked FOnWindowRevoked;
	_di_IShellWindows FIntf;
	_di_IShellWindows __fastcall GetDefaultInterface();
	
protected:
	virtual void __fastcall InitServerData(void);
	virtual void __fastcall InvokeEvent(int DispID, Oleserver::TVariantArray &Params);
	int __fastcall Get_Count(void);
	
public:
	__fastcall virtual TShellWindows(Classes::TComponent* AOwner);
	__fastcall virtual ~TShellWindows(void);
	virtual void __fastcall Connect(void);
	void __fastcall ConnectTo(_di_IShellWindows svrIntf);
	virtual void __fastcall Disconnect(void);
	_di_IDispatch __fastcall Item()/* overload */;
	_di_IDispatch __fastcall Item(const OleVariant &index)/* overload */;
	System::_di_IInterface __fastcall _NewEnum();
	void __fastcall Register(const _di_IDispatch pid, int HWND, int swClass, /* out */ int &plCookie);
	void __fastcall RegisterPending(int lThreadId, OleVariant &pvarloc, OleVariant &pvarlocRoot, int swClass, /* out */ int &plCookie);
	void __fastcall Revoke(int lCookie);
	void __fastcall OnNavigate(int lCookie, OleVariant &pvarloc);
	void __fastcall OnActivated(int lCookie, Word fActive);
	_di_IDispatch __fastcall FindWindow(OleVariant &pvarloc, OleVariant &pvarlocRoot, int swClass, /* out */ int &pHWND, int swfwOptions);
	void __fastcall OnCreated(int lCookie, const System::_di_IInterface punk);
	void __fastcall ProcessAttachDetach(Word fAttach);
	__property _di_IShellWindows DefaultInterface = {read=GetDefaultInterface};
	__property int Count = {read=Get_Count, nodefault};
	
__published:
	__property TShellWindowsWindowRegistered OnWindowRegistered = {read=FOnWindowRegistered, write=FOnWindowRegistered};
	__property TShellWindowsWindowRevoked OnWindowRevoked = {read=FOnWindowRevoked, write=FOnWindowRevoked};
};


class DELPHICLASS CoShellUIHelper;
class PASCALIMPLEMENTATION CoShellUIHelper : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	/*         class method */ static _di_IShellUIHelper __fastcall Create(TMetaClass* vmt);
	/*         class method */ static _di_IShellUIHelper __fastcall CreateRemote(TMetaClass* vmt, const AnsiString MachineName);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall CoShellUIHelper(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~CoShellUIHelper(void) { }
	#pragma option pop
	
};


class DELPHICLASS TShellUIHelper;
class PASCALIMPLEMENTATION TShellUIHelper : public Oleserver::TOleServer 
{
	typedef Oleserver::TOleServer inherited;
	
private:
	_di_IShellUIHelper FIntf;
	_di_IShellUIHelper __fastcall GetDefaultInterface();
	
protected:
	virtual void __fastcall InitServerData(void);
	
public:
	__fastcall virtual TShellUIHelper(Classes::TComponent* AOwner);
	__fastcall virtual ~TShellUIHelper(void);
	virtual void __fastcall Connect(void);
	void __fastcall ConnectTo(_di_IShellUIHelper svrIntf);
	virtual void __fastcall Disconnect(void);
	void __fastcall ResetFirstBootMode(void);
	void __fastcall ResetSafeMode(void);
	void __fastcall RefreshOfflineDesktop(void);
	void __fastcall AddFavorite(const WideString URL)/* overload */;
	void __fastcall AddFavorite(const WideString URL, OleVariant &Title)/* overload */;
	void __fastcall AddChannel(const WideString URL);
	void __fastcall AddDesktopComponent(const WideString URL, const WideString Type_)/* overload */;
	void __fastcall AddDesktopComponent(const WideString URL, const WideString Type_, OleVariant &Left)/* overload */;
	void __fastcall AddDesktopComponent(const WideString URL, const WideString Type_, OleVariant &Left, OleVariant &Top)/* overload */;
	void __fastcall AddDesktopComponent(const WideString URL, const WideString Type_, OleVariant &Left, OleVariant &Top, OleVariant &Width)/* overload */;
	void __fastcall AddDesktopComponent(const WideString URL, const WideString Type_, OleVariant &Left, OleVariant &Top, OleVariant &Width, OleVariant &Height)/* overload */;
	Word __fastcall IsSubscribed(const WideString URL);
	void __fastcall NavigateAndFind(const WideString URL, const WideString strQuery, OleVariant &varTargetFrame);
	void __fastcall ImportExportFavorites(Word fImport, const WideString strImpExpPath);
	void __fastcall AutoCompleteSaveForm(void)/* overload */;
	void __fastcall AutoCompleteSaveForm(OleVariant &Form)/* overload */;
	void __fastcall AutoScan(const WideString strSearch, const WideString strFailureUrl)/* overload */;
	void __fastcall AutoScan(const WideString strSearch, const WideString strFailureUrl, OleVariant &pvarTargetFrame)/* overload */;
	void __fastcall AutoCompleteAttach(void)/* overload */;
	void __fastcall AutoCompleteAttach(OleVariant &Reserved)/* overload */;
	OleVariant __fastcall ShowBrowserUI(const WideString bstrName, OleVariant &pvarIn);
	__property _di_IShellUIHelper DefaultInterface = {read=GetDefaultInterface};
};


class DELPHICLASS CoShellFavoritesNameSpace;
class PASCALIMPLEMENTATION CoShellFavoritesNameSpace : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	/*         class method */ static _di_IShellFavoritesNameSpace __fastcall Create(TMetaClass* vmt);
	/*         class method */ static _di_IShellFavoritesNameSpace __fastcall CreateRemote(TMetaClass* vmt, const AnsiString MachineName);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall CoShellFavoritesNameSpace(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~CoShellFavoritesNameSpace(void) { }
	#pragma option pop
	
};


typedef void __fastcall (__closure *TShellFavoritesNameSpaceFavoritesSelectionChange)(System::TObject* Sender, int cItems, int hItem, OleVariant &strName, OleVariant &strUrl, int cVisits, OleVariant &strDate, int fAvailableOffline);

class DELPHICLASS TShellFavoritesNameSpace;
class PASCALIMPLEMENTATION TShellFavoritesNameSpace : public Oleserver::TOleServer 
{
	typedef Oleserver::TOleServer inherited;
	
private:
	TShellFavoritesNameSpaceFavoritesSelectionChange FOnFavoritesSelectionChange;
	_di_IShellFavoritesNameSpace FIntf;
	_di_IShellFavoritesNameSpace __fastcall GetDefaultInterface();
	
protected:
	virtual void __fastcall InitServerData(void);
	virtual void __fastcall InvokeEvent(int DispID, Oleserver::TVariantArray &Params);
	Word __fastcall Get_FOfflinePackInstalled(void);
	
public:
	__fastcall virtual TShellFavoritesNameSpace(Classes::TComponent* AOwner);
	__fastcall virtual ~TShellFavoritesNameSpace(void);
	virtual void __fastcall Connect(void);
	void __fastcall ConnectTo(_di_IShellFavoritesNameSpace svrIntf);
	virtual void __fastcall Disconnect(void);
	void __fastcall MoveSelectionUp(void);
	void __fastcall MoveSelectionDown(void);
	void __fastcall ResetSort(void);
	void __fastcall NewFolder(void);
	void __fastcall Synchronize(void);
	void __fastcall Import(void);
	void __fastcall Export(void);
	void __fastcall InvokeContextMenuCommand(const WideString strCommand);
	void __fastcall MoveSelectionTo(void);
	Word __fastcall CreateSubscriptionForSelection(void);
	Word __fastcall DeleteSubscriptionForSelection(void);
	void __fastcall SetRoot(const WideString bstrFullPath);
	__property _di_IShellFavoritesNameSpace DefaultInterface = {read=GetDefaultInterface};
	__property Word FOfflinePackInstalled = {read=Get_FOfflinePackInstalled, nodefault};
	
__published:
	__property TShellFavoritesNameSpaceFavoritesSelectionChange OnFavoritesSelectionChange = {read=FOnFavoritesSelectionChange, write=FOnFavoritesSelectionChange};
};


class DELPHICLASS CoCScriptErrorList;
class PASCALIMPLEMENTATION CoCScriptErrorList : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	/*         class method */ static _di_IScriptErrorList __fastcall Create(TMetaClass* vmt);
	/*         class method */ static _di_IScriptErrorList __fastcall CreateRemote(TMetaClass* vmt, const AnsiString MachineName);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall CoCScriptErrorList(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~CoCScriptErrorList(void) { }
	#pragma option pop
	
};


class DELPHICLASS CoSearchAssistantOC;
class PASCALIMPLEMENTATION CoSearchAssistantOC : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	/*         class method */ static _di_ISearchAssistantOC __fastcall Create(TMetaClass* vmt);
	/*         class method */ static _di_ISearchAssistantOC __fastcall CreateRemote(TMetaClass* vmt, const AnsiString MachineName);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall CoSearchAssistantOC(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~CoSearchAssistantOC(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
static const Shortint SHDocVwMajorVersion = 0x1;
static const Shortint SHDocVwMinorVersion = 0x1;
extern PACKAGE GUID LIBID_SHDocVw;
extern PACKAGE GUID IID_IWebBrowser;
extern PACKAGE GUID DIID_DWebBrowserEvents;
extern PACKAGE GUID IID_IWebBrowserApp;
extern PACKAGE GUID IID_IWebBrowser2;
extern PACKAGE GUID DIID_DWebBrowserEvents2;
extern PACKAGE GUID CLASS_WebBrowser_V1;
extern PACKAGE GUID CLASS_WebBrowser;
extern PACKAGE GUID CLASS_InternetExplorer;
extern PACKAGE GUID CLASS_ShellBrowserWindow;
extern PACKAGE GUID DIID_DShellWindowsEvents;
extern PACKAGE GUID IID_IShellWindows;
extern PACKAGE GUID CLASS_ShellWindows;
extern PACKAGE GUID IID_IShellUIHelper;
extern PACKAGE GUID CLASS_ShellUIHelper;
extern PACKAGE GUID DIID__ShellFavoritesNameSpaceEvents;
extern PACKAGE GUID IID_IShellFavoritesNameSpace;
extern PACKAGE GUID CLASS_ShellFavoritesNameSpace;
extern PACKAGE GUID IID_IScriptErrorList;
extern PACKAGE GUID CLASS_CScriptErrorList;
extern PACKAGE GUID IID_ISearch;
extern PACKAGE GUID IID_ISearches;
extern PACKAGE GUID IID_ISearchAssistantOC;
extern PACKAGE GUID DIID__SearchAssistantEvents;
extern PACKAGE GUID CLASS_SearchAssistantOC;
static const unsigned CSC_UPDATECOMMANDS = 0xffffffff;
static const Shortint CSC_NAVIGATEFORWARD = 0x1;
static const Shortint CSC_NAVIGATEBACK = 0x2;
static const Shortint OLECMDID_OPEN = 0x1;
static const Shortint OLECMDID_NEW = 0x2;
static const Shortint OLECMDID_SAVE = 0x3;
static const Shortint OLECMDID_SAVEAS = 0x4;
static const Shortint OLECMDID_SAVECOPYAS = 0x5;
static const Shortint OLECMDID_PRINT = 0x6;
static const Shortint OLECMDID_PRINTPREVIEW = 0x7;
static const Shortint OLECMDID_PAGESETUP = 0x8;
static const Shortint OLECMDID_SPELL = 0x9;
static const Shortint OLECMDID_PROPERTIES = 0xa;
static const Shortint OLECMDID_CUT = 0xb;
static const Shortint OLECMDID_COPY = 0xc;
static const Shortint OLECMDID_PASTE = 0xd;
static const Shortint OLECMDID_PASTESPECIAL = 0xe;
static const Shortint OLECMDID_UNDO = 0xf;
static const Shortint OLECMDID_REDO = 0x10;
static const Shortint OLECMDID_SELECTALL = 0x11;
static const Shortint OLECMDID_CLEARSELECTION = 0x12;
static const Shortint OLECMDID_ZOOM = 0x13;
static const Shortint OLECMDID_GETZOOMRANGE = 0x14;
static const Shortint OLECMDID_UPDATECOMMANDS = 0x15;
static const Shortint OLECMDID_REFRESH = 0x16;
static const Shortint OLECMDID_STOP = 0x17;
static const Shortint OLECMDID_HIDETOOLBARS = 0x18;
static const Shortint OLECMDID_SETPROGRESSMAX = 0x19;
static const Shortint OLECMDID_SETPROGRESSPOS = 0x1a;
static const Shortint OLECMDID_SETPROGRESSTEXT = 0x1b;
static const Shortint OLECMDID_SETTITLE = 0x1c;
static const Shortint OLECMDID_SETDOWNLOADSTATE = 0x1d;
static const Shortint OLECMDID_STOPDOWNLOAD = 0x1e;
static const Shortint OLECMDID_ONTOOLBARACTIVATED = 0x1f;
static const Shortint OLECMDID_FIND = 0x20;
static const Shortint OLECMDID_DELETE = 0x21;
static const Shortint OLECMDID_HTTPEQUIV = 0x22;
static const Shortint OLECMDID_HTTPEQUIV_DONE = 0x23;
static const Shortint OLECMDID_ENABLE_INTERACTION = 0x24;
static const Shortint OLECMDID_ONUNLOAD = 0x25;
static const Shortint OLECMDID_PROPERTYBAG2 = 0x26;
static const Shortint OLECMDID_PREREFRESH = 0x27;
static const Shortint OLECMDID_SHOWSCRIPTERROR = 0x28;
static const Shortint OLECMDID_SHOWMESSAGE = 0x29;
static const Shortint OLECMDID_SHOWFIND = 0x2a;
static const Shortint OLECMDID_SHOWPAGESETUP = 0x2b;
static const Shortint OLECMDID_SHOWPRINT = 0x2c;
static const Shortint OLECMDID_CLOSE = 0x2d;
static const Shortint OLECMDID_ALLOWUILESSSAVEAS = 0x2e;
static const Shortint OLECMDID_DONTDOWNLOADCSS = 0x2f;
static const Shortint OLECMDF_SUPPORTED = 0x1;
static const Shortint OLECMDF_ENABLED = 0x2;
static const Shortint OLECMDF_LATCHED = 0x4;
static const Shortint OLECMDF_NINCHED = 0x8;
static const Shortint OLECMDF_INVISIBLE = 0x10;
static const Shortint OLECMDF_DEFHIDEONCTXTMENU = 0x20;
static const Shortint OLECMDEXECOPT_DODEFAULT = 0x0;
static const Shortint OLECMDEXECOPT_PROMPTUSER = 0x1;
static const Shortint OLECMDEXECOPT_DONTPROMPTUSER = 0x2;
static const Shortint OLECMDEXECOPT_SHOWHELP = 0x3;
static const Shortint READYSTATE_UNINITIALIZED = 0x0;
static const Shortint READYSTATE_LOADING = 0x1;
static const Shortint READYSTATE_LOADED = 0x2;
static const Shortint READYSTATE_INTERACTIVE = 0x3;
static const Shortint READYSTATE_COMPLETE = 0x4;
static const Shortint SWC_EXPLORER = 0x0;
static const Shortint SWC_BROWSER = 0x1;
static const Shortint SWC_3RDPARTY = 0x2;
static const Shortint SWC_CALLBACK = 0x4;
static const Shortint SWFO_NEEDDISPATCH = 0x1;
static const Shortint SWFO_INCLUDEPENDING = 0x2;
static const Shortint SWFO_COOKIEPASSED = 0x4;
static const Shortint REFRESH_NORMAL = 0x0;
static const Shortint REFRESH_IFEXPIRED = 0x1;
static const Shortint REFRESH_CONTINUE = 0x2;
static const Shortint REFRESH_COMPLETELY = 0x3;
static const Shortint navOpenInNewWindow = 0x1;
static const Shortint navNoHistory = 0x2;
static const Shortint navNoReadFromCache = 0x4;
static const Shortint navNoWriteToCache = 0x8;
static const Shortint navAllowAutosearch = 0x10;
static const Shortint navBrowserBar = 0x20;

}	/* namespace Shdocvw */
using namespace Shdocvw;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SHDocVw
