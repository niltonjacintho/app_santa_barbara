@echo off
Echo atualizando pacotes
call flutter pub get
echo Limpando arquivos
Echo Clean
call flutter clean
Echo Building
call flutter build apk --release --split-per-abi --target-platform android-arm 
