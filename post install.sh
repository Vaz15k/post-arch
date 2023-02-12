#!/bin/bash

#  Script para post-install ArchLinux
#  Github: Vaz15k

# correção gnome default explorer xdg-mime default org.gnome.Nautilus.desktop inode/directory application/x-gnome-saved-search

function menu() {
   echo "Escolha o que deseja instalar..."
   echo ""
   echo "1. Paru"
   echo "2. ChaoticAUR"
   echo "3. Vivaldi"
   echo "4. Serviços de Impressao"
   echo "5. Serviços de Bluetooh"
   echo "6. Apps Utils"
   echo "7. Minecraft"
   echo ""
   echo "s. Sair"
   read opc

case $opc in
		1)
			echo "Paru selecionado"
			paru
			menu
			;;
		2)
			echo "Chaotic AUR selecionado"
			chaotic
			menu
			;;
		3)
			echo "Vivaldi selecionado"
			vivaldi
			menu
			;;
		4)
			echo "Serviços de Impressao selecionado"
			press
			menu
			;;
      5)
         echo "Serviços Bluetooh selecionado"
         blue
         menu
         ;;
      6)
         echo "Ultilidades sendo instaldas"
         util
         menu
         ;;
      7)
         echo "Instalando o Mojangão"
         mine
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

function paru() {
   clear
   echo "Instalando o Paru AUR..."
   sudo pacman -S --needed base-devel git --noconfirm
   git clone https://aur.archlinux.org/paru.git
   cd paru
   makepkg -si --noconfirm
   clear
   cd ..
   rm -fr paru/
   echo "Paru AUR Instalado"
   sleep 5
   clear
}

function chaotic () {
   clear
   echo "Instalando Chaotic AUR..."
   pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
   pacman-key --lsign-key FBA220DFC880C036
   pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm
   cat "[chaotic-aur]
   Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf
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
   systemctl enable bluetooth.services
   systemctl start bluetooth.services
   clear
   echo "Pronto para se conectar"
   sleep 5
   clear
}

function util () {
   clear
   echo "Instalado apps comuns"
   pacman -S corectrl android-tools scrcpy telegram-desktop fd tldr man bashtop dosfstools mtools --noconfirm
   clear
   echo "Instalando libs para python"
   sudo pacman -S git curl base-devel make libmysqlclient openssl gcc python3
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