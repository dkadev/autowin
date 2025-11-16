cscript /nologo %windir%\system32\slmgr.vbs /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX

MKDIR "C:\Files\"
COPY "BIN\gatherosstate.exe" "C:\Files\"
COPY "BIN\slc.dll" "C:\Files\"

call "C:\Files\gatherosstate.exe"

COPY "C:\Files\GenuineTicket.xml" "C:\ProgramData\Microsoft\Windows\ClipSVC\GenuineTicket\"
RMDIR "C:\Files\" /s /q

net stop ClipSVC
net start ClipSVC

cscript /nologo %windir%\system32\slmgr.vbs /xpr