@echo off
chcp 65001 >nul
title ThePaperPlane Manager

:menu
cls
echo ===============================================
echo         ThePaperPlane Project Manager
echo ===============================================
echo.

REM Проверка статуса
docker ps --format "table {{.Names}}\t{{.Status}}" 2>nul | findstr "paperplane" >nul
if %errorlevel%==0 (
    echo Status: 🟢 Running
) else (
    echo Status: 🔴 Stopped
)
echo.

echo   [1] Start project
echo   [2] Stop project
echo   [3] Restart project
echo   [4] View logs (live)
echo   [5] Open frontend in browser
echo   [6] Open API docs in browser
echo   [7] Rebuild project
echo   [8] Show container status
echo.
echo   [0] Exit
echo.
set /p choice="Choose option: "

if "%choice%"=="1" call :action_start
if "%choice%"=="2" call :action_stop
if "%choice%"=="3" call :action_restart
if "%choice%"=="4" call :action_logs
if "%choice%"=="5" call :action_frontend
if "%choice%"=="6" call :action_docs
if "%choice%"=="7" call :action_rebuild
if "%choice%"=="8" call :action_status
if "%choice%"=="0" goto :exit
goto :menu

:action_start
echo.
echo Starting project...
docker-compose up -d
echo.
echo ✅ Project started!
echo    Frontend: http://localhost:5173
echo    Backend:  http://localhost:8000
echo    API Docs: http://localhost:8000/docs
echo.
pause
goto :menu

:action_stop
echo.
echo Stopping project...
docker-compose down
echo.
echo ✅ Project stopped!
echo.
pause
goto :menu

:action_restart
echo.
echo Restarting project...
docker-compose restart
echo.
echo ✅ Project restarted!
echo.
pause
goto :menu

:action_logs
echo.
echo 📋 Showing live logs (press Ctrl+C to stop viewing)...
echo.
docker-compose logs -f --tail=50
goto :menu

:action_frontend
echo.
echo Opening frontend...
start http://localhost:5173
goto :menu

:action_docs
echo.
echo Opening API documentation...
start http://localhost:8000/docs
goto :menu

:action_rebuild
echo.
echo ⚠️  This will rebuild all containers. Continue? (Y/N)
set /p confirm="Choice: "
if /i not "%confirm%"=="Y" goto :menu
echo.
echo Rebuilding project...
docker-compose down
docker-compose up -d --build
echo.
echo ✅ Project rebuilt and started!
echo.
pause
goto :menu

:action_status
echo.
echo 📊 Container status:
echo.
docker ps --filter "name=paperplane"
echo.
pause
goto :menu

:exit
cls
echo ===============================================
echo   Goodbye! 👋
echo ===============================================
echo.
timeout /t 2 >nul
exit