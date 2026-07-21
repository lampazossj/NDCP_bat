@echo off
color F0
title Nvidia Display Container

net session >nul 2>&1
if not "%ERRORLEVEL%"=="0" (
    echo. & echo.
    echo    ######## ERROR: ADMINISTRATOR PRIVILEGES REQUIRED ##########
    echo     This script must be run as administrator to work properly!  
    echo    ############################################################
    echo. & pause & exit
)

:main
cls
echo.
echo.
set /P k="   Do you want to have the Nvidia Display Container? [Y/N]: "
if not '%k%'=='' set k=%k:~0,1%
if '%k%'=='Y' goto enable_ndcp
if '%k%'=='y' goto enable_ndcp
if '%k%'=='N' goto disable_ndcp
if '%k%'=='n' goto disable_ndcp
goto incorrectV

:enable_ndcp
sc config NVDisplay.ContainerLocalSystem start=auto
sc start NVDisplay.ContainerLocalSystem
set "state=ENABLED" & goto end

:disable_ndcp
sc config NVDisplay.ContainerLocalSystem start=disabled
sc stop NVDisplay.ContainerLocalSystem
set "state=DISABLED" & goto end

:end
echo.
echo.
echo.
echo      Ndc is %state%!
echo    ####################
echo    #     FINISHED     #
echo    #                  #
echo    # No reboot needed #
echo    ####################
echo.
pause&exit

:incorrectV
cls
echo.
echo.
echo    Please enter a valid choice [Y/N]
echo.
timeout /t 3 /nobreak >nul
goto main
