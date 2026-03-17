@echo off
setlocal

:: 1. Verifica se os argumentos foram passados
if "%~1"=="" goto usage
if "%~2"=="" goto usage

set VERSION=%~1
set MESSAGE=%~2

echo 🚀 Iniciando release da versao %VERSION%...

:: 2. Executa os comandos de Git
git add .
git commit -m "%MESSAGE%"

:: Verifica se o commit funcionou (ErrorCode 0)
if %ERRORLEVEL% EQU 0 (
    git tag %VERSION%
    git push origin main
    git push origin %VERSION%
    echo ✅ Versao %VERSION% lancada e sincronizada com sucesso!
) else (
  echo ⚠️ Nenhuma alteracao para commitar ou erro no Git.
)

goto :eof

:usage
echo ❌ Erro: Faltam argumentos.
echo Uso correto: release.bat v1.0.0 "Minha mensagem de commit"
pause
