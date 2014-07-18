@echo off
cd C:\Program Files\TrueCrypt\
if exist E:\ (
	goto DISMOUNT
) else (
	goto MOUNT
)
	
:MOUNT
  echo.Mounting... 
  timeout /T 1  > nul     
  truecrypt /q /v "C:\Users\Phil\Documents\Container" /p "" /l E /k "X:\Key"  
  if %ERRORLEVEL%==1 (
      goto ERROR
  ) else (
      goto FINISH
  )
  Exit MOUNT
  
:DISMOUNT
  echo.Dismounting...
  timeout /T 1  > nul     
  truecrypt /q /dE        
  if %ERRORLEVEL%==1 (
	  goto ERROR
  ) else (
	  goto FINISH
  )
  Exit DISMOUNT

:ERROR
  echo.Error!
  Pause
  Exit ERROR

:FINISH
  echo.Successful!
  Exit FINISH