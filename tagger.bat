@echo off
if "%~1" == "" (
    echo ❌ Erro: Informe a versao. Ex: tagger.bat v1.0.0
    pause
    exit /b
)
git tag %~1
git push origin %~1
echo ✅ Tag %~1 enviada com sucesso!
