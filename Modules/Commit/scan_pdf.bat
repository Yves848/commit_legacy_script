for /r %2 %%d in (*.pdf) do %1\gswin32c.exe -dNOPAUSE -dBATCH -q -r150 -sDEVICE=tiff12nc -sCompression=lzw -sOutputFile="%%~dpnd.tif" "%%d"
pause
