@echo off
setlocal EnableDelayedExpansion

:: Windows Activation Script
:: This script automates the manual Windows activation process
echo ============================================
echo Windows Activation Script
echo ============================================
echo.

:: Check if running as Administrator
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo ERROR: This script must be run as Administrator!
    echo Please right-click and select "Run as administrator"
    pause
    exit /b 1
)

:: Variables
set "TICKET_SOURCE=%~dp0GenuineTicket.xml"
set "TICKET_DEST=C:\ProgramData\Microsoft\Windows\ClipSVC\GenuineTicket"
set "PRODUCT_KEY=VK7JG-NPHTM-C97JM-9MPGT-3V66T"

:: Check if GenuineTicket.xml exists in script directory
if not exist "%TICKET_SOURCE%" (
    echo ERROR: GenuineTicket.xml not found in script directory!
    echo Expected location: %TICKET_SOURCE%
    pause
    exit /b 1
)

echo Step 1: Copy of GenuineTicket.xml
echo --------------------------------------------

:: Create destination directory if it doesn't exist
if not exist "%TICKET_DEST%" (
    echo Creating directory: %TICKET_DEST%
    mkdir "%TICKET_DEST%" 2>nul
    if !errorLevel! NEQ 0 (
        echo ERROR: Failed to create directory %TICKET_DEST%
        pause
        exit /b 1
    )
)

:: Copy GenuineTicket.xml to destination
copy "%TICKET_SOURCE%" "%TICKET_DEST%\GenuineTicket.xml" >nul
if %errorLevel% NEQ 0 (
    echo ERROR: Failed to copy GenuineTicket.xml to %TICKET_DEST%
    pause
    exit /b 1
)

:: Verify the file was copied and restart ClipSVC
if exist "%TICKET_DEST%\GenuineTicket.xml" (
    echo [OK] GenuineTicket.xml copied successfully
    echo Restarting ClipSVC service...
    net stop ClipSVC /y >nul 2>&1
    timeout /t 2 /nobreak >nul
    net start ClipSVC >nul 2>&1
    timeout /t 3 /nobreak >nul
    echo [OK] ClipSVC service restarted
) else (
    echo ERROR: GenuineTicket.xml verification failed!
    pause
    exit /b 1
)

echo.
echo Step 2: Product Key installation
echo --------------------------------------------

:: Check initial internet connection
echo Checking internet connectivity...
ping google.com -n 1 -w 1000 >nul 2>&1
if %errorLevel% EQU 0 (
    set "INTERNET_CONNECTED=1"
    echo [OK] Internet connection detected
) else (
    set "INTERNET_CONNECTED=0"
    echo [!] No internet connection detected
)

if !INTERNET_CONNECTED! EQU 0 (
    echo WARNING: No internet connection detected!
    echo Some activation steps may fail without internet connectivity.
    echo.
)

:: Attempt to install product key
echo Installing product key...
cscript /nologo %windir%\system32\slmgr.vbs /ipk "%PRODUCT_KEY%" >nul 2>&1
set "KEY_INSTALL_RESULT=%errorLevel%"
echo Product key installation result: !KEY_INSTALL_RESULT!

:: Check if we got the common error 0x803fa067
if !KEY_INSTALL_RESULT! NEQ 0 (
    echo.
    echo Product key installation failed. Trying alternative method...
    
    :: Disconnect from internet (disable network adapters)
    echo Temporarily disabling network connections...
    for /f "tokens=1" %%i in ('wmic path win32_networkadapter where "NetEnabled=true" get DeviceID /value ^| find "DeviceID"') do (
        for /f "tokens=2 delims==" %%j in ("%%i") do (
            wmic path win32_networkadapter where "DeviceID=%%j" call disable >nul 2>&1
        )
    )
    
    :: Wait a moment
    timeout /t 3 /nobreak >nul
    
    :: Try installing product key again without internet
    echo Attempting product key installation without internet...
    cscript /nologo %windir%\system32\slmgr.vbs /ipk "%PRODUCT_KEY%" >nul 2>&1
    set "KEY_INSTALL_RESULT_OFFLINE=%errorLevel%"
    
    :: Re-enable network connections
    echo Re-enabling network connections...
    for /f "tokens=1" %%i in ('wmic path win32_networkadapter where "NetEnabled=false" get DeviceID /value ^| find "DeviceID"') do (
        for /f "tokens=2 delims==" %%j in ("%%i") do (
            wmic path win32_networkadapter where "DeviceID=%%j" call enable >nul 2>&1
        )
    )
    
    :: Wait for network to come back up
    echo Waiting for network connectivity to restore...
    timeout /t 10 /nobreak >nul
    
    if !KEY_INSTALL_RESULT_OFFLINE! NEQ 0 (
        echo ERROR: Product key installation failed even without internet connection.
        echo Please check your product key and try manually.
        pause
        exit /b 1
    )
)

echo [OK] Product key installed successfully

:: Wait a moment before activation attempt
timeout /t 3 /nobreak >nul

echo.
echo Step 3: Activation attempt
echo --------------------------------------------
echo Running activation...
cscript /nologo %windir%\system32\slmgr.vbs /ato >nul 2>&1
set "ACTIVATION_RESULT=%errorLevel%"
echo Activation result: !ACTIVATION_RESULT!

if !ACTIVATION_RETRY_RESULT! EQU 0 (
        echo.
        echo [SUCCESS] Windows has been activated!
    ) else (
        echo.
        echo [WARNING] Activation failed. Manual intervention may be required.
    )

echo.
echo Step 4: Activation status check
echo --------------------------------------------
echo Checking activation status...
echo.
cscript /nologo %windir%\system32\slmgr.vbs /xpr

echo.
pause