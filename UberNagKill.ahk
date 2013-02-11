#SingleInstance force

Menu, Tray, Icon, ubernagkill.Ico
GroupAdd, waitOnThese, (901) 263-6338 - chat - stephanieshusband@gmail.com
GroupAdd, waitOnThese, Problem Occurred
GroupAdd, waitOnThese, Trial Version
GroupAdd, waitOnThese, Error with license
GroupAdd, waitOnThese, viPlugin
GroupAdd, waitOnThese, Demo version
GroupAdd, waitOnThese, Welcome to viPlugin for Eclipse
GroupAdd, waitOnThese, VPN Client Banner
GroupAdd, waitOnThese, Microsoft Office Outlook Security Notice
GroupAdd, waitOnThese, Microsoft Outlook Security Notice
GroupAdd, waitOnThese, Java Security Warning
GroupAdd, waitOnThese, Enterprise Password
GroupAdd, waitOnThese, Login to Primavera Timesheets
GroupAdd, waitOnThese, SSO Login - 
GroupAdd, waitOnThese, loadzilla login - Mozilla Firefox
GroupAdd, waitOnThese, Information
GroupAdd, waitOnThese, Login, Sym4a.Prod.fedex.com
GroupAdd, waitOnThese, Check Point Mobile
GroupAdd, waitOnThese, SSL Certificate Verification
GroupAdd, waitOnThese, Remove Activity
GroupAdd, waitOnThese, Create PDF
GroupAdd, waitOnthese, Web Server Authentication
GroupAdd, waitOnThese, Proxy Authentication
GroupAdd, waitOnThese, WD SmartWare Drive Unlock 
GroupAdd, waitOnThese, Authentication Required
;GroupAdd, waitOnThese, Delete Browsing History
;GroupAdd, waitOnThese, Clear Recent History

#Include C:\bin
#Include Utility.ahk
#Include UserAndPwd.ahk
;#Include c:\bin\ScreenCapture.ahk

doCPECLogin = true

Loop
{
   WinWaitActive, ahk_group waitOnThese

   ;---------------------------------------------------------------------------------------
   ; Needs {ENTER} only
   ;---------------------------------------------------------------------------------------
   If WinActive("Remove Activity") or WinActive("Web Server Authentication") or WinActive("Proxy Authentication")
   {
      Send, {ENTER}
      WinWaitClose
      Continue
   }
   ;---------------------------------------------------------------------------------------
   ; Needs {SPACE} only
   ;---------------------------------------------------------------------------------------
   If WinActive("Error with license") or WinActive("viPlugin") or WinActive("VPN Client Banner") or WinActive("Java Security Warning") or WinActive("Information") or WinActive("Problem Occurred") or WinActive("SSL Certificate Verification")
   {
      Send, {SPACE}
      WinWaitClose
      Continue
   }
   ;---------------------------------------------------------------------------------------
   ; Needs {ESC} only
   ;---------------------------------------------------------------------------------------
   if WinActive("Demo version") or WinActive("Welcome to viPlugin for Eclipse")
   {
      Send, {ESC}
      WinWaitClose
      Continue
   }
   ;---------------------------------------------------------------------------------------
   ; Needs "y" only
   ;---------------------------------------------------------------------------------------
   if WinActive("Microsoft Office Outlook Security Notice") or WinActive("Microsoft Outlook Security Notice")
   {
      Send, y
      WinWaitClose
      Continue
   }
   ;---------------------------------------------------------------------------------------
   ; Needs UserIdAndPassword only (no pauses)
   ;---------------------------------------------------------------------------------------
   if WinActive("SSO Login -") or WinActive("Authentication Required")
   {
      Sleep, 1000
      UserIdAndPassword()
      WinWaitClose
      Continue
   }
   ;---------------------------------------------------------------------------------------
   ; Needs PasswordOnly only
   ;---------------------------------------------------------------------------------------
   IfWinActive, Login, Sym4a.Prod.fedex.com
   {
      PasswordOnly()
      Continue
   }
   IfWinActive, Trial Version
   {
      ControlClick,Button1,
      Continue
   }
   IfWinActive, Login to Primavera Timesheets
   {
      Sleep, 1000
      SendInput, +{TAB}
      UserIdOnly()
      WinWaitActive
      SelectAll()
      PasswordOnly()
      Continue
   }
   IfWinActive, loadzilla login - Mozilla Firefox
   {
      Send, {TAB 3}se
      UserIdAndPassword()
      WinWaitClose
      Continue
   }
   IfWinActive, Check Point Mobile
   {
      If doCPECLogin = true
      {
         PasswordOnly()

         WinWaitClose

         doCPECLogin = false

         ; wait 5 minutes before resetting flag
         SetTimer, ResetCheckPointTimer, 300000
      }
      Else
      {
         ;CaptureScreen(1) ; saved to screen.bmp in script dir (c:\bin)

         IfWinNotExist, eGrid.png
         {
            Run, c:\users\263952\desktop\eGrid.png
         }
      }
      Continue
   }
   IfWinActive, Create PDF
   {
      Sleep, 1000
      Send, {TAB 9}{ENTER}
      Sleep, 500
      IfWinActive, Nitro PDF Reader
      {
         Send, {TAB}{SPACE}
         WinWaitClose
      }
      WinWaitClose, Create PDF
      Continue
   }
   IfWinActive, WD SmartWare Drive Unlock
   {
      Send, fedex{ENTER}
   }
   IfWinActive, (901) 263-6338 - chat - stephanieshusband@gmail.com
   {
      IfWinNotExist, GmailCallMute.ahk
      {
         Run, GmailCallMute.ahk
         Sleep, 800
         Send, #s
         Sleep, 800
      }
   }
;   IfWinActive, Delete Browsing History
;   {
;      Send, !d
;      WinWaitClose, Delete Browsing History
;   }
;   IfWinActive, Clear Recent History
;   {
;      Send, {ENTER}
;      Continue
;   }
}

;-----------------------------------------------------
; Reset the Check Point dialog flag after a minute
;-----------------------------------------------------
ResetCheckPointTimer:
   doCPECLogin = true
return
