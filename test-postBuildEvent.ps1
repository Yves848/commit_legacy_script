# ri c:\git\commit_legacy\bin -Recurse -Force

# .\post-build.ps1 -target cp_rss_modules -rep_dest C:\Git\commit_legacy\Bin\Modules\Import\ -type_mod Import -module NEV
 #$(ANT_HOME)\bin\ant -f "$(OUTPUTDIR)..\..\..\commit.build" cp_rss_modules -Dtype_mod=Import -Dmodule=$(OUTPUTNAME) -Drep_dest=$(OUTPUTDIR)

.\post-build.ps1 -target cp_rss_modules -rep_dest C:\Git\commit_legacy\Bin\Modules\Import\ -type_mod Import -module NEV