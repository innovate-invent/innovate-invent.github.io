---
title: Bluetooth surround sound
author_profile: false
published: true
---

**This is a work in progress, please check back later for more**

Bluetooth supports transmitting high quality audio to a wireless device. A relatively cheap and portable surround sound solution can be produced to quickly deploy positional audio in a space. Limitations on the Bluetooth stack prevent connecting multiple audio devices to a single tranciever. This project is to explore the viability of stitching multiple Bluetooth USB tranceivers together into a single multichannel virtual audio sink using features provided with PulseAudio.

## Hardware used for testing
- 4x SODIAL USB Bluetooth dongles (CSR 4.0 chipset) [$9.99 on Amazon.ca](https://www.amazon.ca/gp/product/B00E38N7QE/)
- 4x Anker Soundcore Portable Bluetooth Speaker (AK-848061070804-cr) [$34.99 on Amazon.ca](https://www.amazon.ca/gp/product/B07QQQG7FV/)
- 4 port USB Hub (I had an old SIIG USB3 lying around)
- Laptop with Manjaro Linux

An important feature of the Anker Soundcore Bluetooth speakers is the ability to play audio while charging. This allows providing power if you want to use them longer than their internal batteries support.

## Ensure the Bluetooth dongles are detected
Plug your Bluetooth dongles into the USB hub and plug the hub into the laptop. Open an terminal and run:
```sh
$ lsusb
Bus 001 Device 045: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)
Bus 001 Device 044: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)
Bus 001 Device 043: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)
Bus 001 Device 042: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)
```

You should see the Bluetooth radios listed. If not, try plugging the Bluetooth dongles in one at a time and check that they are being listed.
Possibly try a different USB hub or port on the laptop. If the radios are still not listed see some of the [solutions mentioned here](https://superuser.com/questions/1310775/bluetooth-adapter-not-detected-on-linux).

## Verify the driver configuration
The next step is to ensure that the Bluetooth driver is detecting the radios. Assuming you are using the [Bluez driver](https://archlinux.org/packages/extra/x86_64/bluez/) run:
```sh
$ btmgmt info
Index list with 5 items
hci4:	Primary controller
	addr 00:1A:7D:DA:71:14 version 6 manufacturer 10 class 0x3c010c
	supported settings: powered connectable fast-connectable discoverable bondable link-security ssp br/edr hs le advertising secure-conn debug-keys privacy static-addr phy-configuration 
	current settings: powered bondable ssp br/edr le secure-conn 
	name manjaro #5
	short name 
hci3:	Primary controller
	addr 00:1A:7D:DA:71:13 version 6 manufacturer 10 class 0x3c010c
	supported settings: powered connectable fast-connectable discoverable bondable link-security ssp br/edr hs le advertising secure-conn debug-keys privacy static-addr phy-configuration 
	current settings: powered bondable ssp br/edr le secure-conn 
	name manjaro #4
	short name 
hci2:	Primary controller
	addr 00:1A:7D:DA:71:12 version 6 manufacturer 10 class 0x3c010c
	supported settings: powered connectable fast-connectable discoverable bondable link-security ssp br/edr hs le advertising secure-conn debug-keys privacy static-addr phy-configuration 
	current settings: powered bondable ssp br/edr le secure-conn 
	name manjaro #3
	short name 
hci1:	Primary controller
	addr 00:1A:7D:DA:71:11 version 6 manufacturer 10 class 0x3c010c
	supported settings: powered connectable fast-connectable discoverable bondable link-security ssp br/edr hs le advertising secure-conn debug-keys privacy static-addr phy-configuration 
	current settings: powered bondable ssp br/edr le secure-conn 
	name manjaro #2
	short name 
hci0:	Primary controller
	addr 74:70:FD:B3:E9:25 version 8 manufacturer 2 class 0x3c010c
	supported settings: powered connectable fast-connectable discoverable bondable link-security ssp br/edr hs le advertising secure-conn debug-keys privacy configuration static-addr phy-configuration wide-band-speech 
	current settings: powered bondable ssp br/edr le secure-conn 
	name manjaro
	short name 
hci0:	Configuration options
	supported options: public-address 
	missing options: 

```

You should see your dongles listed with assigned `hci<n>` identifiers. See [ArchWiki Bluetooth troubleshooting](https://wiki.archlinux.org/index.php/Bluetooth#Bluetooth_USB_Dongle) if the dongles are not listed as expected.
Note: `hci0` is the Bluetooth radio built into the laptop. I chose not to use this to ensure uniformity between the channels.

### Change the MAC address'
You may encounter an issue where multiple of the Bluetooth radios are configured with the same MAC address. This will cause a conflict and you will not be able to configure or pair any of the radios. You will need to run `sudo bdaddr -i hci<n> <new mac address>`.
I had to run the following:
```sh
sudo bdaddr -i hci1 00:1A:7D:DA:71:11
sudo bdaddr -i hci2 00:1A:7D:DA:71:12
sudo bdaddr -i hci3 00:1A:7D:DA:71:13
sudo bdaddr -i hci4 00:1A:7D:DA:71:14
```

## Pair speakers
Once the Bluetooth radios are detected and configured, you will be able to pair each speaker with a different dongle. I used the `blueman-manager` GUI provided by the [blueman](https://archlinux.org/packages/community/x86_64/blueman/) package to simplify the task.

With the Bluetooh speakers paired and active, PulseAudio should list them as Bluez sinks:
```sh
$ pactl list short sinks
0	alsa_output.pci-0000_00_1f.3.analog-stereo	module-alsa-card.c	s16le 2ch 44100Hz	RUNNING
7	bluez_sink.08_EB_ED_21_BA_41.a2dp_sink	module-bluez5-device.c	s16le 2ch 44100Hz	RUNNING
8	bluez_sink.08_EB_ED_94_9F_51.a2dp_sink	module-bluez5-device.c	s16le 2ch 44100Hz	RUNNING
10	bluez_sink.08_EB_ED_05_A4_7E.a2dp_sink	module-bluez5-device.c	s16le 2ch 44100Hz	RUNNING
11	bluez_sink.08_EB_ED_B7_D0_3B.a2dp_sink	module-bluez5-device.c	s16le 2ch 44100Hz	RUNNING
```

Ensure you have the speakers configured with the A2DP Bluetooth profile.

## Configure PulseAudio
Now we need to configure the four speaker sinks as a single combined sink. The PulseAudio configuration looks something like:
```sh
#!/usr/bin/env sh
pactl load-module module-remap-sink sink_name=fl sink_properties=device.description="Front-left Bluetooth speaker" master=bluez_sink.08_EB_ED_21_BA_41.a2dp_sink channels=2 channel_map=front-left,front-left master_channel_map=front-left,front-right
pactl load-module module-remap-sink sink_name=fr sink_properties=device.description="Front-right Bluetooth speaker" master=bluez_sink.08_EB_ED_94_9F_51.a2dp_sink channels=2 channel_map=front-right,front-right master_channel_map=front-left,front-right
pactl load-module module-remap-sink sink_name=rl sink_properties=device.description="Rear-left Bluetooth speaker" master=bluez_sink.08_EB_ED_05_A4_7E.a2dp_sink channels=2 channel_map=rear-left,rear-left master_channel_map=front-left,front-right
pactl load-module module-remap-sink sink_name=rr sink_properties=device.description="Rear-right Bluetooth speaker" master=bluez_sink.08_EB_ED_B7_D0_3B.a2dp_sink channels=2 channel_map=rear-right,rear-right master_channel_map=front-left,front-right
pactl load-module module-combine-sink sink_name=surround sink_properties=device.description="Bluetooth surround" slaves=fl,fr,rl,rr channels=4 channel_map=front-left,front-right,rear-left,rear-right
```

The first four lines downmix each speaker to a mono sink. Be sure to replace `bluez_sink.*.a2dp_sink` with the names listed by `pactl list short sinks`. The last line then combines them as a single 4 channel sink. Write this configuration to a file and `chmod +x` the file. Because the Bluetooth devices don't exist during PulseAudio initialization, this script needs to be ran after all pairing is completed rather than in `/etc/pulse/default.pa`. 

## Test channels
Download [a test audio file](https://ia800406.us.archive.org/7/items/5.1SurroundSoundTestFilesVariousFormatsAACAC3MP4DTSWAV/5.1%20Surround%20Sound%20AAC%20Test.mp4) and play it in your browser or a media player such as VLC. Set the audio output to the newly created "Bluetooth surround" device. Verify that each channel is working. 

## Refine calibration of positional audio
TODO write script to use laptop microphone to autocalibrate
TODO `pactl set-port-latency-offset`

## Conclusion
I am a bit suprised how well this 'just worked', I was expecting to encounter some low level driver issues. The only real issue I had to deal with was the MAC addresses on the Bluetooth modules. This is not a replacement for an engineered home theater system, but it accomplishes the goal given the constraints. I intend to look into adding a subwoofer channel and possibly use the laptop speakers as a center channel. Additional speakers can be added if a more complex deployment is desired. The next step is to source software that allows dynamically creating a 3D audio environment without having to pull in an entire game engine.
