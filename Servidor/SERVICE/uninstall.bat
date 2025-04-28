set current_dir=%~dp0

rem *** Stop the Polyglot Service.

net stop "PolyglotServer"

rem *** Uninstall the Polyglot Service.

"%current_dir%"\Servidor.exe /uninstall

pause