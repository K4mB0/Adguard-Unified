@echo off
cd /d "%~dp0"
git add .
git commit -m "Automated update to AdGuard ruleset"
git push origin main
echo Ruleset successfully updated on GitHub!
pause