@echo off
:: ============ SAFE MANUAL ADAM CLEANUP ============
:: Run from an elevated Command Prompt or PowerShell as Administrator
:: DO NOT run this on a machine running Exchange Server 2016/2019!
::===============

setlocal EnableDelayedExpansion

echo [INFO] Starting safe ADAM cleanup...
echo.

:: 1) Remove optional client packages from WinSxS (safe — not core)
if exist "C:\Windows\WinSxS\amd64_microsoft-windows-directoryservices-adam-client-package*" (
    for %%F in ("C:\Windows\WinSxS\amd64_microsoft-windows-directoryservices-adam-client-package*") do (
        del /q /f "%%F" && echo [OK] Deleted: %%~nxF
    )
)

if exist "C:\Windows\WinSxS\amd64_microsoft-windows-directoryservices-adam-core-client-opt-package*" (
    for %%F in ("C:\Windows\WinSxS\amd64_microsoft-windows-directoryservices-adam-core-client-opt-package*") do (
        del /q /f "%%F" && echo [OK] Deleted: %%~nxF
    )
)

if exist "C:\Windows\WinSxS\amd64_microsoft-windows-directoryservices-adam-snapins-group-package*" (
    for %%F in ("C:\Windows\WinSxS\amd64_microsoft-windows-directoryservices-adam-snapins-group-package*") do (
        del /q /f "%%F" && echo [OK] Deleted: %%~nxF
    )
)

if exist "C:\Windows\WinSxS\amd64_microsoft-windows-directoryservices-adam-tools-opt-merged-package*" (
    for %%F in ("C:\Windows\WinSxS\amd64_microsoft-windows-directoryservices-adam-tools-opt-merged-package*") do (
        del /q /f "%%F" && echo [OK] Deleted: %%~nxF
    )
)

:: 2) Remove optional tools package
if exist "C:\Windows\WinSxS\amd64_microsoft-windows-directoryservices-adam-tools-opt-package*" (
    for %%F in ("C:\Windows\WinSxS\amd64_microsoft-windows-directoryservices-adam-tools-opt-package*") do (
        del /q /f "%%F" && echo [OK] Deleted: %%~nFX
    )
)

:: 3) Remove migwiz migration manifests (safe — only used during Windows migration)
if exist "C:\Windows\System32\migwiz\dlmanifests\DirectoryServices-ADAM-DL.man" del /q "C:\Windows\System32\migwiz\dlmanifests\DirectoryServices-ADAM-DL.man" && echo [OK] Deleted: DirectoryServices-ADAM-DL.man
if exist "C:\Windows\System32\migwiz\dlmanifests\Microsoft-Windows-DirectoryServices-ADAM-DL" del /q "C:\Windows\System32\migwiz\dlmanifests\Microsoft-Windows-DirectoryServices-ADAM-DL" && echo [OK] Deleted: Microsoft-Windows-DirectoryServices-ADAM-DL
if exist "C:\Windows\System32\migwiz\replacementmanifests\DirectoryServices-ADAM-Client-Replacement.man" del /q "C:\Windows\System32\migwiz\replacementmanifests\DirectoryServices-ADAM-Client-Replacement.man" && echo [OK] Deleted: DirectoryServices-ADAM-Client-Replacement.man
if exist "C:\Windows\System32\migwiz\replacementmanifests\DirectoryServices-ADAM-Tools-Replacement.man" del /q "C:\Windows\System32\migwiz\replacementmanifests\DirectoryServices-ADAM-Tools-Replacement.man" && echo [OK] Deleted: DirectoryServices-ADAM-Tools-Replacement.man
if exist "C:\Windows\System32\migwiz\replacementmanifests\Microsoft-Windows-DirectoryServices-ADAM-Client" del /q "C:\Windows\System32\migwiz\replacementmanifests\Microsoft-Windows-DirectoryServices-ADAM-Client" && echo [OK] Deleted: Microsoft-Windows-DirectoryServices-ADAM-Client

:: 4) Remove optional .mui resource files (reduces UI languages but harmless)
if exist "C:\Windows\WinSxS\amd64_microsoft-windows-directoryservices-adam-core.resources_31bf3856ad364e35_10.0.19041.6033_en-us_f691b3a4355251d6" (
    for %%F in ("C:\Windows\WinSxS\amd64_microsoft-windows-directoryservices-adam-core.resources_31bf3856ad364e35_10.0.19041.6033_en-us_f691b3a4355251d6") do (
        rmdir /s /q "%%F" && echo [OK] Deleted: %%~nxF
    )
)

:: 5) Remove servicing package manifests (safe — these are just metadata for optional packages)
if exist "C:\Windows\servicing\Packages\Microsoft-Windows-DirectoryServices-ADAM-Client-Admin-Package*" (
    for %%F in ("C:\Windows\servicing\Packages\Microsoft-Windows-DirectoryServices-ADAM-Client-Admin-Package*") do (
        del /q /f "%%F" && echo [OK] Deleted: %%~nxF
    )
)

if exist "C:\Windows\servicing\Packages\Microsoft-Windows-DirectoryServices-ADAM-Client-OptGroup-Package*" (
    for %%F in ("C:\Windows\servicing\Packages\Microsoft-Windows-DirectoryServices-ADAM-Client-OptGroup-Package*") do (
        del /q /f "%%F" && echo [OK] Deleted: %%~nxF
    )
)

if exist "C:\Windows\servicing\Packages\Microsoft-Windows-DirectoryServices-ADAM-Client-Package*" (
    for %%F in ("C:\Windows\servicing\Packages\Microsoft-Windows-DirectoryServices-ADAM-Client-Package*") do (
        del /q /f "%%F" && echo [OK] Deleted: %%~nxF
    )
)

if exist "C:\Windows\servicing\Packages\Microsoft-Windows-DirectoryServices-ADAM-Snapins-Admin-Package*" (
    for %%F in ("C:\Windows\servicing\Packages\Microsoft-Windows-DirectoryServices-ADAM-Snapins-Admin-Package*") do (
        del /q /f "%%F" && echo [OK] Deleted: %%~nxF
    )
)

echo.
echo [INFO] Cleanup complete.
echo.
echo [NOTE] Core AD LDS engine files in WinSxS remain — they are used by Windows Update and server roles.

pause