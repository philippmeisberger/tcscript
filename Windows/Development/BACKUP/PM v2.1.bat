:: TrueCrypt volume mounting and dismounting script (Windows Version).
:: 
:: @author Philipp Meisberger <team@pm-codeworks.de>
:: @version 2.4
::
@echo off
title PM
cd C:\Program Files\TrueCrypt\

set MOUNTDEVICE=\Device\Harddisk0\Partition4
set MOUNTPATH=E:\
set KEYFILE=X:\Key

if "%2"=="-debug" @echo on

if "%1"=="-dismount" (
	goto :DISMOUNT
) else (
	if "%1"=="-mount" (
		goto :MOUNT
	) else (
		if "%1"=="-auto" (
			if exist %MOUNTPATH% (
				goto :DISMOUNT
			) else (
				goto :MOUNT
			)
		) else (
			echo.Invalid argument!
			pause
			exit
		)
	)
)
 
:MOUNT
  if not exist %KEYFILE% (
	  if not "%2"=="-silent" (
		 echo.Keyfile not found!
	  )
	  goto :ERROR
  )
  
  echo.Mounting... 
  timeout /T 1  > nul
  truecrypt /q /v %MOUNTDEVICE% /l %MOUNTPATH:~0%  /p "" /k %KEYFILE%
  if %ERRORLEVEL%==1 (
      goto :ERROR
  ) else (
      goto :FINISH
  )
  exit :MOUNT
  
:DISMOUNT
  echo.Dismounting...
  timeout /T 1  > nul
  truecrypt /q /d %MOUNTPATH:~0%
  
  if %ERRORLEVEL%==1 (
	  goto :ERROR
  ) else (
      goto :FINISH
  )
  exit :DISMOUNT

:ERROR
  echo.Error!
  pause
  exit :ERROR

:FINISH
  echo.Successful!
  exit :FINISH