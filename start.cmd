@echo off
setlocal
cd /d "%~dp0"
if exist "%~dp0.tools\node.exe" (
  set "PATH=%~dp0.tools;%PATH%"
  "%~dp0.tools\node.exe" "%~dp0node_modules\vite\bin\vite.js" --host 127.0.0.1
) else (
  call npm run dev -- --host 127.0.0.1
)
pause
