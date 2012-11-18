#!/bin/bash

# Описание: Создает XZM для базовых модулей MagOS
# Дата модификации: 18.11.2012
# Автор: Горошкин Антон

MOD_NAMES_DIR=mod_names
MOD_ROOTFS_DIR=mod_rootfs
mod_prev=$MOD_ROOTFS_DIR/ro
rootfs=$MOD_ROOTFS_DIR/rootfs

mkdir -p $rootfs 


for mod in `ls -1 $MOD_NAMES_DIR/??-base$1*` ;do 
    echo "Создание XZM для модуля $(basename $mod)"
    mod_line=$MOD_ROOTFS_DIR/$(basename $mod)
    mksquashfs $mod_line $mod_line.xzm -b 512k
#--------------
    echo -ne \\n "---> OK."\\n
done
