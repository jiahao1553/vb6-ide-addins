@echo off
cd/d %~dp0

copy /y VB6IDEMouseWheelAddin.dll %windir%
if not "%errorlevel%"=="0" goto err

regsvr32 /s VB6IDEMouseWheelAddin.dll
if not "%errorlevel%"=="0" goto err

regedit /s "MouseWheel Fix.reg"
if not "%errorlevel%"=="0" goto err

exit /b
