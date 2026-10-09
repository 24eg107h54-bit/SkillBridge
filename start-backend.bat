@echo off
echo ========================================================
echo   Starting SkillBridge Spring Boot Backend (Port 8080)
echo ========================================================
cd /d "%~dp0backend"
mvn spring-boot:run
pause
