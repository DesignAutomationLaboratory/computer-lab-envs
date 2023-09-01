@echo off
REM This script will download and extract the latest version of the
REM TMKT79 environment helper. DON'T EDIT THIS FILE (unless there's some
REM error in the bootstrapping process). Make changes to the PowerShell
REM script and push to the repository instead. In that way, changes can
REM be tracked and made during the courses without needing to instruct
REM students to download a new version of this file.

setlocal
set PROMPT_PREFIX=[91m~[93m~[92m~[0m
set ARCHIVE_URL=https://github.com/ovidner/computer-lab-envs/archive/refs/heads/main.zip
set ARCHIVE_PATH=%TEMP%\computer-lab-envs.zip
REM When extracting, a subfolder will be created
set EXTRACT_PATH=%LOCALAPPDATA%
set INIT_SCRIPT_PATH=%EXTRACT_PATH%\computer-lab-envs-main\tmkt79\init.ps1

echo [101;93m=== TMKT79 environment helper ===[0m

echo %PROMPT_PREFIX% Downloading and extracting up-to-date resources...
powershell -ExecutionPolicy Bypass -Command "Invoke-WebRequest %ARCHIVE_URL% -OutFile %ARCHIVE_PATH%" || goto :error
powershell -ExecutionPolicy Bypass -Command "Expand-Archive -Path %ARCHIVE_PATH% -DestinationPath %EXTRACT_PATH%" -Force || goto :error

echo %PROMPT_PREFIX% Setting up environment...
powershell -ExecutionPolicy Bypass -Command "%INIT_SCRIPT_PATH%"

echo %PROMPT_PREFIX% Done!
pause
goto :EOF

:error
echo Oh noes! Something went wrong. Please contact the course staff.
pause
