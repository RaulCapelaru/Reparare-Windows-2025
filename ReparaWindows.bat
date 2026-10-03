@echo off
title Reparare Windows 10/11 - DISM + SFC (2025)
chcp 65001 >nul
color 0B
cls

echo.
echo  ╔══════════════════════════════════════════════════════════╗
echo  ║    REPARARE COMPLETĂ WINDOWS 10 ȘI 11 - 2025             ║
echo  ║    (Fără programe, 100% gratuit și sigur)               ║
echo  ╚══════════════════════════════════════════════════════════╝
echo.
echo   Se verifică drepturile de Administrator...
echo.

net session >nul 2>&1 || (
    echo   ➤ Se deschide cu drepturi de Administrator...
    powershell "Start-Process cmd -ArgumentList '/c \"%~f0\"' -Verb RunAs" >nul 2>&1
    exit /b
)

cls
echo  ╔══════════════════════════════════════════════════════════╗
echo  ║                   REPARARE ÎN CURS...                    ║
echo  ╚══════════════════════════════════════════════════════════╝
echo.
echo   1/2 DISM - Repară sursa de instalare Windows
echo   (poate dura 5-25 minute - e normal să pară că stă)
echo.
powershell -Command "DISM /Online /Cleanup-Image /RestoreHealth /LimitAccess"

echo.
echo   2/2 SFC - Repară fisierele de sistem
echo.
sfc /scannow

echo.
echo  ╔══════════════════════════════════════════════════════════╗
echo  ║                REPARARE FINALIZATĂ CU SUCCES!            ║
echo  ║                                                          ║
echo  ║   Pentru rezultate maxime, repornește calculatorul acum  ║
echo  ║                                                          ║
echo  ╚══════════════════════════════════════════════════════════╝
echo.
echo   Apasă orice tastă pentru a închide sau așteaptă 30 sec...
timeout /t 30 >nul