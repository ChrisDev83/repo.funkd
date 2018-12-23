@echo on

certutil -hashfile addons.xml MD5  | find /i /v "md5" | find /i /v "certutil" > addons.xml.md5

@echo off
setlocal EnableDelayedExpansion

set numOfFields=70

set record=
set fields=1
(for /F "delims=" %%a in (addons.xml.md5) do (
   set "record=!record!%%a"
   rem Count the fields in this line
   set "line=%%a"
   call :StrLen line allChars=
   set "noCommas=!line:,=!"
   call :StrLen noCommas withoutCommas=
   set /A fields+=allChars-withoutCommas
   if !fields! geq %numOfFields% (
      echo !record!
      set record=
      set fields=1
   )
)) > addons.xml.md52
goto :EOF


:StrLen var len=
set "str=0!%1!"
set len=0
for /L %%A in (12,-1,0) do (
   set /A "len|=1<<%%A"
   for %%B in (!len!) do if "!str:~%%B,1!" == "" set /A "len&=~1<<%%A"
)
set %2=%len%
exit /B