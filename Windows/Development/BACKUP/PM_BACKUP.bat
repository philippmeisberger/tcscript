@echo off
::
:: TrueCrypt volume mounting and dismounting script (Windows Version).
:: 
:: @author Philipp Meisberger <team@pm-codeworks.de>
set VERSION=2.4
:: @depends TrueCrypt
::
:: Usage: PM.bat [Action] [Option]
:: Action: /mount | /dismount | /auto | /version
:: Option (optional): /debug | /silent
:: 
:: Action
:: /mount              Mounts a decrypted TrueCrypt volume. 
:: /dismount           Dismounts a Truecrypt volume. 
:: /auto               Either mounts a Truecrypt volume if it is dismounted or dismounts a TrueCrypt volume if it is mounted.
:: /version            Prints version and exits.
::
:: Option
:: /debug              Print debug messages. 
:: /silent             Suppress errors if keyfile or token device was not found.
::

title PM

:: Path to TrueCrypt
set TRUECRYPTPATH="C:\Program Files\TrueCrypt\TrueCrypt.exe"

:: Partition to mount (TrueCrypt path)
set MOUNTDEVICE=\Device\Harddisk0\Partition4

:: Path to directory where volume shall be mounted
set MOUNTPATH=E:\

:: Path to keyfile used for TrueCrypt volume decryption
set KEYFILE=X:\Key

if "%2"=="/debug" ( 
    @echo on
)

if "%1"=="/dismount" (
    goto :DISMOUNT
) else (
    if "%1"=="/mount" (
        goto :MOUNT
    ) else (
        if "%1"=="/auto" (
            if exist %MOUNTPATH% (
                goto :DISMOUNT
            ) else (
                goto :MOUNT
            )
        ) else (
            if "%1"=="/version" (
                echo %0 %VERSION%
                exit /b
            ) else (
				if "%1" NEQ "/help" (
					echo Invalid argument!
				)
                echo.
                echo TrueCrypt mounting and dismounting script.
                echo.    
                echo Usage: %0 [Action] [Option]
                echo Action: /mount ^| /dismount ^| /auto ^| /version
                echo optional Option: /debug ^| /silent
                echo.
                echo Action
                echo /mount            Mounts a decrypted TrueCrypt volume.
                echo /dismount         Dismounts a Truecrypt volume.
                echo /auto             Either mounts a Truecrypt volume if it is dismounted or dismounts a TrueCrypt volume if it is mounted.
                echo /version          Prints version and exits.
                echo.
                echo Option
                echo /debug            Print debug messages. NOTE: If set, other options will be ignored.
                echo /silent           Suppress errors if keyfile or token device was not found.
                echo.
                pause
				exit /b
            )
        )
    )
)
 
:MOUNT
    if not exist %KEYFILE% (
        if not "%2"=="/silent" (
            echo Keyfile not found!
        )
        goto :ERROR
    )
  
    echo Mounting... 
    timeout /T 1  > nul
    %TRUECRYPTPATH% /q /v %MOUNTDEVICE% /l %MOUNTPATH:~0,1%  /p "" /k %KEYFILE%
    
    if %ERRORLEVEL%==1 (
        goto :ERROR
    ) else (
        goto :FINISH
    )
    exit :MOUNT
  
:DISMOUNT
    echo Dismounting...
    timeout /T 1  > nul
    %TRUECRYPTPATH% /q /d %MOUNTPATH:~0,1%

    if %ERRORLEVEL%==1 (
        goto :ERROR
    ) else (
        goto :FINISH
    )
    exit :DISMOUNT

:ERROR
    echo Error!
    pause
    exit :ERROR

:FINISH
    echo Successful!
    exit :FINISH
