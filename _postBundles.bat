@echo off
setlocal enabledelayedexpansion

:: ============================================================
:: post_fhir_bundles.bat
:: Posts all JSON bundle files in a directory to a FHIR server
:: Usage: post_fhir_bundles.bat <directory> <fhir_server_url>
:: Example: post_fhir_bundles.bat C:\bundles http://localhost:8080/fhir
:: ============================================================

:: --- Argument validation ---

set "BUNDLE_DIR=C:\Users\Bryn\Documents\Src\CQF\ecqm-content-qicore-2024\bundles\bundles"
set "FHIR_URL=https://cloud.alphora.com/sandbox/r4/cqm/fhir/"

:: Strip trailing slash from URL if present
if "%FHIR_URL:~-1%"=="/" set "FHIR_URL=%FHIR_URL:~0,-1%"

:: --- Validate directory ---
if not exist "%BUNDLE_DIR%" (
    echo [ERROR] Directory not found: %BUNDLE_DIR%
    exit /b 1
)

:: --- Counters ---
set /a TOTAL=0
set /a SUCCESS=0
set /a FAILED=0

echo.
echo ============================================================
echo  FHIR Bundle Poster
echo ============================================================
echo  Directory : %BUNDLE_DIR%
echo  Server    : %FHIR_URL%
echo ============================================================
echo.

:: --- Loop over all JSON files in the directory ---
for %%F in ("%BUNDLE_DIR%\*.json") do (
    set /a TOTAL+=1
    set "FILE=%%F"
    set "FILENAME=%%~nxF"

    echo [%%~nxF] Posting...

    :: POST the bundle; capture HTTP status code
    for /f %%R in ('curl -s -o NUL -w "%%{http_code}" ^
        -X POST ^
        -H "Content-Type: application/fhir+json" ^
        -H "Accept: application/fhir+json" ^
        --data-binary "@%%F" ^
        "%FHIR_URL%"') do set "HTTP_STATUS=%%R"

    if "!HTTP_STATUS!"=="200" (
        echo [%%~nxF] SUCCESS ^(HTTP !HTTP_STATUS!^)
        set /a SUCCESS+=1
    ) else if "!HTTP_STATUS!"=="201" (
        echo [%%~nxF] SUCCESS ^(HTTP !HTTP_STATUS!^)
        set /a SUCCESS+=1
    ) else (
        echo [%%~nxF] FAILED ^(HTTP !HTTP_STATUS!^)
        set /a FAILED+=1
    )
    echo.
)

:: --- Summary ---
echo ============================================================
echo  Done. Total: %TOTAL%  Success: %SUCCESS%  Failed: %FAILED%
echo ============================================================

if %FAILED% GTR 0 exit /b 1
exit /b 0