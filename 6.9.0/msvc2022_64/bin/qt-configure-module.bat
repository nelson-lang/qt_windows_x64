@echo off
setlocal ENABLEDELAYEDEXPANSION ENABLEEXTENSIONS
set ARGS=%*
set script_dir_path=%~dp0
set script_dir_path=%script_dir_path:~0,-1%

if "%1" == "" (
    call :print_usage
    exit /b 1
)

set module_root=%1
set module_root=%module_root:\=/%
shift
if not exist "%module_root%\CMakeLists.txt" (
    echo Error: %module_root% is not a valid Qt module source directory. >&2
    call :print_usage
    exit /b 1
)

set cmake_scripts_dir=%script_dir_path%\..\lib\cmake\Qt6
set TOPQTDIR=%CD%

call :doargs %ARGS%
if errorlevel 1 exit /b
goto doneargs

:doargs
    if "%~1" == "" exit /b

    if /i "%~1" == "-redo" goto redo
    if /i "%~1" == "--redo" goto redo

:nextarg
    shift
    goto doargs

:redo
    if not exist "%TOPQTDIR%\config.opt" goto redoerr
    echo %ARGS% > %TOPQTDIR%\config.redo.in
    set redoing=""
    goto nextarg
:redoerr
    echo No config.opt present - cannot redo configuration. >&2
    exit /b 1

:doneargs

rem Write config.opt if we're not currently -redo'ing
set OPT_FILE_PATH=%TOPQTDIR%\config.opt
set OPT_TMP_FILE_PATH=%TOPQTDIR%\config.opt.in
set REDO_FILE_PATH=%TOPQTDIR%\config.redo.last
set REDO_TMP_FILE_PATH=%TOPQTDIR%\config.redo.in
set FRESH_REQUESTED_ARG=
if not defined redoing (
    rem "The '.' in 'echo.%*' ensures we don't print "echo is off" when no arguments are passed"
    rem "https://devblogs.microsoft.com/oldnewthing/20170802-00/?p=96735"
    rem "The space before the '>' makes sure that when we have a digit at the end of the args, we"
    rem "don't accidentally concatenate it with the '>' resulting in '0>' or '2>' which redirects"
    rem "into the file from a stream different than stdout, leading to broken or empty content."
    echo.%* >"%OPT_TMP_FILE_PATH%"

    rem "The SKIP_ARGS option makes sure not to write the repo path into the config.opt file"
    call "%script_dir_path%\qt-cmake-private.bat" -DSKIP_ARGS=1 -DIN_FILE="%OPT_TMP_FILE_PATH%" ^
        -DOUT_FILE="%OPT_FILE_PATH%" -P "%cmake_scripts_dir%\QtWriteArgsFile.cmake"
) else (
    echo. 2> "%OPT_TMP_FILE_PATH%"
    for /F "usebackq tokens=*" %%A in ("%OPT_FILE_PATH%") do echo "%%A" >> "%OPT_TMP_FILE_PATH%"

    rem "The SKIP_REDO_FILE_ARGS option makes sure to remove the repo path read from the"
    rem "config.redo.in file"
    call "%script_dir_path%\qt-cmake-private.bat" -DSKIP_REDO_FILE_ARGS=1 ^
        -DIN_FILE="%OPT_TMP_FILE_PATH%" -DREDO_FILE="%REDO_TMP_FILE_PATH%" ^
        -DOUT_FILE="%REDO_FILE_PATH%" -DIGNORE_ARGS="-redo;--redo" ^
        -P "%cmake_scripts_dir%\QtWriteArgsFile.cmake"

    set OPT_FILE_PATH=%REDO_FILE_PATH%
    set FRESH_REQUESTED_ARG=-DFRESH_REQUESTED=TRUE
)

rem Launch CMake-based configure

call "%script_dir_path%\qt-cmake-private.bat" -DOPTFILE="%OPT_FILE_PATH%" %FRESH_REQUESTED_ARG% ^
    -DMODULE_ROOT="%module_root%" ^
    -DCMAKE_COMMAND="%script_dir_path%\qt-cmake-private.bat" ^
    -P "%cmake_scripts_dir%\QtProcessConfigureArgs.cmake"
goto :eof

:print_usage
echo Usage: qt-configure-module ^<module-source-dir^> [options]
echo.
echo To display the available options for a Qt module, run
echo qt-configure-module ^<module-source-dir^> -help
goto :eof
