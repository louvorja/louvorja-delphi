How to add skin support for QuantumGrid and other DevExpress controls (v.11-13):

1. Install SkinAdapter VCL.
2. Enable {$DEFINE DEVEX_SUPPORT} directive in bsaadapter.pas.
3. Add bsaDevExSkin.pas to the BusinessSkinForm VCL package and recompile it.
4. Set LookAndFeel.Skin property to "BSFSkin" in DevExpress controls.
5. Set LookAndFeel.NativeStyle properties to False in DevExpress controls.
6. Put TbsaSkinAdapter component on the form and set SkinData property. 


If you need to add skin support for filter dialogs of QuantiumGrid then
 replace original files to files from SkinFilterDialogs.zip.







