#!/bin/bash

# pre-boot
sudo sed -i 's/if background_color 44,0,30,0; then/if background_color 0,0,0 ; then/g' /usr/share/plymouth/themes/default.grub
sudo update-grub

# boot screen
sudo sed -i 's/^Window.SetBackgroundTopColor.*/Window.SetBackgroundTopColor (0.00, 0.00, 0.00);/g' /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.script
sudo sed -i 's/^Window.SetBackgroundBottomColor.*/Window.SetBackgroundBottomColor (0.00, 0.00, 0.00);/g' /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.script
sudo update-initramfs -u

# login screen
sudo sed -i 's/background-color: #2C001E;/background-color: #000000;/g' /etc/alternatives/gdm3.css

