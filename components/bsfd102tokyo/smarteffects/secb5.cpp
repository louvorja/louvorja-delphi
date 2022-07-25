//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("secb5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("dsnide50.bpi");
USEUNIT("se_winapi.pas");
USEUNIT("se_ani.pas");
USEUNIT("se_anidesignerform.pas");
USEUNIT("se_anilistdesigner.pas");
USEUNIT("se_bitmap.pas");
USEUNIT("se_effect.pas");
USEUNIT("se_form.pas");
USEUNIT("se_freeze.pas");
USEUNIT("se_grab.pas");
USEUNIT("se_grabclass.pas");
USEUNIT("se_image.pas");
USEUNIT("se_imagelist.pas");
USEUNIT("se_reg.pas");
USERES("se_reg.dcr");
USEUNIT("se_utils.pas");
USEUNIT("se_controls.pas");
USEUNIT("se_pngimagelist.pas");
USEFORMNS("se_NBPagesEditor.pas", Se_nbpageseditor, seNBPagesForm);
USEUNIT("se_pngimage.pas");
USEFORMNS("se_PngImageEditor.pas", Se_pngimageeditor, sePNGEditorForm);
USEUNIT("se_zlib.pas");
USEPACKAGE("vcljpg50.bpi");
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
