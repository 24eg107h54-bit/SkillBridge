@echo off
echo ========================================================
echo   Launching SkillBridge Full-Stack Application
echo ========================================================
start "SkillBridge Backend (Spring Boot)" cmd /k "%~dp0start-backend.bat"
timeout /t 3 /nobreak >nul
start "SkillBridge Frontend (Vite React)" cmd /k "%~dp0start-frontend.bat"
echo.
echo Both servers are launching:
echo   - Backend:  http://localhost:8080/api
echo   - H2 DB:    http://localhost:8080/h2-console
echo   - Frontend: http://localhost:5173
echo.
pause
