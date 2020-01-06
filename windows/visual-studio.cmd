@ECHO OFF

rem Generate Visual Studio projects for libCEC

SETLOCAL

SET MYDIR=%~dp0
SET BUILDTYPE=Release
SET VSVERSION=16
SET INSTALLPATH=%MYDIR%..\build

IF NOT EXIST "%MYDIR%..\support\windows\cmake\build.cmd" (
  ECHO "support git submodule was not checked out"
  GOTO exit
)

IF NOT EXIST "%MYDIR%..\src\platform\windows\build.cmd" (
  ECHO "platform git submodule was not checked out"
  GOTO exit
)

del /s /f /q "%MYDIR%..\build"

FOR %%T IN (x64) DO (
  CALL "%MYDIR%build-lib.cmd" %%T %BUILDTYPE% %VSVERSION% "%INSTALLPATH%" vs
  ECHO Visual Studio solutions can be found in:
  ECHO %%T bits: "%MYDIR%..\build\cmake\%%T\libcec.sln"
  ECHO This project only compile in %BUILDTYPE% mode
)

:exit
