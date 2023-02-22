#!/bin/bash

#  Script para post-install ArchLinux
#  Github: Vaz15k

# correção gnome default explorer xdg-mime default org.gnome.Nautilus.desktop inode/directory application/x-gnome-saved-search

function menu() {
   echo "Escolha o que deseja instalar..."
   echo ""
   echo "1. Chaotic AUR"
   echo "2. Vivaldi"
   echo "3. Serviços de Impressao"
   echo "4. Serviços de Bluetooh"
   echo "5. Apps Utils"
   echo "6. Minecraft"
   echo "7. Apps AUR - Instale a Opção 1 primeiro"
   echo ""
   echo "s. Sair"
   read opc

case $opc in
		1)
			echo "Chaotic AUR selecionado"
			paru
			menu
			;;
		2)
			echo "Vivaldi selecionado"
			chaotic
			menu
			;;
		3)
			echo "Serviços de Impressao selecionado"
			press
			menu
			;;
      4)
         echo "Serviços Bluetooh selecionado"
         blue
         menu
         ;;
      5)
         echo "Ultilidades sendo instaldas"
         util
         menu
         ;;
      6)
         echo "Instalando o Mojangão"
         mine
         menu
         ;;
      7)
         echo "Instalando Apps AUR"
         apps_aur
         menu
         ;;
		s)
			echo "Sair."
			sair
			;;
		*)
			echo "Opção inválida...."
			menu
			;;
	esac
}

# Comandos de instalação segundo o menu

function chaotic () {
   clear
   echo "Instalando Chaotic AUR..."
   echo "Se poder faça a instalação do paru AUR, "
   pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
   pacman-key --lsign-key FBA220DFC880C036
   pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm
   cat "[chaotic-aur] Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf
   clear
   echo "Chaotic AUR instalado"
   sleep 5
   clear
}

function vivaldi () {
   clear
   echo "Instalando Vivaldi"
   pacman -S vivaldi vivaldi-ffmpeg-codecs --noconfirm
   clear
   echo "Vivaldi Pronto, RECOMENDADO REINICIAR"
   sleep 5
   clear
}

function press () {
   clear
   echo "Preparando Ambiente de impressao"
   pacman -S cups hplip --noconfirm
   systemctl enable cups
   systemctl start cups
   clear
   echo "Pronto para imprimir"
   sleep 5
   clear
}

function blue () {
   clear
   echo "Preparando o Bluetooth"
   pacman -S bluez bluez-utils --noconfirm
   systemctl enable bluetooth.service
   systemctl start bluetooth.service
   clear
   echo "Pronto para se conectar"
   sleep 5
   clear
}

function util () {
   clear
   echo "Instalado apps comuns"
   pacman -S corectrl android-tools scrcpy telegram-desktop fd tldr man micro bashtop dosfstools mtools --noconfirm
   clear
   echo "Instalando codecs de audio e video"
   pacman -S ffmpeg gst-plugins-ugly gst-plugins-good gst-plugins-base gst-plugins-bad gst-libav gstreamer ntfs-3g --noconfirm
   clear
   echo "Instalando libs para python"
   sudo pacman -S git curl base-devel make libmysqlclient openssl gcc python3 --noconfirm
   clear
   echo "Aplicativos prontos"
   sleep 5
   clear
}

function mine () {
   clear
   echo "Preparando o Minecraft"
   echo ""
   echo "Deseja instalar qual launcher?"
   echo ""
   echo "1. Minecraft Launcher"
   echo "2. PrismLauncher"
   echo "v. Voltar ao menu Principal"
   echo ""
   echo "Nessesario o Chaotic AUR instalado"
   read laun

   case $laun in 
   1)
      echo "Instalando o Launcher Original"
      pacman -S jdk-openjdk jre-openjdk minecraft-launcher gnome-keyring --noconfirm
      clear
      echo "Mojang é meu ovo"
      sleep 5
      clear
      ;;
   2)
      echo "Instalando o PrismLauncher"
      pacman -S jdk-openjdk jre-openjdk PrismLauncher --noconfirm
      clear
      echo "Algumas versões especificas nescessitam de instalação extra de outros javas"
      echo "Mojang é meu ovo"
      sleep 5
      clear
      ;;
   v)
      clear
      echo "Voltando ao menu"
      sleep 2
      menu
      ;;
      
   *)
   	echo "Opção inválida...."
		menu
		;;
   esac
}

function apps_aur () {
   clear
   echo "Esses apps nescessitam do Chaotic AUR instalado"
   pacman -S visual-studio-code-bin jamesdsp heimdall-grimler-git  --noconfirm
}

sair() {
        clear
        echo "Seja feliz"
        exit
#  break
}

#  Checagem de SuperUser

if [ $UID = "0" ]; then
   echo "Iniciando o Menu Principal."
   menu
else
   echo "Coloca como root idota, sabe que essa merda nao roda sem root"
   exit 0
fi