//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USEFORMNS("bsPngImageEditor.pas", Bspngimageeditor, bsPNGEditorForm);
USEFORMNS("bsRootEdit.pas", Bsrootedit, bsRootPathEditDlg);
USEFORMNS("NBPagesEditor.pas", Nbpageseditor, NBPagesForm);
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------


#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
	return 1;
}
//---------------------------------------------------------------------------
