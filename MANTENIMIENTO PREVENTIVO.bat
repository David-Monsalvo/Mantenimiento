@echo off
::::::::::::::::::::::::::::::::::::::::::::::
REM inicio de solucitud de permisos administraodor
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
REM fin de solucitud de permisos administraodor
::::::::::::::::::::::::::::::::::::::::::::::


:: establezco ruta de trabajo a directorio desde donde ejecuto el .bat
cd /d %~dp0

:: importo archivo de registro
REGEDIT /S 128.reg
echo ejecutando limpieza de disco... por favor espere...
cleanmgr /SAGERUN:128

echo.
echo accede a la carpeta TEMP del usuer-windows y borra archivos existentes en ella.
cd /d %temp%
rmdir /q /s .
echo.
cd /d %windir%\Temp
rmdir /q /s .

cls
echo Se realizo la limpieza de manera correcta!.
pause
exit

