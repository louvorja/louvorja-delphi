//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USEFORMNS("se_NBPagesEditor.pas", Se_nbpageseditor, seNBPagesForm);
USEFORMNS("se_PngImageEditor.pas", Se_pngimageeditor, sePNGEditorForm);
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
 