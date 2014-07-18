:: TrueCrypt volume mounting and dismounting script (Windows Version).
:: 
:: @author Philipp Meisberger <team@pm-codeworks.de>
:: @version 2.0
::

@echo off
title PM
cd C:\Program Files\TrueCrypt\
if exist E:\ (
	goto :DISMOUNT
) else (
	goto :INIT
)

:INIT
  if "%1"=="-verbose" @echo on
  if "%1"=="-dismount" exit :INIT
  if exist X:\Key (
      goto :MOUNT
  ) else (
	  if not "%1"=="-silent" (
		 echo.Keyfile not found!		 
		 goto :ERROR
	  )
  )
  exit :INIT
 
:MOUNT
  echo.Mounting... 
  timeout /T 1  > nul     
  truecrypt /q /v \Device\Harddisk0\Partition4 /l E /p "" /k "X:\Key"  
  if %ERRORLEVEL%==1 (
      goto :ERROR
  ) else (
      goto :FINISH
  )
  exit :MOUNT
  
:DISMOUNT
  echo.Dismounting...
  timeout /T 1  > nul     
  truecrypt /q /dE      
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