@echo off
::
:: TrueCrypt mounting and dismounting script.
::
set VERSION=2.7
::
:: @author Philipp Meisberger <team@pm-codeworks.de>
:: @depends TrueCrypt, Zenity
:: @licence BSD
::
:: Usage: tcscript.bat [Action] [Option]
:: Action: /mount | /dismount | /auto | /version
:: Option (optional): /debug | /silent
::
:: Action
:: /mount            Mounts a decrypted TrueCrypt volume.
:: /dismount         Dismounts a Truecrypt volume.
:: /auto             Either mounts a Truecrypt volume if it is dismounted or dismounts a TrueCrypt volume if it is mounted.
:: /status           Prints status of mount device.
:: /version          Prints version and exits.
::
:: Option
:: /debug            Prints debug messages.
:: /silent           Suppress errors if keyfile was not found.
:: /interactive      Uses Zenity to show GTK+ messages instead of console output.
::

title TCScript

:: Path to TrueCrypt installation directory
cd C:\Program Files\TrueCrypt\

:: Include user configuration
call tcscript.conf.cmd

:: Init variables
set INTERACTIVE=1
set SILENT=1

:: Main start
:: Parse options
if "%2"=="/debug" (
    @echo on
) else (
    :: Check for interactive mode
    if "%2"=="/interactive" (
        set INTERACTIVE=0
    ) else (
        if "%3"=="/interactive" (
            set INTERACTIVE=0
        )
    )
    :: Check for silent mode
    if "%2"=="/silent" (
        set SILENT=0
    ) else (
        if "%3"=="/silent" (
            set SILENT=0
        )
    )
)

:: Parse action
if "%1"=="/dismount" (
    goto :DISMOUNT
) else (
    if "%1"=="/mount" (
        goto :MOUNT
    ) else (
        if "%1"=="/auto" (
            if exist "%MOUNTPATH%" (
                goto :DISMOUNT
            ) else (
                goto :MOUNT
            )
        ) else (
            if "%1"=="/status" (
                if exist "%MOUNTPATH%" (
                    call :INFO "TCScript has mounted device!"
                    exit /b 0
                ) else (
                    call :ERROR "TCScript has not mounted device!"
                    exit /b 1
                )
            ) else (
                if "%1"=="/version" (
                    echo "TCScript Version %VERSION%"
                    exit /b 0
                ) else (
                    if "%1"=="/help" (
                        echo.
                        echo TrueCrypt console mounting and dismounting script.
                        echo.
                        echo Usage: %0 [Action] [Option]
                        echo Action: /mount ^| /dismount ^| /auto ^| /version
                        echo optional Option: /debug ^| /silent
                        echo.
                        echo Action
                        echo /mount            Mounts a decrypted TrueCrypt volume.
                        echo /dismount         Dismounts a Truecrypt volume.
                        echo /auto             Either mounts a Truecrypt volume if it is dismounted or dismounts a TrueCrypt volume if it is mounted.
                        echo /status           Prints status of mount device.
                        echo /version          Prints version and exits.
                        echo.
                        echo Option
                        echo /debug            Print debug messages. NOTE: If set, other options will be ignored.
                        echo /silent           Suppress errors if keyfile or token device was not found.
                        echo /interactive      Uses Zenity to show messages instead of console output.
                        echo.
                        exit /b 0
                    ) else (
                        echo Invalid argument "%1"!
                        exit /b 1
                    )
                )
            )
        )
    )
)

::
:: Shows GTK error message or console text output.
::
:: @param string
::             Text of message that will be displayed.
:: @return void
::
:ERROR
    if %INTERACTIVE%==0 (
        zenity --error --title="TCScript" --text="%~1"
    ) else (
        echo [Error] %~1
    )
    goto :EOF

::
:: Shows GTK information message or console text output.
::
:: @param string
::             Text of message that will be displayed.
:: @return void
::
:INFO
    if %INTERACTIVE%==0 (
        zenity --info --title="TCScript" --text="%~1"
    ) else (
        echo [Info] %~1
    )
    goto :EOF

::
:: Mounts a decrypted TrueCrypt volume.
::
:: @return integer
::             Returns 0 if no errors occurred.
::
:MOUNT
    if not exist "%KEYFILE%" (
        if %SILENT%==1 (
            call :ERROR "Keyfile not found!"
        )
        exit /b 1
    )

    :: Device exists?
    if exist "%MOUNTPATH%" (
        call :ERROR "Device already mounted!"
        exit /b 1
    )

    timeout /T 1  > nul
    TrueCrypt.exe /q /v "%MOUNTDEVICE%" /l "%MOUNTPATH:~0,1%"  /p "" /k "%KEYFILE%"

    if %ERRORLEVEL%==1 (
        call :ERROR "Error while mounting!"
        exit /b 1
    ) else (
        call :INFO "Successfully mounted!"
        exit /b 0
    )

::
:: Dismounts a TrueCrypt volume.
::
:: @return integer
::             Returns 0 if no errors occurred.
::
:DISMOUNT
    :: Device does not exist?
    if not exist "%MOUNTPATH%" (
        call :ERROR "Device not mounted!"
        exit /b 0
    )

    timeout /T 1  > nul
    TrueCrypt.exe /q /d "%MOUNTPATH:~0,1%"

    if %ERRORLEVEL%==1 (
        call :ERROR "Error while dismounting!"
        exit /b 1
    ) else (
        call :INFO "Successfully dismounted!"
        exit /b 0
    )
