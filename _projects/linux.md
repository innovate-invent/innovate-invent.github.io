---
title: Custom Linux Distro
author_profile: true
at_url: at://did:plc:gdfkbwgnydyn4xgea7e7e6ht/app.bsky.feed.post/3lnueylfga22w
---

I have been exclusively using Linux for well over 15 years now, bouncing from various popular distros like Ubuntu, Arch,
and Mint. This experience has come to a critical mass in my understanding of the Linux operating system and its
ecosystem. This project is a vehicle to deep dive into the various components, discovering and closing any gaps I may
have in my knowledge on the subject. Through the years I have built up a wishlist of features to help simplify managing
and maintaining my Linux deployments, and intend to realise this list in a novel approach.

While I am confident in my ability to execute this project, I am still learning some of the aspects of the Linux
environment. There are some areas where I don't know what I don't know. I plan to stream the development of this distro
on [Twitch](https://www.twitch.tv/i2labs), [Youtube](https://www.youtube.com/@i2labs),
and [Discord](https://discord.gg/RXczEFRw) so that I can hopefully recruit consultation from the community on things I
may have missed and for feedback on the decisions I am making in real time. The stream will also serve as an educational
resource where the various subsystems of Linux are explained and demonstrated.

[![XKCD #456 It looks like today I will be the person that XKCD was warning your parents about.](https://imgs.xkcd.com/comics/cautionary.png)](https://xkcd.com/456)

This distro will take a different direction from most existing distros. That said, no single feature will be novel and
have existed in some cases for decades. A key objective will be to boot to a GUI login screen as quickly as possible.
The intent is that the time it takes the user to enter their credentials will mask the time it takes concurrent
processes responsible for initialising ancillary resources and services. Another key objective is to make this one of
the easiest distros to install, either from an existing Linux installation or from the Windows environment. The
installation must also co-exist with the other OS installations and make for a seamless user experience when switching
between them.

As for user experience, much of the effort will be put into features that make it easy for a community to support each
other. This means good logging and error reporting, as well as making it easy to communicate the current state of the
system.

Security will be a key objective but will be flexible enough to not compromise usability. Boot chain validation and
process isolation will be the primary mechanisms focused on.

A goal with the project development is to write little to no custom code if possible. It is intended to make good use of
existing solutions, strategically choosing technologies that provide a mature and rich feature set while minimising the
tech burden of maintenance.

# System Requirements

* UEFI compliant firmware
* ACPI system interface
* GPT formatted disk
    * 4GB ESP partition ( or the option to reallocate space for a second 4GB ESP formatted partition)
    * 4GB Swap space allocation (either swap partition or swap file)
* 16GB of RAM
* AMD, Intel, and possibly ARM CPU 64bit
* Modern GPU (integrated or discreet) from Intel, AMD, or NVIDIA

Linux® is the registered trademark of Linus Torvalds in the U.S. and other countries.

---

# Brain Dump

**The following will develop and be refined as the project progresses but is currently just a brain dump of ideas and
resource links.**

## Development breakdown / Stream programme

1. project goals
    1. immutable
    2. easily swappable environments/ separation of concerns
        1. based on containers
        2. package manager agnostic
    3. easiest to install
    4. windows compatibility
    5. easy to provide support
        1. make it as easy as possible for the community to support others
    6. GUI centric, no need for shell to do everything
    7. speed to login prompt/usable desktop
    8. separate releases with major graphics cards drivers
    9. security without compromising functionality
    10. auditability
        1. [https://en.wikipedia.org/wiki/Runtime\_system](https://en.wikipedia.org/wiki/Runtime_system)
        2. [https://en.wikipedia.org/wiki/Crt0](https://en.wikipedia.org/wiki/Crt0)
        3. [https://en.wikipedia.org/wiki/Runtime\_library](https://en.wikipedia.org/wiki/Runtime_library)
2. local build of kernel in arch linux container
    1. mention bootstrap issue
        1. [originally compiled on minux](https://en.wikipedia.org/wiki/Minix#Early_influence)
    2.
3. qemu kvm auto-run
4. kernel build parameters
5. busybox build in arch linux container
6. musl vs glibc vs ..
7. kernel modules
8. userspace [https://en.wikipedia.org/wiki/Linux\#Design](https://en.wikipedia.org/wiki/Linux#Design)
9. sysfs, efivarfs, procfs, configfs, binfmt\_misc, securityfs
10. systemd build in arch linux container
11. udev startup & "/dev" devtmpfs
12. [wayland](#bookmark=id.b1f32p7ymp5n)
13. networking
14. bluetooth
15. uefi boot chain, secure boot, tpm
    1. [https://en.wikipedia.org/wiki/UEFI](https://en.wikipedia.org/wiki/UEFI)
    2. [https://www.tianocore.org/](https://www.tianocore.org/)
16. qemu uefi config
17. build system boiler on GH actions
18.

## Prior work

The distro will ship as a [Unified Kernel Image](https://wiki.archlinux.org/title/Unified_kernel_image). At a distance
this may look like a modernised [TinyCore Linux](http://tinycorelinux.net/)
or [Damn Small Linux](https://en.wikipedia.org/wiki/Damn_Small_Linux) but those focus on providing a CLI environment.

[https://en.wikipedia.org/wiki/List\_of\_Linux\_distributions\_that\_run\_from\_RAM](https://en.wikipedia.org/wiki/List_of_Linux_distributions_that_run_from_RAM)   
[https://www.linuxboot.org/](https://www.linuxboot.org/)
https://en.wikipedia.org/wiki/GoboLinux
https://www.linuxfromscratch.org/lfs/view/stable/index.html
https://en.wikipedia.org/wiki/Qubes_OS
https://docs.bazzite.gg/

---

## Reference

[The Linux Kernel Documentation](https://www.kernel.org/doc/html/latest/index.html)
[Linux Kernel 2.4 Internals](https://tldp.org/LDP/lki/index.html)   
[https://makelinux.github.io/kernel/map/](https://makelinux.github.io/kernel/map/)   
[https://makelinux.github.io/kernel/diagram/](https://makelinux.github.io/kernel/diagram/)   
[POSIX 2017](https://pubs.opengroup.org/onlinepubs/9699919799/mindex.html)
[POSIX 2024](https://pubs.opengroup.org/onlinepubs/9799919799/)
[https://www.kernelconfig.io/index.html](https://www.kernelconfig.io/index.html)

* root is ro initramfs
    * /etc is rw but in ram
    * [https://unix.stackexchange.com/questions/77485/can-initramfs-be-paged-out-to-swap-disk](https://unix.stackexchange.com/questions/77485/can-initramfs-be-paged-out-to-swap-disk)
* systemd
    * [https://systemd.io/](https://systemd.io/)
    * https://github.com/systemd/systemd
    * [https://www.freedesktop.org/software/systemd/man/latest/index.html](https://www.freedesktop.org/software/systemd/man/latest/index.html)
    * systemd-init
        * [https://www.freedesktop.org/software/systemd/man/latest/init.html\#](https://www.freedesktop.org/software/systemd/man/latest/init.html#)
        * [https://systemd.io/INITRD\_INTERFACE/](https://systemd.io/INITRD_INTERFACE/)
        * [https://www.freedesktop.org/wiki/Software/systemd/APIFileSystems/](https://www.freedesktop.org/wiki/Software/systemd/APIFileSystems/)
        *
    * systemd efi (systemd-boot based on `gnu-efi`)
        * [https://www.kernel.org/doc/html/v4.14/admin-guide/kernel-parameters.html](https://www.kernel.org/doc/html/v4.14/admin-guide/kernel-parameters.html)
        * [https://www.freedesktop.org/software/systemd/man/latest/sd-stub.html\#](https://www.freedesktop.org/software/systemd/man/latest/sd-stub.html#)
        * [https://wiki.archlinux.org/title/Unified\_Extensible\_Firmware\_Interface\#UEFI\_drivers](https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface#UEFI_drivers)
    * systemd mount instead of fstab
        * [https://wiki.archlinux.org/title/Systemd\#GPT\_partition\_automounting](https://wiki.archlinux.org/title/Systemd#GPT_partition_automounting)
        * [https://uapi-group.org/specifications/specs/discoverable\_partitions\_specification/](https://uapi-group.org/specifications/specs/discoverable_partitions_specification/)
        * https://www.freedesktop.org/wiki/Software/udisks/
    * udev
        * [https://en.wikipedia.org/wiki/Udev](https://en.wikipedia.org/wiki/Udev)
        * [https://www.freedesktop.org/software/systemd/man/latest/systemd-udevd.html\#](https://www.freedesktop.org/software/systemd/man/latest/systemd-udevd.html#)
        * automatically map touch screen to display? xinput map-to-output 'ILITEK ILITEK-TP' 'DP-1-0'
    * systemd-logind
        * [https://manpages.ubuntu.com/manpages/xenial/en/man8/pam\_systemd.8.html](https://manpages.ubuntu.com/manpages/xenial/en/man8/pam_systemd.8.html)
        * https://wiki.archlinux.org/title/PAM
        * [https://www.freedesktop.org/software/systemd/man/latest/systemd-logind.service.html\#](https://www.freedesktop.org/software/systemd/man/latest/systemd-logind.service.html#)
        * Build in network auth for the login screen
          * LDAP/Kerberos/NIS/ActiveDirectory
          * https://sssd.io/
    * systemd-journald
        * ALL logs are redirected to journald
        * look into sharding journal with separate log rotation
        * GUI
* compositor \+ Window Manager \+ Desktop Environment
    * [https://www.reddit.com/r/linux4noobs/comments/ksw60b/could\_someone\_explain\_desktop\_environment\_versus/](https://www.reddit.com/r/linux4noobs/comments/ksw60b/could_someone_explain_desktop_environment_versus/)
    * wayland
        * [https://www.reddit.com/r/linuxquestions/comments/1089ctd/so\_what\_exactly\_is\_wayland/](https://www.reddit.com/r/linuxquestions/comments/1089ctd/so_what_exactly_is_wayland/)
        * [https://en.wikipedia.org/wiki/Wayland\_(protocol)](https://en.wikipedia.org/wiki/Wayland_\(protocol\))
        * [https://wiki.archlinux.org/title/Kernel\_mode\_setting](https://wiki.archlinux.org/title/Kernel_mode_setting)
        * [https://wiki.archlinux.org/title/Wayland](https://wiki.archlinux.org/title/Wayland)
        * [https://wiki.archlinux.org/title/GNOME](https://wiki.archlinux.org/title/GNOME)
        * [https://en.wikipedia.org/wiki/Cinnamon\_(desktop\_environment)](https://en.wikipedia.org/wiki/Cinnamon_\(desktop_environment\))
        * [https://projects.linuxmint.com/cinnamon/](https://projects.linuxmint.com/cinnamon/)
        * [https://trello.com/b/HHs01Pab/cinnamon-wayland](https://trello.com/b/HHs01Pab/cinnamon-wayland)
        * https://wayland-book.com/introduction.html
    * KDE
        * Plasma login
        * Plasma login manager
    * https://dri.freedesktop.org/wiki/DRM/
    * https://www.kernel.org/doc/html/latest/gpu/drm-kms.html
    * https://www.kernel.org/doc/html/v5.15/fb/framebuffer.html
* targeting new laptops
* mouse support in tty
    * [https://wiki.archlinux.org/title/General\_purpose\_mouse](https://wiki.archlinux.org/title/General_purpose_mouse)
    * [https://salsa.debian.org/consolation-team/consolation](https://salsa.debian.org/consolation-team/consolation)
    * [https://github.com/browsh-org/browsh?tab=readme-ov-file](https://github.com/browsh-org/browsh?tab=readme-ov-file)
    * [https://netbsd-help.netbsd.narkive.com/LqCFfd3R/how-do-i-add-mouse-support-to-lynx](https://netbsd-help.netbsd.narkive.com/LqCFfd3R/how-do-i-add-mouse-support-to-lynx)
    *
* separate releases for nvidia and amd
    * [https://download.nvidia.com/XFree86/Linux-x86\_64/396.51/README/installedcomponents.html](https://download.nvidia.com/XFree86/Linux-x86_64/396.51/README/installedcomponents.html)
* ~~initramfs derived from container layers~~
    * system to add signed layers at boot via kernel param
    * flatpack? ostree?
* custom kernel build, statically linked modules
    * [https://github.com/NVIDIA/open-gpu-kernel-modules](https://github.com/NVIDIA/open-gpu-kernel-modules)
    * [https://wiki.archlinux.org/title/AMDGPU](https://wiki.archlinux.org/title/AMDGPU)
    * static ext4, video, encryption, md raid?
    * dynamic network, etc
    * [https://en.wikipedia.org/wiki/Menuconfig](https://en.wikipedia.org/wiki/Menuconfig)
    * [https://www.kernel.org/doc/html/v6.8/process/changes.html](https://www.kernel.org/doc/html/v6.8/process/changes.html)
    * [https://hub.docker.com/\_/archlinux](https://hub.docker.com/_/archlinux)
    * CONFIG\_DEVTMPFS=n
        * [https://www.kernelconfig.io/config\_devtmpfs](https://www.kernelconfig.io/config_devtmpfs)
        * [https://www.kernelconfig.io/CONFIG\_DEVTMPFS\_MOUNT](https://www.kernelconfig.io/CONFIG_DEVTMPFS_MOUNT)
    * https://www.kernel.org/doc/html/latest/kbuild/kconfig.html
    * https://www.kernel.org/doc/html/latest/kbuild/reproducible-builds.html
* secureboot and tpm boot chain
    * [https://git.kernel.org/pub/scm/linux/kernel/git/jejb/sbsigntools.git/](https://git.kernel.org/pub/scm/linux/kernel/git/jejb/sbsigntools.git/)
    * [https://en.wikipedia.org/wiki/UEFI\#UEFI\_booting](https://en.wikipedia.org/wiki/UEFI#UEFI_booting)
    * [https://man7.org/linux/man-pages/man1/objcopy.1.html](https://man7.org/linux/man-pages/man1/objcopy.1.html)
    * [https://man7.org/linux/man-pages/man1/objdump.1.html](https://man7.org/linux/man-pages/man1/objdump.1.html)
    * [https://wiki.archlinux.org/title/Unified\_Extensible\_Firmware\_Interface/Secure\_Boot\#Using\_your\_own\_keys](https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface/Secure_Boot#Using_your_own_keys)
    * [https://x86sec.com/posts/2022/09/26/uefi-oprom-bootkit/](https://x86sec.com/posts/2022/09/26/uefi-oprom-bootkit/)
    * [https://en.m.wikipedia.org/wiki/Option\_ROM](https://en.m.wikipedia.org/wiki/Option_ROM)
    * [https://uapi-group.org/specifications/specs/linux\_tpm\_pcr\_registry/](https://uapi-group.org/specifications/specs/linux_tpm_pcr_registry/)
    * [https://archiv.infsec.ethz.ch/education/projects/archive/TPMEmulatorReport.pdf](https://archiv.infsec.ethz.ch/education/projects/archive/TPMEmulatorReport.pdf)
    * [https://github.com/PeterHuewe/tpm-emulator](https://github.com/PeterHuewe/tpm-emulator)
    * [https://github.com/google/pawn](https://github.com/google/pawn)
    *
* fwupd
    * [https://fwupd.org/](https://fwupd.org/)
    * [https://github.com/fwupd/fwupd](https://github.com/fwupd/fwupd)
    * distribute uki updates via fwupd?
* efi boot only
    * [https://www.extremetech.com/computing/96985-demystifying-uefi-the-long-overdue-bios-replacement](https://www.extremetech.com/computing/96985-demystifying-uefi-the-long-overdue-bios-replacement)
    * https://unix.stackexchange.com/questions/152144/how-to-write-edit-update-the-osindications-efi-variable-from-command-line
    * https://uefi.org/specs/UEFI/2.10/08_Services_Runtime_Services.html#getvariable
    * https://en.wikipedia.org/wiki/Comparison_of_bootloaders
      * u-boot vs tianocore/coreboot
* disks
  * change logical block size to match physical to avoid emulation
  * smart data monitoring
  * second partition containing rw mounts
      * /usr (might want to exclude given flatpack)
      * /home
      * /var?
      * [https://linux.die.net/man/7/hier](https://linux.die.net/man/7/hier)
      *
      tmpfs [https://serverfault.com/questions/590124/performance-difference-between-ramfs-and-tmpfs](https://serverfault.com/questions/590124/performance-difference-between-ramfs-and-tmpfs)
      * [https://github.com/torvalds/linux/commit/d29216842a85](https://github.com/torvalds/linux/commit/d29216842a85)
* swapfile by default /var/swapfile
* network
    * nftables only?
    * [netplan?](https://netplan.io/)
    * https://help.ubuntu.com/community/NetworkManager
    * https://www.freedesktop.org/software/systemd/man/latest/systemd-networkd.html#
    * [https://en.wikipedia.org/wiki/Netfilter](https://en.wikipedia.org/wiki/Netfilter)
    * https://www.slideshare.net/slideshow/the-linux-networking-architecture/45348971
    * https://manpages.debian.org/unstable/networkd-dispatcher/networkd-dispatcher.8.en.html
    * sr-iov
    * [NetLabel](https://docs.kernel.org/netlabel/introduction.html)
* good error reporting
    * [https://www.kernel.org/doc/Documentation/kdump/kdump.txt](https://www.kernel.org/doc/Documentation/kdump/kdump.txt)
    * journald reports
    * [https://www.kernel.org/doc/Documentation/admin-guide/dynamic-debug-howto.rst](https://www.kernel.org/doc/Documentation/admin-guide/dynamic-debug-howto.rst)
    * debug output, shelless tty
    * [https://wiki.ubuntu.com/FirmwareTestSuite](https://wiki.ubuntu.com/FirmwareTestSuite)
    * [https://uefi.org/sites/default/files/resources/fwts\_uefi\_0920\_2013.pdf](https://uefi.org/sites/default/files/resources/fwts_uefi_0920_2013.pdf)
    * [https://systemd.io/CATALOG/](https://systemd.io/CATALOG/)
    * [https://cgit.freedesktop.org/systemd/systemd/tree/src/systemd/sd-journal.h](https://cgit.freedesktop.org/systemd/systemd/tree/src/systemd/sd-journal.h)
    * [https://www.freedesktop.org/software/systemd/man/latest/sd-journal.html](https://www.freedesktop.org/software/systemd/man/latest/sd-journal.html)
    * DRM panic / DRM Boot logger
    * https://www.ais.com/understanding-pstore-linux-kernel-persistent-storage-file-system/
* automated updates
* nothing but binaries and config in initramfs
    * [https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/about/](https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/about/)
    *
* disk encryption by default
    * [https://www.man7.org/linux/man-pages/man1/keyctl.1.html](https://www.man7.org/linux/man-pages/man1/keyctl.1.html)
    * [https://manpages.ubuntu.com/manpages/trusty/man5/crypttab.5.html](https://manpages.ubuntu.com/manpages/trusty/man5/crypttab.5.html)
    * [https://wiki.archlinux.org/title/Systemd-homed](https://wiki.archlinux.org/title/Systemd-homed)
    * [https://gitlab.com/cryptsetup/cryptsetup/](https://gitlab.com/cryptsetup/cryptsetup/)
* damn good tab completion
* musl based binaries
    * [https://dmerej.info/blog/post/symlinks-and-so-files-on-linux/](https://dmerej.info/blog/post/symlinks-and-so-files-on-linux/)
    * [http://www.etalabs.net/compare\_libcs.html](http://www.etalabs.net/compare_libcs.html)
    * [https://www.gnu.org/savannah-checkouts/gnu/libc/index.html](https://www.gnu.org/savannah-checkouts/gnu/libc/index.html)
    * [https://www.gnu.org/software/libc/manual/html\_mono/libc.html\#Installation](https://www.gnu.org/software/libc/manual/html_mono/libc.html#Installation)
    * [https://sourceware.org/glibc/](https://sourceware.org/glibc/)
    * [https://sourceware.org/git/?p=glibc.git;a=blob;f=elf/dl-cache.c;hb=96429bcc91a14f71b177ddc5e716de3069060f2c\#l395](https://sourceware.org/git/?p=glibc.git;a=blob;f=elf/dl-cache.c;hb=96429bcc91a14f71b177ddc5e716de3069060f2c#l395)
    * https://www.adelielinux.org/about/
    * https://catfox.life/2024/09/05/porting-systemd-to-musl-libc-powered-linux/
    * https://github.com/systemd/systemd/issues/10130
    * https://postmarketos.org/blog/2024/05/26/the-road-to-systemd/
    * https://mastodon.social/@pid_eins/113085993096695914
    * https://mastodon.social/@awilfox@mst3k.interlinked.me/113084014192941053
* all binaries compiled from source
    * git submodules of each project
        * coreutils
        * [https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git](https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git) [https://www.mankier.com/package/util-linux](https://www.mankier.com/package/util-linux)
        * kernel
        * gnu awk
        * [https://git.kernel.org/pub/scm/](https://git.kernel.org/pub/scm/)
        * efibootmgr
        * pulseaudio
        * blueman
        * [https://github.com/flatpak/flatpak/blob/main/CONTRIBUTING.md](https://github.com/flatpak/flatpak/blob/main/CONTRIBUTING.md)
        * [https://git.kernel.org/pub/scm/network/iproute2/iproute2.git](https://git.kernel.org/pub/scm/network/iproute2/iproute2.git)
        * ntp
        * glibc/musl
    * build dependencies are excluded
    * [https://stackoverflow.com/questions/46646625/in-what-library-on-linux-are-the-system-calls-and-how-is-this-library-linked-to](https://stackoverflow.com/questions/46646625/in-what-library-on-linux-are-the-system-calls-and-how-is-this-library-linked-to)
    * kernel provided shared libraries, ex: linux-vdso.so
    * [https://docs.github.com/en/actions/security-for-github-actions/using-artifact-attestations/using-artifact-attestations-to-establish-provenance-for-builds\#verifying-artifact-attestations-with-the-github-cli](https://docs.github.com/en/actions/security-for-github-actions/using-artifact-attestations/using-artifact-attestations-to-establish-provenance-for-builds#verifying-artifact-attestations-with-the-github-cli)
    * https://wiki.archlinux.org/title/Dynamic_Kernel_Module_Support
    * auditability
      * https://www.youtube.com/watch?v=Fu3laL5VYdM
      * [https://en.wikipedia.org/wiki/Runtime\_system](https://en.wikipedia.org/wiki/Runtime_system)
      * [https://en.wikipedia.org/wiki/Crt0](https://en.wikipedia.org/wiki/Crt0)
      * [https://en.wikipedia.org/wiki/Runtime\_library](https://en.wikipedia.org/wiki/Runtime_library)
* ~~windows installer powershell script~~ install efi via wsl
    * [https://linuxbsdos.com/2024/09/29/2-simple-ways-to-access-the-efi-system-partition-on-windows-11/](https://linuxbsdos.com/2024/09/29/2-simple-ways-to-access-the-efi-system-partition-on-windows-11/)
    * [https://oofhours.com/2022/06/29/geeking-out-with-the-uefi-boot-manager/](https://oofhours.com/2022/06/29/geeking-out-with-the-uefi-boot-manager/)
    * [https://www.freedesktop.org/software/systemd/man/latest/sd-boot.html\#](https://www.freedesktop.org/software/systemd/man/latest/sd-boot.html#)
    * use `Get-WmiObject win32_bios` to query the bios version and look up the uefi boot menu button for
      it [https://www.disk-image.com/faq-bootmenu.htm](https://www.disk-image.com/faq-bootmenu.htm)
    * [https://superuser.com/questions/376533/how-to-access-a-bitlocker-encrypted-drive-in-linux](https://superuser.com/questions/376533/how-to-access-a-bitlocker-encrypted-drive-in-linux)
    * [https://security.stackexchange.com/questions/181539/how-are-bitlocker-fde-keys-stored-in-the-tpm](https://security.stackexchange.com/questions/181539/how-are-bitlocker-fde-keys-stored-in-the-tpm)
    * [https://learn.microsoft.com/en-us/powershell/module/secureboot/set-securebootuefi?view=windowsserver2022-ps](https://learn.microsoft.com/en-us/powershell/module/secureboot/set-securebootuefi?view=windowsserver2022-ps)
    * [https://serverfault.com/questions/11879/gaining-administrator-privileges-in-powershell](https://serverfault.com/questions/11879/gaining-administrator-privileges-in-powershell)
    * [https://stackoverflow.com/a/68530475](https://stackoverflow.com/a/68530475)
    * [https://stackoverflow.com/questions/44919190/windows-equivalent-to-efibootmgr](https://stackoverflow.com/questions/44919190/windows-equivalent-to-efibootmgr)
    * windows WSL image release
        * [https://learn.microsoft.com/en-us/windows/wsl/build-custom-distro](https://learn.microsoft.com/en-us/windows/wsl/build-custom-distro)
        * https://learn.microsoft.com/en-us/windows/wsl/tutorials/gui-apps
    * [https://unix.stackexchange.com/a/501526](https://unix.stackexchange.com/a/501526)
    * check for bitlocker and ensure the recovery key is available
    * [https://www.microsoft.com/en-us/evalcenter/evaluate-windows-11-enterprise](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-11-enterprise)
* dbus
    * [https://en.wikipedia.org/wiki/D-Bus](https://en.wikipedia.org/wiki/D-Bus)
    * [https://en.wikipedia.org/wiki/D-Bus\#Implementations](https://en.wikipedia.org/wiki/D-Bus#Implementations)
    * [https://tldp.org/LDP/tlk/ipc/ipc.html](https://tldp.org/LDP/tlk/ipc/ipc.html)
    * [https://www.freedesktop.org/wiki/Software/systemd/kdbus/](https://www.freedesktop.org/wiki/Software/systemd/kdbus/)
* acpi
    * [acpi vs device tree](https://www.youtube.com/watch?v=UIXtM1IlnG4)
    * [https://www.intel.com/content/www/us/en/developer/topic-technology/open/acpica/overview.html](https://www.intel.com/content/www/us/en/developer/topic-technology/open/acpica/overview.html)
    * [https://www.kernel.org/doc/Documentation/acpi/namespace.txt](https://www.kernel.org/doc/Documentation/acpi/namespace.txt)
    * [https://firmwaresecurity.com/tag/acpidbg/](https://firmwaresecurity.com/tag/acpidbg/)
    * [https://www.slideshare.net/slideshow/acpi-debugging-from-linux-kernel/179373596](https://www.slideshare.net/slideshow/acpi-debugging-from-linux-kernel/179373596)
    * [https://cdrdv2.intel.com/v1/dl/getContent/772726](https://cdrdv2.intel.com/v1/dl/getContent/772726)
    * [https://wiki.osdev.org/ACPI](https://wiki.osdev.org/ACPI)
    * [https://uefi.org/htmlspecs/ACPI\_Spec\_6\_4\_html/07\_Power\_and\_Performance\_Mgmt/oem-supplied-system-level-control-methods.html](https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/oem-supplied-system-level-control-methods.html)
    * [https://maplecircuit.dev/std/acpi.html](https://maplecircuit.dev/std/acpi.html)
    * https://docs.kernel.org/admin-guide/acpi/initrd_table_override.html
    * https://wiki.archlinux.org/title/DSDT
    * https://docs.kernel.org/admin-guide/acpi/ssdt-overlays.html#loading-acpi-ssdts-from-configfs
    * fix the damn hot backpack issue
        * [https://www.spinics.net/lists/linux-usb/msg53661.html](https://www.spinics.net/lists/linux-usb/msg53661.html)
        * [https://github.com/torvalds/linux/blob/e70140ba0d2b1a30467d4af6bcfe761327b9ec95/drivers/platform/x86/asus-wmi.c\#L1433-L1458](https://github.com/torvalds/linux/blob/e70140ba0d2b1a30467d4af6bcfe761327b9ec95/drivers/platform/x86/asus-wmi.c#L1433-L1458)
        * [https://github.com/torvalds/linux/blob/e70140ba0d2b1a30467d4af6bcfe761327b9ec95/drivers/acpi/battery.c\#L738](https://github.com/torvalds/linux/blob/e70140ba0d2b1a30467d4af6bcfe761327b9ec95/drivers/acpi/battery.c#L738)
        * [https://uefi.org/htmlspecs/ACPI\_Spec\_6\_4\_html/07\_Power\_and\_Performance\_Mgmt/oem-supplied-system-level-control-methods.html\#sws-system-wake-source](https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/oem-supplied-system-level-control-methods.html#sws-system-wake-source)
        * [https://mjmwired.net/kernel/Documentation/acpi/debug.txt\#144](https://mjmwired.net/kernel/Documentation/acpi/debug.txt#144)
        * [https://unix.stackexchange.com/questions/244767/sysfs-alternative-to-proc-acpi-button-lid-lid-state](https://unix.stackexchange.com/questions/244767/sysfs-alternative-to-proc-acpi-button-lid-lid-state)
        * [https://wiki.archlinux.org/title/Power\_management/Wakeup\_triggers](https://wiki.archlinux.org/title/Power_management/Wakeup_triggers)
        * [https://man.archlinux.org/man/systemd-sleep.8](https://man.archlinux.org/man/systemd-sleep.8)
        *
    * resume from suspend
        * [https://www.kernel.org/doc/html/v4.14/admin-guide/kernel-parameters.html\#no\_console\_suspend](https://www.kernel.org/doc/html/v4.14/admin-guide/kernel-parameters.html#no_console_suspend)
        * [https://unix.stackexchange.com/a/403171](https://unix.stackexchange.com/a/403171)
        * [https://docs.kernel.org/admin-guide/pm/sleep-states.html](https://docs.kernel.org/admin-guide/pm/sleep-states.html)
    * UPS monitor/events
* dhcp
    * [https://www.zscaler.com/blogs/security-research/cve-2024-3661-k-tunnelvision-exposes-vpn-bypass-vulnerability](https://www.zscaler.com/blogs/security-research/cve-2024-3661-k-tunnelvision-exposes-vpn-bypass-vulnerability)
    * [https://www.isc.org/dhcp](https://www.isc.org/dhcp)
    * [https://wiki.archlinux.org/title/Dhcpcd](https://wiki.archlinux.org/title/Dhcpcd)
    * systemd-networkd has a dhcp client
      * https://github.com/systemd/systemd/issues/27699
      * https://github.com/systemd/systemd/issues/16785
* first-boot config setup optimisations
    *
    lpj [https://www.kernel.org/doc/html/v4.14/admin-guide/kernel-parameters.html](https://www.kernel.org/doc/html/v4.14/admin-guide/kernel-parameters.html)
    loops\_per\_jiffy
* microcode loading
    * [https://www.kernel.org/doc/html/v5.4/x86/microcode.html\#builtin-microcode](https://www.kernel.org/doc/html/v5.4/x86/microcode.html#builtin-microcode)
    * [https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases](https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases)
    * [https://github.com/platomav/CPUMicrocodes](https://github.com/platomav/CPUMicrocodes)
* everything in containers
    * flatpack
        * [https://docs.flatpak.org/en/latest/introduction.html](https://docs.flatpak.org/en/latest/introduction.html)
        * [https://ostreedev.github.io/ostree/introduction/](https://ostreedev.github.io/ostree/introduction/)
        * [https://blogs.gnome.org/alexl/2017/10/02/on-application-sizes-and-bloat-in-flatpak/](https://blogs.gnome.org/alexl/2017/10/02/on-application-sizes-and-bloat-in-flatpak/)
        * [https://flathub.org/apps/io.gitlab.gwendalj.package-transporter](https://flathub.org/apps/io.gitlab.gwendalj.package-transporter)
        * [https://gitlab.gnome.org/GNOME/gnome-software](https://gitlab.gnome.org/GNOME/gnome-software)
    * overlayfs
        * https://www.freedesktop.org/software/systemd/man/latest/systemd-sysext.html
        * https://github.com/dimkr/overheadfs
    * runtime
        * [https://github.com/containers/crun/?tab=readme-ov-file](https://github.com/containers/crun/?tab=readme-ov-file)
        * [https://github.com/opencontainers/runc](https://github.com/opencontainers/runc)
        * [https://docs.podman.io/en/v4.4/markdown/podman.1.html](https://docs.podman.io/en/v4.4/markdown/podman.1.html)
        * [https://github.com/opencontainers/runtime-spec/blob/main/runtime.md\#lifecycle](https://github.com/opencontainers/runtime-spec/blob/main/runtime.md#lifecycle)
    * portals
        * [https://wiki.archlinux.org/title/XDG\_Desktop\_Portal](https://wiki.archlinux.org/title/XDG_Desktop_Portal)
        * [https://xkcd.com/927/](https://xkcd.com/927/)
        * [https://www.bassi.io/articles/2023/05/29/configuring-portals/](https://www.bassi.io/articles/2023/05/29/configuring-portals/)
    * linker
        * https://musl.libc.org/
        * [https://www.man7.org/linux/man-pages/man8/ld.so.8.html](https://www.man7.org/linux/man-pages/man8/ld.so.8.html)
        * [https://linux.die.net/man/1/chrpath](https://linux.die.net/man/1/chrpath)
        * add --cache-path to ld.so combined with custom binfmt_misc and magic?
        * https://lwn.net/Articles/631631/
        * add a section to ld.so with the cache location?
        * custom fs that adapts paths based on pid and argc[0]?
        * without breaking hardcoded [dlopen](https://www.man7.org/linux/man-pages/man3/dlopen.3p.html) paths
    * dedup
        * https://github.com/BLAKE3-team/BLAKE3
        * https://www.man7.org/linux/man-pages/man1/chattr.1.html immutable files
        * https://github.com/mhx/dwarfs?tab=readme-ov-file
    * ipc
        * https://www.kernel.org/doc/html/next/userspace-api/netlink/intro.html
        * https://www.man7.org/linux/man-pages/man2/socket.2.html
    * podman
      * https://github.com/rootless-containers/slirp4netns
      * https://issues.redhat.com/browse/RUN-1953
      * https://passt.top/passt/about/
      * https://github.com/containers/netavark
      * [mount remote tar.gz for update optimisation](https://github.com/mxmlnkn/ratarmount)
      * https://github.com/regclient/regclient
    * [AppStream Metadata](https://www.freedesktop.org/software/appstream/docs/chap-Metadata.html#tag-provides)
    * https://distrobox.it/
    * [Container community](https://www.linuxserver.io/)
    * user vs global installs / namespaces
* network display / screen casting support
    * [https://community.linuxmint.com/software/view/org.gnome.NetworkDisplays](https://community.linuxmint.com/software/view/org.gnome.NetworkDisplays)
    * [https://hensm.github.io/fx\_cast/](https://hensm.github.io/fx_cast/)
* root certs
    * [https://documentation.ubuntu.com/server/explanation/security/certificates/](https://documentation.ubuntu.com/server/explanation/security/certificates/)
    * [https://pkic.org/ltl/](https://pkic.org/ltl/)
    * [https://curl.se/docs/caextract.html](https://curl.se/docs/caextract.html)
    * [https://packages.debian.org/sid/dns-root-data](https://packages.debian.org/sid/dns-root-data)
    *
* time
    * timezones
* printers
    * cups
    * network print
* audio
    * [https://wiki.archlinux.org/title/Advanced\_Linux\_Sound\_Architecture\#ALSA\_firmware](https://wiki.archlinux.org/title/Advanced_Linux_Sound_Architecture#ALSA_firmware)
    * [https://wiki.archlinux.org/title/PipeWire](https://wiki.archlinux.org/title/PipeWire)
    * [https://gitlab.freedesktop.org/pipewire/pipewire/-/wikis/home](https://gitlab.freedesktop.org/pipewire/pipewire/-/wikis/home)
    * https://github.com/futpib/pagraphcontrol
* bluetooth
* modem
  * https://www.freedesktop.org/wiki/Software/ModemManager/
* wifi
    * [https://www.apt-browse.org/browse/ubuntu/precise/main/all/wireless-regdb/2011.04.28-1ubuntu3/debian/control/](https://www.apt-browse.org/browse/ubuntu/precise/main/all/wireless-regdb/2011.04.28-1ubuntu3/debian/control/)
    * [https://wiki.archlinux.org/title/Wpa\_supplicant](https://wiki.archlinux.org/title/Wpa_supplicant)
    * https://wireless.docs.kernel.org/en/latest/en/users/drivers.html
    * https://w1.fi/wpa_supplicant/
* dns
    * detect captive portals with DoH/DoT active
    * block standard DNS ports to prevent leaks
    * mDNS
    * dns in a container should route through host dns config? (mdns config)
        * resolved has DBUS and socket support
    * [https://linux.die.net/man/8/nscd](https://linux.die.net/man/8/nscd)
    * https://github.com/systemd/systemd/pull/31537
* firmware
    * compress better than half a gig?
    * [https://github.com/timotheuslin/EFI-BIOS-Resources](https://github.com/timotheuslin/EFI-BIOS-Resources)
    *
* wine
    * [https://en.wikipedia.org/wiki/Binfmt\_misc](https://en.wikipedia.org/wiki/Binfmt_misc)
    * [https://docs.kernel.org/admin-guide/binfmt-misc.html](https://docs.kernel.org/admin-guide/binfmt-misc.html)
    * [protonup-qt](https://davidotek.github.io/protonup-qt/)
* android?
  * https://www.qemu.org/docs/master/user/main.html
* rootless?
    * libcap
    * [https://sites.google.com/site/fullycapable/](https://sites.google.com/site/fullycapable/)
    * [https://www.linuxjournal.com/magazine/making-root-unprivileged](https://www.linuxjournal.com/magazine/making-root-unprivileged)
* internationalization/accessibility
    * brail reader
    * tts
* memory config
    * hugepages
* battery/power management
    * power profiles
* devtmpfs vs udev
    * [https://docs.oracle.com/en/operating-systems/oracle-linux/8/udev/OL8-UDEV.pdf](https://docs.oracle.com/en/operating-systems/oracle-linux/8/udev/OL8-UDEV.pdf)
    * [https://linux.die.net/man/1/mknod](https://linux.die.net/man/1/mknod)
    * [https://linux.die.net/man/8/makedev](https://linux.die.net/man/8/makedev)
    * [https://www.man7.org/linux/man-pages/man3/makedev.3.html](https://www.man7.org/linux/man-pages/man3/makedev.3.html)
    * [https://serverfault.com/questions/892134/why-is-there-both-character-device-and-block-device-for-nvme](https://serverfault.com/questions/892134/why-is-there-both-character-device-and-block-device-for-nvme)
* sysfs only?
    * [https://www.kernel.org/doc/html/latest/admin-guide/abi.html](https://www.kernel.org/doc/html/latest/admin-guide/abi.html)
    * https://www.kernel.org/doc/html/latest/admin-guide/sysfs-rules.html
    * https://www.kernel.org/doc/html/latest/admin-guide/sysctl/index.html
    * https://www.kernel.org/doc/html/latest/admin-guide/devices.html
* fonts?
* selinux?
    * https://wiki.archlinux.org/title/SELinux
    * https://github.com/SELinuxProject/selinux-notebook?tab=readme-ov-file
    * https://github.com/SELinuxProject/selinux-notebook/blob/main/src/core_components.md
    * https://linuxconfig.org/introduction-to-selinux-concepts-and-management
    * https://github.com/SELinuxProject/selinux
    * https://www.kernel.org/doc/html/latest/admin-guide/LSM/index.html
    * https://docs.kernel.org/security/lsm-development.html#c.security_inode_mkdir
    * https://en.wikipedia.org/wiki/Linux_Security_Modules
    * https://www.usenix.org/legacy/event/sec02/full_papers/wright/wright_html/index.html
    * https://events19.linuxfoundation.org/wp-content/uploads/2017/11/Secuity-Modules_Casey-Schaufler.pdf
    * https://github.com/argussecurity/ulsm
    * https://sites.google.com/site/fullycapable/capable-shared-objects?authuser=0
* mime types
  * https://gitlab.freedesktop.org/xdg/desktop-file-utils
  * https://specifications.freedesktop.org/desktop-entry-spec/1.1/
* cpu features?
  * https://github.com/intel/media-driver

standalone server build with no gui? automatically bootstraps containers from a config?

[https://github.com/docker/roadmap/issues/593](https://github.com/docker/roadmap/issues/593)

[https://blog.packagecloud.io/the-definitive-guide-to-linux-system-calls/](https://blog.packagecloud.io/the-definitive-guide-to-linux-system-calls/)   
[https://man7.org/linux/man-pages/man2/syscalls.2.html](https://man7.org/linux/man-pages/man2/syscalls.2.html)   
[https://stackoverflow.com/questions/10321435/is-char-envp-as-a-third-argument-to-main-portable](https://stackoverflow.com/questions/10321435/is-char-envp-as-a-third-argument-to-main-portable)   
[https://en.wikipedia.org/wiki/Netlink](https://en.wikipedia.org/wiki/Netlink)

[https://busybox.net/](https://busybox.net/)   
[https://busybox.net/downloads/BusyBox.html](https://busybox.net/downloads/BusyBox.html)   
[https://github.com/brgl/busybox/blob/master/examples/inittab](https://github.com/brgl/busybox/blob/master/examples/inittab)
https://landley.net/toybox/help.html

[https://www.qemu.org/docs/master/](https://www.qemu.org/docs/master/)  
[https://www.qemu.org/docs/master/system/invocation.html](https://www.qemu.org/docs/master/system/invocation.html)  
[https://www.qemu.org/docs/master/system/qemu-manpage.html](https://www.qemu.org/docs/master/system/qemu-manpage.html)

[https://wiki.gentoo.org/wiki/Integrity\_Measurement\_Architecture](https://wiki.gentoo.org/wiki/Integrity_Measurement_Architecture)   
[https://sourceforge.net/p/linux-ima/wiki/Home/](https://sourceforge.net/p/linux-ima/wiki/Home/)

[https://obsproject.com/forum/resources/background-removal-virtual-green-screen-low-light-enhance.1260/](https://obsproject.com/forum/resources/background-removal-virtual-green-screen-low-light-enhance.1260/)  
[https://obsproject.com/forum/resources/multiple-rtmp-outputs-plugin.964/](https://obsproject.com/forum/resources/multiple-rtmp-outputs-plugin.964/)

[https://droidcam.app/linux/\#av](https://droidcam.app/linux/#av)  
[https://www.sheep.chat/en/features/basic](https://www.sheep.chat/en/features/basic)

flatpak install com.obsproject.Studio.Plugin.BackgroundRemoval  
flatpak install flathub com.obsproject.Studio  
flatpak install flathub com.obsproject.Studio.Plugin.DroidCam  
sudo apt install linux-headers-$(uname \-r) v4l2loopback-dkms  
flatpak override \--user \--device=all com.obsproject.Studio  
[https://ffmpeg.org/ffmpeg-protocols.html\#rtmp](https://ffmpeg.org/ffmpeg-protocols.html#rtmp)  
[https://obsproject.com/forum/resources/multiple-rtmp-outputs-plugin.964/](https://obsproject.com/forum/resources/multiple-rtmp-outputs-plugin.964/)
https://obsproject.com/forum/resources/background-removal-virtual-green-screen-low-light-enhance.1260/

[https://github.com/Kostr/UEFI-Lessons?tab=readme-ov-file](https://github.com/Kostr/UEFI-Lessons?tab=readme-ov-file)  
[https://trustedcomputinggroup.org/resource/tpm-library-specification/](https://trustedcomputinggroup.org/resource/tpm-library-specification/)   
[https://www.qemu.org/docs/master/specs/tpm.html\#tpm-backend-devices](https://www.qemu.org/docs/master/specs/tpm.html#tpm-backend-devices)   
[https://www.qemu.org/docs/master/specs/tpm.html\#the-qemu-tpm-emulator-device](https://www.qemu.org/docs/master/specs/tpm.html#the-qemu-tpm-emulator-device)   
[https://github.com/stefanberger/swtpm/tree/master](https://github.com/stefanberger/swtpm/tree/master)   
[https://github.com/stefanberger/libtpms](https://github.com/stefanberger/libtpms)

https://github.com/Zephkek/Asus-ROG-Aml-Deep-Dive

[https://docs.docker.com/build/building/base-images/\#create-a-base-image](https://docs.docker.com/build/building/base-images/#create-a-base-image)

https://backports.docs.kernel.org/index.html

while [inotifywait](https://linux.die.net/man/1/inotifywait) \-e modify Dockerfile; do ./Dockerfile; done

Debian packages for build dependencies

```bash
apt build-dep linux
apt install libncurses-dev gawk flex bison openssl libssl-dev dkms libelf-dev libudev-dev libpci-dev libiberty-dev autoconf llvm
```

```bash
losetup -Pf disk.img --show
```

Git submodule config
https://www.youtube.com/watch?v=JESI498HSMA

```bash
git config --local push.recurseSubmodules on-demand
git config --local submodule.recurse true
```

Kernel build

```bash
make help
make tinyconfig
make bzImage  # arch/x86/boot/bzImage
make modules
```

show hardware
```bash
sudo lshw -html > Downloads/devices.html
```

[https://stackoverflow.com/questions/30011603/how-to-enable-rust-ownership-paradigm-in-c](https://stackoverflow.com/questions/30011603/how-to-enable-rust-ownership-paradigm-in-c) 




