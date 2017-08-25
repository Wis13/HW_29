@ECHO OFF

:: ==================================================================================================================
SET GITHUB=Wis13
SET WS_DIR=workspace
SET REPO=HW_27
SET VERSION=1.0
SET MAIN_CLASS=core.Input_Scanner
:: ==================================================================================================================
    
IF "%JAVA_HOME%" == "" GOTO EXIT_JAVA
IF "%M2%" == "" GOTO EXIT_MVN 
CALL git --version > null 2>&1
IF NOT %ERRORLEVEL% == 0 GOTO EXIT_GIT
GOTO NEXT

:NEXT
IF NOT EXIST C:\%WS_DIR% GOTO NO_WORKSPACE
IF NOT EXIST C:\%WS_DIR%\%REPO% GOTO NEXT1
IF EXIST C:\%WS_DIR%\%REPO% RMDIR /s /q C:\%WS_DIR%\%REPO%
GOTO NEXT1

:NEXT1
CD /
CD %WS_DIR%
git clone https://github.com/%GITHUB%/%REPO%.git
CD C:\%WS_DIR%\%REPO%                                   

CALL mvn package                                
ECHO.
ECHO Executing Java program ...............................................
java -cp C:\%WS_DIR%\%REPO%\target\%REPO%-%VERSION%-jar-with-dependencies.jar %MAIN_CLASS%
GOTO END

:EXIT_JAVA
ECHO No Java installed
GOTO END

:EXIT_MVN
ECHO No Maven installed
GOTO END
                                             `
:EXIT_GIT
ECHO No Git installed
GOTO END

:NO_WORKSPACE
ECHO %WS_DIR% is not exist
GOTO END

:END
CD\




