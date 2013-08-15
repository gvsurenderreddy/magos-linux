#!/bin/bash
# copy icons
cp -pf usr/share/pixmaps/leafpad.png usr/share/mcc/themes/default
# locale file fixes
PFP=usr/share/locale/ru/LC_MESSAGES/drakconf
msgunfmt $PFP.mo -o drakconf.po
if ! grep -q XZM drakconf.po ;then
  cat >>drakconf.po <<EOF

msgid "MagOS Tools"
msgstr "Инструменты MagOS"

msgid "Modules Management"
msgstr "Управление модулями"

msgid "Install Software & Create LZM/XZM module"
msgstr "Установить приложения и создать модуль LZM/XZM"

msgid "Convert LZM/XZM modules"
msgstr "Преобразование модулей LZM/XZM"

msgid "Modules Manager"
msgstr "Управление модулями"

msgid "Configs Management"
msgstr "Управление настройками"

msgid "Configs Manager"
msgstr "Правка настроек"

EOF
  msgfmt drakconf.po -o $PFP.mo
fi
rm -f drakconf.po
exit 0
