@echo off

set file=""
set vlcExe=""
set vlcParams= --qt-start-minimized --fullscreen --loop --no-video-title-show --no-video-deco --video-on-top --zoom=1.0
set fileFormats= *.webm *.mp4 *.ogg *.mov *.avi *.flv *.wmv

set path64="C:\Program Files\VideoLAN"
set path32="C:\Program Files (x86)\VideoLAN"

cd %path64%
for /f "delims=" %%f in ('dir /b/s vlc.exe') do set "vlcExe=%%f"e

if exist %vlcExe% (
goto PLAY
) else (
goto FIND32 
)

:PLAY
echo vlc-player found %vlcExe%
cd %~dp0
for /f "delims=" %%f in ('dir /b %fileFormats%') do set "file=%%f"
if exist %file% (
echo play video %~dp0%file%
start "" "%vlcExe%" %vlcParams% "%~dp0%file%" 
exit
) else (
echo No video-file found in %~dp0
pause
exit
)

:FIND32
cd %path32%
for /f "delims=" %%f in ('dir /b/s vlc.exe') do set "vlcExe=%%f"e
if exist %vlcExe% (
goto PLAY
) else (
echo No valid vlc.exe found in %path64% and %path32%
pause 
)

