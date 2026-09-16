@echo off
setlocal
cd /d "%~dp0"
if exist "%~dp0.tools\node.exe" (
  set "PATH=%~dp0.tools;%PATH%"
  goto local
)
where npx >nul 2>nul
if errorlevel 1 (
  echo Node.js is required. Install Node.js LTS, then run this file again.
  pause
  exit /b 1
)
call npx --yes vercel@latest login
if errorlevel 1 goto failed
call npx --yes vercel@latest --prod
if errorlevel 1 goto failed
goto done
:local
"%~dp0.tools\node.exe" "%~dp0.tools\package\bin\npm-cli.js" exec --yes --offline=false --cache "%~dp0.tools\npm-cache" --package=vercel@latest -- vercel login
if errorlevel 1 goto failed
"%~dp0.tools\node.exe" "%~dp0.tools\package\bin\npm-cli.js" exec --yes --offline=false --cache "%~dp0.tools\npm-cache" --package=vercel@latest -- vercel --prod
if errorlevel 1 goto failed
:done
echo Deployment complete. Open the Production URL printed above.
pause
exit /b 0
:failed
echo Deployment did not finish. Check the error above.
pause
exit /b 1
