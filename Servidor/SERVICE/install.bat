set current_dir=%~dp0

rem *** Install the Polyglot Service.

"%current_dir%"\Servidor.exe /install

rem *** Start the service.

net start "PolyglotServer"

pause