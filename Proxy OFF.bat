@echo off
REM #####################
REM ### Proxy Switch  ###
REM #####################
REM ### by ZubirJamal ###
REM #####################
REM ### Description: 
REM ### If you find it frustrating to enable/disable proxy everytime when switching connection from Office to Home,
REM ### Run this batch file to switch on/off proxy automatically. Tested on Windows 7 to Windows 10.

for /f "skip=2 tokens=3 delims= " %%R in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable') do (
 set "reg_value=%%R"
)
REM #Remove REM below for debugging
REM echo [Debug]
REM echo REG status: %reg_value%
REM echo file: %~dpnx0
REM echo.
if "%reg_value%" EQU "0x0" goto proxyON
if "%reg_value%" EQU "0x1" goto proxyOFF
goto end

:proxyOFF
echo Proxy Status: ON
echo Switching OFF proxy . . .
echo.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
set filename="Proxy OFF.bat"
REM echo Terminating Proxifier . . .
echo. 
REM @taskkill /f /im proxifier.exe
echo. 
goto end

:proxyON
echo Proxy Status: OFF
echo Switching ON proxy . . .
echo.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
set filename="Proxy ON.bat"
echo. 
REM @start "" "C:\Program Files (x86)\Proxifier\Proxifier.exe"
goto end

:end
REM #Remove REM below for debugging.
REM echo [Debug] Launching inetcpl.cpl for proxy confirmation ...
REM rundll32.exe inetcpl.cpl,LaunchConnectionDialog
REM #You may remove pause for immediate switching.
@pause 
ren "%~dpnx0" %filename%