@echo off
goto:$Main

:$Main
    setlocal EnableExtensions EnableDelayedExpansion

    set "_tiny11_base_dir=c:\tiny11"
    set "_tiny11_dest=%_tiny11_base_dir%\dest"
    set "_tiny11_scratch=%_tiny11_base_dir%\scratch"
    if not exist "%_tiny11_base_dir%" mkdir "%_tiny11_base_dir%"
    if not exist "%_tiny11_dest%" mkdir "%_tiny11_dest%"
    if not exist "%_tiny11_scratch%" mkdir "%_tiny11_scratch%"

    title tiny11 builder alpha
    echo Welcome to the tiny11 image creator!
    timeout /t 3 /nobreak > nul
    cls

    set DriveLetter=
    set /p DriveLetter=Please enter the drive letter for the Windows 11 image:
    set "DriveLetter=%DriveLetter%:"
    echo.
    if not exist "%DriveLetter%\sources\boot.wim" (
        echo.Can't find Windows OS Installation files in the specified Drive Letter..
        echo.
        echo.Please enter the correct DVD Drive Letter..
        goto :Stop
    )

    if not exist "%DriveLetter%\sources\install.wim" (
        echo.Can't find Windows OS Installation files in the specified Drive Letter..
        echo.
        echo.Please enter the correct DVD Drive Letter..
        goto :Stop
    )
    md %_tiny11_dest%
    echo Copying Windows image...
    xcopy.exe /E /I /H /R /Y /J %DriveLetter% %_tiny11_dest% >nul
    echo Copy complete!
    sleep 2
    cls

    sudo cache on
    set "_dism=sudo dism"
    echo Getting image information:
    %_dism% /Get-WimInfo /wimfile:%_tiny11_dest%\sources\install.wim
    set index=
    set /p index=Please enter the image index:
    set "index=%index%"
    echo Mounting Windows image. This may take a while.
    echo.
    md %_tiny11_scratch%
    %_dism% /mount-image /imagefile:%_tiny11_dest%\sources\install.wim /index:%index% /mountdir:%_tiny11_scratch%
    echo Mounting complete! Performing removal of applications...
    echo Removing Clipchamp...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:Clipchamp.Clipchamp_2.2.8.0_neutral_~_yxz26nhyzhsrt
    echo Removing News...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.BingNews_2022.507.446.0_neutral_~_8wekyb3d8bbwe
    echo Removing Weather...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.BingWeather_2022.507.447.0_neutral_~_8wekyb3d8bbwe
    echo Removing Xbox...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.GamingApp_2022.507.447.0_neutral_~_8wekyb3d8bbwe
    echo Removing GetHelp...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.GetHelp_2022.507.447.0_neutral_~_8wekyb3d8bbwe
    echo Removing GetStarted...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.Getstarted_2022.507.447.0_neutral_~_8wekyb3d8bbwe
    echo Removing Office Hub...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.MicrosoftOfficeHub_2022.507.447.0_neutral_~_8wekyb3d8bbwe
    echo Removing Solitaire...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.MicrosoftSolitaireCollection_2022.507.447.0_neutral_~_8wekyb3d8bbwe
    echo Removing PeopleApp...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.People_2022.507.446.0_neutral_~_8wekyb3d8bbwe
    echo Removing PowerAutomate...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.PowerAutomateDesktop_2022.507.446.0_neutral_~_8wekyb3d8bbwe
    echo Removing ToDo...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.Todos_2022.507.447.0_neutral_~_8wekyb3d8bbwe
    echo Removing Alarms...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.WindowsAlarms_2022.507.446.0_neutral_~_8wekyb3d8bbwe
    echo Removing Mail...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:microsoft.windowscommunicationsapps_2022.507.447.0_neutral_~_8wekyb3d8bbwe
    echo Removing Feedback Hub...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.WindowsFeedbackHub_2022.507.447.0_neutral_~_8wekyb3d8bbwe
    echo Removing Maps...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.WindowsMaps_2022.507.447.0_neutral_~_8wekyb3d8bbwe
    echo Removing Sound Recorder...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.WindowsSoundRecorder_2022.507.447.0_neutral_~_8wekyb3d8bbwe
    echo Removing XboxTCUI...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.Xbox.TCUI_2022.507.446.0_neutral_~_8wekyb3d8bbwe
    echo Removing XboxGamingOverlay...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.XboxGamingOverlay_2022.507.447.0_neutral_~_8wekyb3d8bbwe
    echo Removing XboxGameOverlay...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.XboxGameOverlay_2022.507.446.0_neutral_~_8wekyb3d8bbwe
    echo Removing XboxSpeechToTextOverlay...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.XboxSpeechToTextOverlay_2022.507.446.0_neutral_~_8wekyb3d8bbwe
    echo Removing Your Phone...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.YourPhone_2022.507.447.0_neutral_~_8wekyb3d8bbwe
    echo Removing Music...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.ZuneMusic_2022.507.447.0_neutral_~_8wekyb3d8bbwe
    echo Removing Video...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.ZuneVideo_2022.507.446.0_neutral_~_8wekyb3d8bbwe
    echo Removing Family...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:MicrosoftCorporationII.MicrosoftFamily_2022.507.447.0_neutral_~_8wekyb3d8bbwe
    echo Removing QuickAssist...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:MicrosoftCorporationII.QuickAssist_2022.507.446.0_neutral_~_8wekyb3d8bbwe
    echo Removing Teams...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:MicrosoftTeams_23002.403.1788.1930_x64__8wekyb3d8bbwe
    echo Removing Cortana...
    %_dism% /image:%_tiny11_scratch% /Remove-ProvisionedAppxPackage /PackageName:Microsoft.549981C3F5F10_4.2204.13303.0_neutral_~_8wekyb3d8bbwe

    echo Removing of system apps complete! Now proceeding to removal of system packages...
    timeout /t 1 /nobreak > nul
    cls
    echo Removing Internet Explorer...
    %_dism% /image:%_tiny11_scratch% /Remove-Package /PackageName:Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~amd64~en-US~11.0.22621.1 > nul
    %_dism% /image:%_tiny11_scratch% /Remove-Package /PackageName:Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~amd64~~11.0.22621.1265 > nul
    echo Removing LA57:
    %_dism% /image:%_tiny11_scratch% /Remove-Package /PackageName:Microsoft-Windows-Kernel-LA57-FoD-Package~31bf3856ad364e35~amd64~~10.0.22621.1265 > nul
    echo Removing Handwriting:
    %_dism% /image:%_tiny11_scratch% /Remove-Package /PackageName:Microsoft-Windows-LanguageFeatures-Handwriting-en-us-Package~31bf3856ad364e35~amd64~~10.0.22621.1265 > nul
    echo Removing OCR:
    %_dism% /image:%_tiny11_scratch% /Remove-Package /PackageName:Microsoft-Windows-LanguageFeatures-OCR-en-us-Package~31bf3856ad364e35~amd64~~10.0.22621.1265 > nul
    echo Removing Speech:
    %_dism% /image:%_tiny11_scratch% /Remove-Package /PackageName:Microsoft-Windows-LanguageFeatures-Speech-en-us-Package~31bf3856ad364e35~amd64~~10.0.22621.1265 > nul
    echo Removing TTS:
    %_dism% /image:%_tiny11_scratch% /Remove-Package /PackageName:Microsoft-Windows-LanguageFeatures-TextToSpeech-en-us-Package~31bf3856ad364e35~amd64~~10.0.22621.1265 > nul
    echo Removing Media Player Legacy:
    %_dism% /image:%_tiny11_scratch% /Remove-Package /PackageName:Microsoft-Windows-MediaPlayer-Package~31bf3856ad364e35~amd64~~10.0.22621.1265 > nul
    %_dism% /image:%_tiny11_scratch% /Remove-Package /PackageName:Microsoft-Windows-MediaPlayer-Package~31bf3856ad364e35~wow64~en-US~10.0.22621.1 > nul
    %_dism% /image:%_tiny11_scratch% /Remove-Package /PackageName:Microsoft-Windows-MediaPlayer-Package~31bf3856ad364e35~amd64~~10.0.22621.1265 > nul
    %_dism% /image:%_tiny11_scratch% /Remove-Package /PackageName:Microsoft-Windows-MediaPlayer-Package~31bf3856ad364e35~wow64~~10.0.22621.1 > nul
    echo Removing Tablet PC Math:
    %_dism% /image:%_tiny11_scratch% /Remove-Package /PackageName:Microsoft-Windows-TabletPCMath-Package~31bf3856ad364e35~amd64~~10.0.22621.1265 > nul
    echo Removing Wallpapers:
    %_dism% /image:%_tiny11_scratch% /Remove-Package /PackageName:Microsoft-Windows-Wallpaper-Content-Extended-FoD-Package~31bf3856ad364e35~amd64~~10.0.22621.1265 > nul

    echo Removing Edge:
    rd "%_tiny11_scratch%\Program Files (x86)\Microsoft\Edge" /s /q
    rd "%_tiny11_scratch%\Program Files (x86)\Microsoft\EdgeUpdate" /s /q
    echo Removing OneDrive:
    sudo takeown /f %_tiny11_scratch%\Windows\System32\OneDriveSetup.exe
    sudo icacls %_tiny11_scratch%\Windows\System32\OneDriveSetup.exe /grant Administrators:F /T /C
    sudo del /f /q /s "%_tiny11_scratch%\Windows\System32\OneDriveSetup.exe"
    echo Removal complete!
    timeout /t 2 /nobreak > nul
    cls
    echo Loading registry...
    reg load HKLM\zCOMPONENTS "%_tiny11_scratch%\Windows\System32\config\COMPONENTS" >nul
    reg load HKLM\zDEFAULT "%_tiny11_scratch%\Windows\System32\config\default" >nul
    reg load HKLM\zNTUSER "%_tiny11_scratch%\Users\Default\ntuser.dat" >nul
    reg load HKLM\zSOFTWARE "%_tiny11_scratch%\Windows\System32\config\SOFTWARE" >nul
    reg load HKLM\zSYSTEM "%_tiny11_scratch%\Windows\System32\config\SYSTEM" >nul
    echo Bypassing system requirements(on the system image):
                Reg add "HKLM\zDEFAULT\Control Panel\UnsupportedHardwareNotificationCache" /v "SV1" /t REG_DWORD /d "0" /f >nul 2>&1
                Reg add "HKLM\zDEFAULT\Control Panel\UnsupportedHardwareNotificationCache" /v "SV2" /t REG_DWORD /d "0" /f >nul 2>&1
                Reg add "HKLM\zNTUSER\Control Panel\UnsupportedHardwareNotificationCache" /v "SV1" /t REG_DWORD /d "0" /f >nul 2>&1
                Reg add "HKLM\zNTUSER\Control Panel\UnsupportedHardwareNotificationCache" /v "SV2" /t REG_DWORD /d "0" /f >nul 2>&1
                Reg add "HKLM\zSYSTEM\Setup\LabConfig" /v "BypassCPUCheck" /t REG_DWORD /d "1" /f >nul 2>&1
                Reg add "HKLM\zSYSTEM\Setup\LabConfig" /v "BypassRAMCheck" /t REG_DWORD /d "1" /f >nul 2>&1
                Reg add "HKLM\zSYSTEM\Setup\LabConfig" /v "BypassSecureBootCheck" /t REG_DWORD /d "1" /f >nul 2>&1
                Reg add "HKLM\zSYSTEM\Setup\LabConfig" /v "BypassStorageCheck" /t REG_DWORD /d "1" /f >nul 2>&1
                Reg add "HKLM\zSYSTEM\Setup\LabConfig" /v "BypassTPMCheck" /t REG_DWORD /d "1" /f >nul 2>&1
                Reg add "HKLM\zSYSTEM\Setup\MoSetup" /v "AllowUpgradesWithUnsupportedTPMOrCPU" /t REG_DWORD /d "1" /f >nul 2>&1
    echo Disabling Teams:
    Reg add "HKLM\zSOFTWARE\Microsoft\Windows\CurrentVersion\Communications" /v "ConfigureChatAutoInstall" /t REG_DWORD /d "0" /f >nul 2>&1
    echo Disabling Sponsored Apps:
    Reg add "HKLM\zNTUSER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
                Reg add "HKLM\zNTUSER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
                Reg add "HKLM\zNTUSER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
                Reg add "HKLM\zSOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f >nul 2>&1
                Reg add "HKLM\zSOFTWARE\Microsoft\PolicyManager\current\device\Start" /v "ConfigureStartPins" /t REG_SZ /d "{\"pinnedList\": [{}]}" /f >nul 2>&1
    echo Enabling Local Accounts on OOBE:
    Reg add "HKLM\zSOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "BypassNRO" /t REG_DWORD /d "1" /f >nul 2>&1
    copy /y %~dp0autounattend.xml %_tiny11_scratch%\Windows\System32\Sysprep\autounattend.xml
    echo Disabling Reserved Storage:
    Reg add "HKLM\zSOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" /v "ShippedWithReserves" /t REG_DWORD /d "0" /f >nul 2>&1
    echo Disabling Chat icon:
    Reg add "HKLM\zSOFTWARE\Policies\Microsoft\Windows\Windows Chat" /v "ChatIcon" /t REG_DWORD /d "3" /f >nul 2>&1
    Reg add "HKLM\zNTUSER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarMn" /t REG_DWORD /d "0" /f >nul 2>&1
    echo Tweaking complete!
    echo Unmounting Registry...
    reg unload HKLM\zCOMPONENTS >nul 2>&1
    reg unload HKLM\zDRIVERS >nul 2>&1
    reg unload HKLM\zDEFAULT >nul 2>&1
    reg unload HKLM\zNTUSER >nul 2>&1
    reg unload HKLM\zSCHEMA >nul 2>&1
    reg unload HKLM\zSOFTWARE >nul 2>&1
    reg unload HKLM\zSYSTEM >nul 2>&1
    echo Cleaning up image...
    %_dism% /image:%_tiny11_scratch% /Cleanup-Image /StartComponentCleanup /ResetBase
    echo Cleanup complete.
    echo Unmounting image...
    %_dism% /unmount-image /mountdir:%_tiny11_scratch% /commit
    echo Exporting image...
    %_dism% /Export-Image /SourceImageFile:%_tiny11_dest%\sources\install.wim /SourceIndex:%index% /DestinationImageFile:%_tiny11_dest%\sources\install2.wim /compress:max
    del %_tiny11_dest%\sources\install.wim
    ren %_tiny11_dest%\sources\install2.wim install.wim
    echo Windows image completed. Continuing with boot.wim.
    timeout /t 2 /nobreak > nul
    cls
    echo Mounting boot image:
    %_dism% /mount-image /imagefile:%_tiny11_dest%\sources\boot.wim /index:2 /mountdir:%_tiny11_scratch%
    echo Loading registry...
    reg load HKLM\zCOMPONENTS "%_tiny11_scratch%\Windows\System32\config\COMPONENTS" >nul
    reg load HKLM\zDEFAULT "%_tiny11_scratch%\Windows\System32\config\default" >nul
    reg load HKLM\zNTUSER "%_tiny11_scratch%\Users\Default\ntuser.dat" >nul
    reg load HKLM\zSOFTWARE "%_tiny11_scratch%\Windows\System32\config\SOFTWARE" >nul
    reg load HKLM\zSYSTEM "%_tiny11_scratch%\Windows\System32\config\SYSTEM" >nul
    echo Bypassing system requirements(on the setup image):
                Reg add "HKLM\zDEFAULT\Control Panel\UnsupportedHardwareNotificationCache" /v "SV1" /t REG_DWORD /d "0" /f >nul 2>&1
                Reg add "HKLM\zDEFAULT\Control Panel\UnsupportedHardwareNotificationCache" /v "SV2" /t REG_DWORD /d "0" /f >nul 2>&1
                Reg add "HKLM\zNTUSER\Control Panel\UnsupportedHardwareNotificationCache" /v "SV1" /t REG_DWORD /d "0" /f >nul 2>&1
                Reg add "HKLM\zNTUSER\Control Panel\UnsupportedHardwareNotificationCache" /v "SV2" /t REG_DWORD /d "0" /f >nul 2>&1
                Reg add "HKLM\zSYSTEM\Setup\LabConfig" /v "BypassCPUCheck" /t REG_DWORD /d "1" /f >nul 2>&1
                Reg add "HKLM\zSYSTEM\Setup\LabConfig" /v "BypassRAMCheck" /t REG_DWORD /d "1" /f >nul 2>&1
                Reg add "HKLM\zSYSTEM\Setup\LabConfig" /v "BypassSecureBootCheck" /t REG_DWORD /d "1" /f >nul 2>&1
                Reg add "HKLM\zSYSTEM\Setup\LabConfig" /v "BypassStorageCheck" /t REG_DWORD /d "1" /f >nul 2>&1
                Reg add "HKLM\zSYSTEM\Setup\LabConfig" /v "BypassTPMCheck" /t REG_DWORD /d "1" /f >nul 2>&1
                Reg add "HKLM\zSYSTEM\Setup\MoSetup" /v "AllowUpgradesWithUnsupportedTPMOrCPU" /t REG_DWORD /d "1" /f >nul 2>&1
    echo Tweaking complete!
    echo Unmounting Registry...
    reg unload HKLM\zCOMPONENTS >nul 2>&1
    reg unload HKLM\zDRIVERS >nul 2>&1
    reg unload HKLM\zDEFAULT >nul 2>&1
    reg unload HKLM\zNTUSER >nul 2>&1
    reg unload HKLM\zSCHEMA >nul 2>&1
    reg unload HKLM\zSOFTWARE >nul 2>&1
    reg unload HKLM\zSYSTEM >nul 2>&1
    echo Unmounting image...
    %_dism% /unmount-image /mountdir:%_tiny11_scratch% /commit
    cls
    echo the tiny11 image is now completed. Proceeding with the making of the ISO...
    echo Copying unattended file for bypassing MS account on OOBE...
    copy /y %~dp0autounattend.xml %_tiny11_dest%\autounattend.xml
    echo.
    echo Creating ISO image...
    %~dp0oscdimg.exe -m -o -u2 -udfver102 -bootdata:2#p0,e,b%_tiny11_dest%\boot\etfsboot.com#pEF,e,b%_tiny11_dest%\efi\microsoft\boot\efisys.bin %_tiny11_dest% %~dp0tiny11.iso
    echo Creation completed! Press any key to exit the script...
    pause
    echo Performing Cleanup...
    rd %_tiny11_dest% /s /q
    rd %_tiny11_scratch% /s /q
    sudo cache off
exit /b %errorlevel%
