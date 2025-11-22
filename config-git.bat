@echo off
chcp 65001 >nul

git config --global core.quotepath false 2>nul
git config --global gui.encoding utf-8 2>nul
git config --global i18n.commitencoding utf-8 2>nul
git config --global i18n.logoutputencoding utf-8 2>nul

exit /b 0
