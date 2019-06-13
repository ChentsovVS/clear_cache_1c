chcp 1251 >nul

rem создаем файлы и папки, пробуем очистить кэш
mkdir d:\tmp\
mkdir d:\tmp\appdata\
mkdir d:\tmp\localappdata\

copy %AppData%\1C\1Cv8 d:\tmp\appdata\
copy %localappdata%\1c\1cv8 d:\tmp\localappdata\

rmdir "%AppData%\1C\1Cv8" /S /Q
rmdir "%LOCALAPPDATA%\1C\1Cv8" /S /Q 

dir %appdata%\1c\1cv8 > d:\tmp\info_dir_before.txt
dir %localappdata%\1c\1cv8 >> d:\tmp\info_dir_before.txt

set info_dir = d:\tmp\info_dir_before.txt

rem настраиваем поиск текста и включаем if\else на проверку удаленных объектов. 
find "*-*-*-*-*" %info_dir%  > d:\tmp\buffer.txt
set /p buffer < d:\tmp\buffer.txt

	IF "%buffer%"=="" (
		echo "clear cache succesfull" > d:\tmp\log.txt && echo %time% > d:\tmp\log.txt && echo %date% >d:\tmp\log.txt

	) Else (
		echo "users used this dir, droping users" > d:\tmp\log.txt && echo %time% > d:\tmp\log.txt && echo %date% >d:\tmp\log.txt
		net session /delete /y 
		taskkill /IM 1cv8.exe /f 
		copy %AppData%\1C\1Cv8 d:\tmp\appdata\
		copy %localappdata%\1c\1cv8 d:\tmp\localappdata\
		rmdir "%AppData%\1C\1Cv8" /S /Q
		rmdir "%LOCALAPPDATA%\1C\1Cv8" /S /Q 

rem логика простая - мы удаляем кэш, проверяем наличие папок - если они есть - грохаем все подключения и пытаемся грохнуть заново
