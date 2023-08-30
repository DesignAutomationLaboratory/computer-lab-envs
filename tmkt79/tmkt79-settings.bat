@echo off
setlocal
set PROMPT_PREFIX=[91m~[93m~[92m~[0m
set ARCHIVE_URL=https://github.com/ovidner/computer-lab-settings/archive/refs/heads/main.zip
set ARCHIVE_PATH=%TEMP%\computer-lab-settings.zip
set EXTRACT_PATH=%LOCALAPPDATA%\computer-lab-settings

echo [101;93m=== TMKT79 settings helper ===[0m

echo %PROMPT_PREFIX% Downloading and extracting up-to-date settings...
powershell -Command "Invoke-WebRequest %ARCHIVE_URL% -OutFile %ARCHIVE_PATH%" || goto :error
powershell -Command "Expand-Archive -Path %ARCHIVE_PATH% -DestinationPath %EXTRACT_PATH%" || goto :error

echo %PROMPT_PREFIX% Setting up environment...
powershell -ExecutionPolicy Bypass -Command "%EXTRACT_PATH%\computer-lab-settings-main\tmkt79\init.ps1" || goto :error

pause
goto :EOF

:error
echo Oh noes! Something went wrong. Please contact the course staff.
pause
