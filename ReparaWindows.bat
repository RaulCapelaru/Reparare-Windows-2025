@echo off
setlocal EnableExtensions EnableDelayedExpansion
title Reparare Windows 10/11 - DISM + SFC (2025)

rem -- Ridicare automată la drepturi de Administrator --
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo   Se deschide cu drepturi de Administrator...
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs" >nul 2>&1
    exit /b
)

chcp 65001 >nul
color 0B
cls

echo.
echo  ╔══════════════════════════════════════════════════════════╗
echo  ║    REPARARE COMPLETĂ WINDOWS 10 ȘI 11 - 2025             ║
echo  ║    (Fără programe, 100%% gratuit și sigur)               ║
echo  ╚══════════════════════════════════════════════════════════╝
echo.

rem -- Log: totul se salvează într-un fișier pentru diagnosticare --
set "LOGFILE=%TEMP%\ReparareWindows_%DATE:~-4%%DATE:~4,2%%DATE:~7,2%_%TIME:~0,2%%TIME:~3,2%.log"
set "LOGFILE=!LOGFILE: =0!"
echo   Logul complet al reparației va fi salvat în:
echo   !LOGFILE!
echo.

rem -- Verificare Internet (necesară pentru DISM /RestoreHealth) --
echo   Se verifică conexiunea la Internet...
powershell -NoProfile -Command "exit (-not (Test-Connection -ComputerName 'google.com' -Count 1 -Quiet))" >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo   ATENTIE: NU exista conexiune la Internet!
    echo      DISM are nevoie de Internet pentru a descărca fișierele corecte.
    echo      Conectează-te la rețea și rulează din nou acest script.
    echo.
    pause
    exit /b 1
)
echo   Conexiune OK.
echo.

echo  ╔══════════════════════════════════════════════════════════╗
echo  ║                   REPARARE ÎN CURS...                    ║
echo  ╚══════════════════════════════════════════════════════════╝
echo.
echo   1/2 DISM - Repara sursa de instalare Windows
echo   (poate dura 5-25 minute - e normal sa para ca sta)
echo.
DISM /Online /Cleanup-Image /RestoreHealth >> "!LOGFILE!" 2>&1
set "DISM_RC=%errorlevel%"

echo.
echo   2/2 SFC - Repara fisierele de sistem
echo   (poate dura 5-15 minute)
echo.
sfc /scannow >> "!LOGFILE!" 2>&1
set "SFC_RC=%errorlevel%"

echo.
if "%DISM_RC%"=="0" if "%SFC_RC%"=="0" (
    color 0A
    echo  ╔══════════════════════════════════════════════════════════╗
    echo  ║                REPARARE FINALIZATĂ CU SUCCES!            ║
    echo  ║                                                          ║
    echo  ║   Pentru rezultate maxime, repornește calculatorul acum  ║
    echo  ╚══════════════════════════════════════════════════════════╝
) else (
    color 0E
    echo  ╔══════════════════════════════════════════════════════════╗
    echo  ║        ATENTIE - Unele probleme NU au putut fi reparate  ║
    echo  ║                                                          ║
    echo  ║   Cod DISM: %DISM_RC%       Cod SFC: %SFC_RC%             ║
    echo  ║                                                          ║
    echo  ║   Rulează din nou sau consultă logul deschis mai jos:    ║
    echo  ╚══════════════════════════════════════════════════════════╝
    start "" notepad "!LOGFILE!"
)
echo.
echo   Apasă orice tastă pentru a închide sau așteaptă 30 sec...
timeout /t 30 >nul
endlocal
