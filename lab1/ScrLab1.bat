@echo off
chcp 65001
set /p NAME="Введите имя сети "
set /p settings="выберите настройки (1 - Автоматически (DHCP), 2 - ручной):"
echo Выбраны настройки - %settings%

if %settings% equ 2 goto manual

:auto
netsh interface ipv4 set addres %NAME% source=dhcp
goto end

:manual

set /p IP="Введите ip-адрес: "
set /p MASK="Введите маску сети:"
set /p GATEWAY="Введите gateway: "
set /p GWMETRIC="Введите основной шлюз: "
set /p DNS1="Введите DNS-сервер: "


netsh interface ipv4 set address %NAME% static %IP% %MASK% %GATEWAY% %GWMETRIC% 
netsh interface ipv4 set dnsservers %NAME% static %DNS1% primary

:end
set /p a="Нажмите Enter для продолжения"
pause

