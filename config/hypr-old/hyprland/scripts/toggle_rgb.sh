#!/bin/bash
# Alamat LED kita
LED="/sys/class/leds/input6::scrolllock/brightness"

# Cek status sekarang, kalau 0 nyalakan, kalau 1 matikan
if [ $(cat $LED) -eq 0 ]; then
    # Nyalakan dan beritahu sistem agar tidak mengubahnya (status locked)
    brightnessctl --device='input6::scrolllock' set 1
else
    brightnessctl --device='input6::scrolllock' set 0
fi