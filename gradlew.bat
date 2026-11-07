@echo off
setlocal
set "APP_HOME=%~dp0"
set "GRADLE_VERSION=9.3.1"
if defined GRADLE_USER_HOME (set "CACHE=%GRADLE_USER_HOME%") else (set "CACHE=%USERPROFILE%\.gradle")
set "GRADLE_HOME_DIR=%CACHE%\quitnow-gradle\gradle-%GRADLE_VERSION%"
set "GRADLE_BIN=%GRADLE_HOME_DIR%\bin\gradle.bat"
if not exist "%GRADLE_BIN%" (
  if not exist "%CACHE%\quitnow-gradle" mkdir "%CACHE%\quitnow-gradle"
  set "ZIP=%CACHE%\quitnow-gradle\gradle-%GRADLE_VERSION%-bin.zip"
  echo Downloading Gradle %GRADLE_VERSION%...
  powershell -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; Invoke-WebRequest 'https://services.gradle.org/distributions/gradle-%GRADLE_VERSION%-bin.zip' -OutFile '%CACHE%\quitnow-gradle\gradle-%GRADLE_VERSION%-bin.zip'; Expand-Archive -Force '%CACHE%\quitnow-gradle\gradle-%GRADLE_VERSION%-bin.zip' '%CACHE%\quitnow-gradle'"
  if errorlevel 1 exit /b 1
)
call "%GRADLE_BIN%" -p "%APP_HOME%" %*
exit /b %ERRORLEVEL%
