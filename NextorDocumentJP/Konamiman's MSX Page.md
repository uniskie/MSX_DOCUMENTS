---
title: "Konamiman's MSX Page"
source: "https://www.konamiman.com/msx/msx-e.html#NextorUserManual"
author:
  - "[[Néstor Soriano Vilchez AKA Konamiman]]"
published:
created: 2026-07-27
description: "Software for MSX2 computers, developed by Konamiman"
tags:
  - "clippings"
---
---

*[Copy of **mato34.es**](https://www.konamiman.com/mato34/index-e.html)*

[La página en español está aquí](https://www.konamiman.com/msx/msx-s.html)

[**MSX software repository** in GitHub](http://www.github.com/konamiman/msx)

[**Konamiman's blog**](http://konamiman.blogspot.com/) (in Spanish)

e-mail:

[What's new?](#nuevo)

![MSX Web ring logo](https://www.konamiman.com/msx/img/msxrban_small.jpg) [Join Now](http://i.webring.com/wrman?ring=msxring;sid=7;addsite) | [Ring Hub](http://i.webring.com/t/MSX-Web-Ring) | [Random](http://i.webring.com/go?ring=msxring;sid=7;id=7;random) | [**<< Prev**](http://i.webring.com/go?ring=msxring;sid=7;id=7;prev) | [**Next >>**](http://i.webring.com/go?ring=msxring;sid=7;id=7;next)

Page theme kindly designed by Erich

This page is pesimized for any browser and any screen resolution

---

Welcome, brave visitor. In this page you will find my software productions for MSX computers (well, not all of them, but the ones that are worth using), useful mainly for programmers of such obsolete system. And of course, all for free (freeware, do-whatever-you-want-with-it-ware, etc), since as Linus Torvalds said once:

"Software is like sex: it is much better when it is for free"

So go for it, download everything you want and for any comment, suggestion or complaint write me to the e-mail address that appears at the beginning of the page.

About text files (spanish versions only)

All the text files contained in this page are stored in MSX-DOS format, AKA MS-DOS format or OEM format. Therefore, if you try to open any of these files with Notepad or other similar program and the file is in spanish, you will not be able to correctly see the special characters like "á", "ñ", etc.

Solution: view the text files from your MSX (that's what the files are intended for), or with MS-DOS' EDIT, or use any programa capable of converting from DOS format to ANSI format (the format used by Windows). For this purpose I recommend [EditPad Lite](http://www.editpadlite.com/) ; it is a simple yet powerful text editor, free for non-cummercial use. In the *Convert* menu of this program, the option *OEM -> ANSI* will do the conversion we are interested in.

---

## MSX Software Repository

If you like to read source code (and especially Z80 assembler), please take a look at [my MSX software repository in GitHub](http://www.github.com/konamiman/msx). It contains all the source code files available in this page, plus some not available here (such as the sources for NestorBASIC). All conveniently organized in a Git repository.

Many of the files in the repository have code comments and identifiers in Spanish. Any help to translate them to English will be welcome.

---

## Donate!

Do you like the software available in this page and in the repository? If so, why not donating a few bucks to its author (that is, me)? You can do it easily by using **PayPal** (via the *Donate* buton below), by using **Skrill** (specifying my usual email address as the receiver address), or via **Flattr** or **Patreon**.

Why am I asking for donations?

I develop MSX software for fun. If people uses my software and every now and then someone says something like "Hey I liked that NestorFoobar thing, good work!", I consider myself rewarded enough, and this is not going to change anytime soon.

However, receiving even a small amount of economic support would be a big help for me. You know, I develop in my free time and sometimes my wife sees me and asks *"Why do you continue developing for a completely obsolete system that nobody uses anymore?"*. It would be really great and fulfilling if I could answer **"But look, honey, I am earning money with this!"** instead of nodding in shame. You know what I mean.

Oh, and I would probably use the money to buy shoes for my kids. I don't know what these boys do with the shoes, but they completely rip apart a pair every two or three months. It's scary.

---

## Index

These are the programs you can find in this page:

Besides, the following information is also available:

- [MSX2 Technical Handbook](#msx2th): Official technical reference of the MSX2 standard, manually converted to text files by me.
- [Easymbler](#easymbler): Easy and funny assembler course written by me. **Note: available in spanish only.**
- [InterNestor Suite project](#proyectointernestor): InterNestor Suite was the final project I developped to obtain my degree in telecommunication engineering. Here you can download the project report I delivered to teachers and the presentation I shown the exam day. **Note: available in spanish only.**
- [MSX-UNAPI specification](#unapi): Standard for defining and implementing new APIs (Application Program Interface) for MSX.
- [Obsolete Procedure Call](#opc): A protocol designed for performing remote access to a computer controlled by a Z80 processor.

**Note:** Some of the files that can be downloaded from this page are compressed in LZH format. You can uncompress these files from MSX-DOS by using the PMEXT utility that you can download from [the 'miscellaneous' section](#miscelanea).

[Return to index](#index)

---

## Nextor

**[Nextor project in GitHub](https://github.com/Konamiman/Nextor)**

Nextor is a disk operating system for MSX computers. It is actually an enhanced version of MSX-DOS, with which it is 100% compatible, and it identifies itself as MSX-DOS 2.31 to MSX-DOS aware applications.

Oh noes! Is that a bug?

If you discover a bug in Nextor, [please report it as an issue in GitHub](https://github.com/Konamiman/Nextor/issues) if nobody else has done it yet - and even if the report already exsits, feel free to contribute with additional information, reproduction steps, or whatever you think may be useful to help squashing it.

Are you a developer? Cool! Any help to make Nextor less buggy will be welcome, from hints on what parts of the code may be problematic to full-blown pull requests.

The main features that Nextor adds to MSX-DOS are:

- **Native support for the FAT16 filesystem.** Nextor can handle the FAT16 filesystem without having to install any patch or additional software. This raises the maximum size of usable filesystems from the 32MB supported by FAT12 to 4GB. Also, the system can boot from a FAT16 filesystem.
- **New, fully documented device driver system.** Developers of driver software for massive storage devices no longer need to reverse-engineer the operating system kernel ROM (or to follow the steps of someone that has done it in the past) in order to generate a kernel ROM with the custom driver code embedded on it. Nextor provides an enhanced driver system and the steps needed to integrate it within the kernel ROM are fully documented. Furthermore, Nextor drivers have extra extensibility points (for BASIC "CALL" commands or extended BIOS, for instance).
- **Device and partition to drive mapping management.** When using the device driver system designed for Nextor, it is the operating system itself who manages the logical drive to physical storage device mapping, including the partition selection. Nextor drivers simply enumerate the available devices and provide access to the raw device sectors.
- **Built-in device partitioning tool.** Just go to the BASIC prompt, invoke a CALL FDISK command, and you are ready to create partitions on any device controlled by a Nextor driver.
- **Embedded MSX-DOS 1 kernel.** The Nextor kernel will boot in MSX-DOS 1 mode when the computer has no mapped RAM, when the "1" key is pressed at boot time, or when a MSX-DOS 1 boot sector is detected in the boot device. There is no need to have a MSX-DOS 1 kernel in another slot (for example in a floppy disk driver controller), and you can use partitions with a size of up to 16MB contained on any device controlled by a Nextor driver.
- **Works on MSX1.** Nextor works on all MSX computers, including MSX1. Of course mapped memory is needed for normal operation, but even without it, MSX1 computers can use Nextor in MSX-DOS 1 mode.
- **Support for disk image files.** Starting at version 2.1, Nextor allows to mount disk image files in drive letters, so that its contents can be managed easily. It is also possible to boot in *floppy disk emulation mode*, where disk image files are used as if they were storage devices; this allows to play old disk games that only work in MSX-DOS 1 mode and/or load data by using direct sector access (there is no filesystem in the game disks).

There are other nice features as well, please read the [Nextor user manual](#NextorUserManual) for more details.

**Note:** If you have used FDISK in Nextor 2.0.2 or earlier, or in Nextor 2.1 Alpha 1, please take a look at the [Volume Size Fix Tool](#vsft).

Note for Sunrise IDE (and compatible) owners

As of March 15th 2015 the Sunrise IDE version of all the Nextor kernels published here incorporate a driver made by Piter Punk. This driver is much more stable that the original experimental driver, despite still beign currently a beta version.

The [Sunrise IDE tools](#ide) section contains the tools needed to flash the Nextor kernel ROM in Sunrise IDE and compatible devices.

Note for openMSX users

Starting at version 2.0.1 Nextor works with the openMSX emulator. Previous versions did not work due to a bug in the kernel boot code.

The current stable Nextor version is 2.1.0, available as [a release in GitHub](https://github.com/Konamiman/Nextor/releases/tag/v2.1.0). If you want to give it a try, that's what you''ll need:

- [Nextor Getting Started Guide](https://github.com/Konamiman/Nextor/blob/v2.1/docs/Nextor%202.1%20Getting%20Started%20Guide.md): A step-by-step guide to understand the features that Nextor adds to MSX-DOS, including the steps needed to configure blueMSX in case you want to use Nextor in that emulator.
- [Nextor User Manual](https://github.com/Konamiman/Nextor/blob/v2.1/docs/Nextor%202.1%20User%20Manual.md): The documentation that you need to get started with Nextor.
- The Nextor kernel: A ROM file containing the Nextor kernel with an embedded device driver. There are four flavours to choose:
- [Standalone ROM with ASCII 16 mapper](https://github.com/Konamiman/Nextor/releases/download/v2.1.0/Nextor-2.1.0.StandaloneASCII16.ROM): This version has a dummy driver and controls no devices. It is intended to be burned on a flash ROM cartridge and to be used together with storage devices controlled by a MSX-DOS kernel (such as an IDE or SCSI controller, a multimedia card controller, or a floppy disk controller) placed in another slot. Remember that some of the Nextor features are available are available for Nextor drivers only and therefore will not be usable with this kernel flavour.
- [Standalone ROM with ASCII 8 mapper](https://github.com/Konamiman/Nextor/releases/download/v2.1.0/Nextor-2.1.0.StandaloneASCII8.ROM): Same as above, but with a different ROM mapper type.
- [Sunrise IDE](https://github.com/Konamiman/Nextor/releases/download/v2.1.0/Nextor-2.1.0.SunriseIDE.ROM): This version contains an embedded driver for the Sunrise IDE, as well as the appropriate ROM mapper; it is intended to be burned directly on the Sunrise IDE controller and on compatible controllers. See the [Sunrise IDE tools](#ide) section.
- [Sunrise IDE (emulators)](https://github.com/Konamiman/Nextor/releases/download/v2.1.0/Nextor-2.1.0.SunriseIDE.emulators.ROM): Same as above, but using an older driver that works better on emulators (for some reason the newer driver doesn't recognize the master device when working on emulators).
- MegaFlashROM SCC+ SD: This version contains an embedded driver for the MegaFlashROM SCC+ SD, as well as the appropriate ROM mapper; it is intended to be burned directly as the SD kernel of the cartridge. The following versions are available (1 slot and 2 slots versions differ in the number of drives allocated at boot time):
- Normal version, intended to be burned with the OPFXSD tool.
- [For MegaFlashROM with 1 SD card slot](https://github.com/Konamiman/Nextor/releases/download/v2.1.0/Nextor-2.1.0.MegaFlashSDSCC.1-slot.ROM)
- [For MegaFlashROM with 2 SD card slots](https://github.com/Konamiman/Nextor/releases/download/v2.1.0/Nextor-2.1.0.MegaFlashSDSCC.2-slots.ROM)
- Recovery version, intended to be burned with the recovery tool that comes built-in with the cartridge.
- [For MegaFlashROM with 1 SD card slot](https://github.com/Konamiman/Nextor/releases/download/v2.1.0/Nextor-2.1.0.MegaFlashSDSCC.1-slot.Recovery.ROM)
- [For MegaFlashROM with 2 SD card slots](https://github.com/Konamiman/Nextor/releases/download/v2.1.0/Nextor-2.1.0.MegaFlashSDSCC.2-slots.Recovery.ROM)
- NEXTOR.SYS: The NEXTOR.SYS file replaces MSXDOS2.SYS and is needed in order to boot in the DOS prompt. There are two versions available:
	- [Full version](https://github.com/Konamiman/Nextor/releases/download/v2.1.0/NEXTOR.SYS.japanese): Contains the in-memory part of the command interpreter error messages (such as "Abort, Retry, Ignore") in English and Japanese (the latter are displayed when in kanji mode).
		- [Reduced version](https://github.com/Konamiman/Nextor/releases/download/v2.1.0/NEXTOR.SYS): Contains the in-memory part of the command interpreter error messages in English only. Using this file instead of the full version saves 256 bytes of TPA space at run time.
- COMMAND2.COM: In addition to NEXTOR.SYS, you need a command interpreter for booting in the DOS prompt. No new command interpreter has been created for Nextor; instead, the same COMMAND2.COM of MSX-DOS 2 is used, so you can use the same file you were using until now. [COMMAND 2.44 by TNI](http://www.tni.nl/products/command2.html) is recommended, it has a lot of nice features.
- External tools: All the user-controllable new features of Nextor are handled by external tools (.COM files). You have two options to get them:
- [TOOLS.ZIP](https://github.com/Konamiman/Nextor/releases/download/v2.1.0/tools.zip): All the Nextor command line tools, compressed in a ZIP file.
- [TOOLS.DSK.ZIP](https://github.com/Konamiman/Nextor/releases/download/v2.1.0/tools.dsk.zip): A floppy disk image containing the tools plus NEXTOR.SYS and COMMAND2.COM (also MSXDOS.SYS and COMMAND.COM for booting in MSX-DOS 1 mode). Useful if you will use Nextor with a MSX emulator.
- [Volume Size Fix Tool](https://github.com/Konamiman/Nextor/releases/download/v2.1.0/VSFT.COM): If you have partitioned a device by using FDISK in Nextor 2.0.2 or earlier, or in Nextor 2.1 Alpha 1, chances are that the generated partitions exceed the maximum cluster count (as defined by the FAT standard) by one or two clusters, due to a bug in FDISK that has been corrected in version 2.0.3. This tool allows you to fix these partitions by slightly reducing its size. *[\[Source code in C\]](https://github.com/Konamiman/Nextor/blob/v2.1/source/tools/C/vsft.c)*

If you are a developer, you may be interested in the following resources as well:

- [Nextor Programmers Reference](https://github.com/Konamiman/Nextor/blob/v2.1/docs/Nextor%202.1%20Programmers%20Reference.md): Explains the new features that Nextor offers to developers.
- [Nextor Driver Development Guide](https://github.com/Konamiman/Nextor/blob/v2.1/docs/Nextor%202.1%20Driver%20Development%20Guide.md): Explains how to develop a storage device driver and how to embed it within a Nextor kernel
- [Nextor kernel base file](https://github.com/Konamiman/Nextor/releases/download/v2.1.0/Nextor-2.1.0.base.dat): This is the Nextor kernel without an attached driver. It is necessary to use this file in order to create a complete Nextor kernel ROM file, as explained in the Driver Development Guide.
- [DRIVER.ASM](https://github.com/Konamiman/Nextor/blob/v2.1/docs/DRIVER.ASM): The source code of a dummy Nextor driver, it can be used as the skeleton for building a custom driver.
- [Mapper files](https://github.com/Konamiman/Nextor/releases/download/v2.1.0/mappers.zip): A complete Nextor kernel must have mapper code, that is, the code that knows how to switch ROM banks depending on the type of hardware it is burned on, as explained in the Driver Development Guide. When building a kernel with ASCII8 mapper with MKNEXROM.EXE, use *Mapper.ASCII8.bin* (instead of *Mapper.ASCII8.noheader.bin*).
- [MKNEXROM.EXE](https://github.com/Konamiman/Nextor/releases/download/v2.1.0/mknexrom.exe): A command-line tool for Windows computers that can be used to generate a complete Nextor kernel ROM with embedded driver. *[\[Source code in C\]](https://github.com/Konamiman/Nextor/blob/v2.1/wintools/mknexrom.c)*

[Return to index](#index)

---

## NestorBASIC

NestorBASIC is a BASIC extension for MSX2/2+/TR computers with at least 128K mapped RAM. It is Turbo-BASIC compatible (in fact it includes Turbo-BASIC, an loads it at installation time) and provides the following capabilities:

- **Access to all the mapped memory available on the computer** (all the free memory when using DOS 2)**, up to 4 Mb.**
- **Full access to VRAM,** including data blocks exchange between RAM and VRAM.
- **BASIC programs storage in mapped memory,** it is possible to switch from one to another without losing the existing variables.
- **Disk files and sectors access,** it is possible to directly read/write to/from mapped memory and VRAM. **File searching, directories management.**
- **Graphic compression/decompresion.**
- **MoonBlaster music replay. Samplekit and wavekit load.**
- **PSG sound effects replay.**
- **Machine code routines execution;** routines placed in BIOS, in a mapped memory segment or in BASIC main memory (including system work area) can be executed **directly or using interrupts.**
- **NestorMan functions, InterNestor Suite and InterNestor Lite routines execution.**

NestorBASIC consists on a single file which can be installed with a simple BLOAD instruction. It installs itself on a hidden RAM segment and only uses about 500 bytes of the BASIC main memory. Its functions are invoked using an USR instruction and an array for the parameters, so they can be used from inside of turbo-blocks. Turbo-BASIC is included within the NestorBASIC file, both are installed simultaneously.

A scary story

NestorBASIC 1.0 release date is july 2003, whilst the last beta, version 0.07, was released in july 1998. Yes, the NestorBASIC project has remained abandoned for exactly five years.

The story is as follows. In 1998 a technical failure (the SCSI cable I used those days was bullshit) caused a crash in my computer, and when restarting I discovered that the FAT of the hard disk partition where my programs were stored was completely smashed. With a lot of patience and a sectors editor I could recover almost all of the source codes, but one of the lost ones was NestorBASIC.

And you may ask: "But you hadn't any backup copy?" Yes, I had the NestorBASIC directory mirrored in another partition of the hard disk... but it was version 0.06, and a lot of changes were made when stepping to version 0.07. So, since NestorBASIC 0.07 was already quite complete, I decided to abandon the project.

And time passed... until may 2003. While I was looking at Kyoko playing Bubble Rain, I began to think: "It is really a nice game, and the best part is that it uses NestorBASIC, what a pity that I lost the source code... it is the only of my programs that are used regularly by other MSX users (more or less), if I could only recover it and improve it a little... blah blah..."

So I took a crazy decision: I would dissassemble NestorBASIC 0.07 and, comparing the result with the sources of version 0.06, I would rebuild the lost sources and from that point I would make version 1.0. And I really did it: one month of hard work later, NestorBASIC 1.0 was released, with a lot of failures corrected and with support for InterNestor Suite.

I hope that it was worth the effort, and that soon MSX programmers around the world will develop a lot of games and internet applications using NestorBASIC (well, just daydreaming).

NestorBASIC downloads:

- [NBASIC.BIN](https://www.konamiman.com/msx/nbasic/NBASIC.BIN): **NestorBASIC 1.11** , with a simple BLOAD"NBASIC.BIN",R you have installed it.
- [NBAS111E.TXT](https://www.konamiman.com/msx/nbasic/nbas111e.txt): User's manual in english.
- [NBAS111S.TXT](https://www.konamiman.com/msx/nbasic/nbas111s.txt): User's manual in spanish.
- [NBVERS-E.TXT](https://www.konamiman.com/msx/nbasic/nbvers-e.txt): Versions information file in english.
- [NBVERS-S.TXT](https://www.konamiman.com/msx/nbasic/nbvers-s.txt): Versions information file in spanish.
- [SAMPLES.LZH](https://www.konamiman.com/msx/nbasic/samples.lzh): Samples about file searching and MoonBlaster music replay.
- [TCPCON.LZH](https://www.konamiman.com/msx/nbasic/tcpcon.lzh): Sample about using InterNestor Suite and InterNestor Lite with NestorBASIC. TCP Console is a program that opens a TCP connection, sends to it everything typed at the keyboard, and prints on the screen everything received. The "source" codes in [NestorPreTer](#nestorpreter) format and the MSX-BASIC executables are included (TCPCON-S for InterNestor Suite and TCPCON-L for InterNestor Lite).
- [NPLAYER.LZH](https://www.konamiman.com/msx/nbasic/nplayer.lzh): NestorPlayer 1.0, MoonBlaster FM and Wave replayer that uses NestorBASIC. It allows to browse the available disk drives and directories to search for music files, samplekits and wavekits.
- [SEE.LZH](https://www.konamiman.com/msx/nbasic/see.lzh): PSG sound effects editor developped by Fuzzy Logic. NestorBASIC can replay these sound effects.

[Return to index](#index)

---

## NestorBASIC extensions

One of the capabilities of NestorBASIC is the possibility of executing machine code routines previously loaded on any memory segment. Using this mechanism it is possible to develop extensions for tasks that are impossible to do when using only BASIC instructions or NestorBASIC functions. In this section you have all the extensions I have developped for NestorBASIC, all of them include usage manual and an usage example.

- [CABROPL4.LZH](https://www.konamiman.com/msx/nbasic/cabropl4.lzh): Allows direct control of MoonSound's sound chip OPL4, without having to use the MoonBlaster driver.
- [NMIF.LZH](https://www.konamiman.com/msx/nbasic/nmif.lzh): **NestorMIF** allows the decompression of MIF format graphic files previously loaded on mapped memory.
- [NCADS.LZH](https://www.konamiman.com/msx/nbasic/ncads.lzh): **NestorCadenas.** This extension is useful for programs that use a lot of text strings. Now you can store all the strings in a text file, load this file on mapped memory, and by using NestorCadenas retrieve the strings when you need them. You can retrieve the strings sequentially (in the same order they are stored in the file) or randomly (identifying the strings with a name). The advantage is clear: if the strings are stored in mapped memory, more main memory is available for the BASIC program.

[Return to index](#index)

---

## NestorPreTer

When writing MSX-BASIC programas we encounter three problems. First, the comments we add to the code use part of the scare memory available for the program. Second, variable names can have only two characters, which does not help to add readability to the program. And third, jumps and subroutine calls refer to line number, which also makes the program to be difficult to trace.

**NestorPreTer**, which works in MSX2/2+/TR with at least 128K mapped RAM, helps to solve these problems. It is a BASIC pre-interpreter, that is, a utility that converts a text file into an MSX-BASIC executable program; this text file may be generated with a text editor or in the MSX-BASIC environment, saving the program in ASCII format (SAVE"PROGRAM.BAS",A). The processing performed by NestorPreTer on the "source" file is as follows:

- **Remarks and blank spaces stripping.** You can add to your "source" as many comments and indentations as you want, the amount of memory used by your program will be only the amount needed to store the code.
- **Line numbers generation.** It is not necessary to type line numbers in the code, since NestorPreTer will generate them automatically. To identify the lines that are destination for jump instructions, you can use alphanumeric labels.
- **Macro expansion.** You can define macros, that is, text blocks with an assigned name (similar to DEFINE directive of the C language). This allows the simulation of long names for variables, for example you can include "@DEFINE FILE\_NAME F$" at the beginning of the text, and then use "INPUT @FILE\_NAME" within the code.

NestorPreTer downloads:

- [NPR.LZH](https://www.konamiman.com/msx/nestorpreter/npr.lzh): **NestorPreTer 0.3** , program file.
- [NPRENG.TXT](https://www.konamiman.com/msx/nestorpreter/npreng.txt): User's manual in english.
- [NPRESP.TXT](https://www.konamiman.com/msx/nestorpreter/npresp.txt): User's manual in spanish.
- [NPREV-E.TXT](https://www.konamiman.com/msx/nestorpreter/nprev-e.txt): Information about versions in english.
- [NPREV-S.TXT](https://www.konamiman.com/msx/nestorpreter/nprev-s.txt): Information about versions in spanish.
- [NPRNB.LZH](https://www.konamiman.com/msx/nestorpreter/nprnb.lzh): Example of the ensemble use of [NestorBASIC](#nestorbasic) and NestorPreTer.

[Return to index](#index)

---

## InterNestor Suite

Note: discontinued software

InterNestor Suite is discontinued. It is kept here for historical/archeological reasons only.

If you are looking for an "alive" TCP/IP stack, please take a look at the [InterNestor Lite section](#inl2).

InterNestor Suite is a TCP/IP plus PPP stack for MSX2/2+/TR computers with MSX-DOS 2, at least 256K mapped RAM and RS232 interface. It allows internet connection through a modem and using any ISP access account, or direct connection to other computer using a null-modem cable. It installs as a TSR, so any application may use its routines for acessing the internet. InterNestor Suite consists on:

- *Installer program,* it installs the modules that compose the stack.
- Four *code modules:* physical module (RS232), link level module (PPP), network level module (IP) and transport level module (TCP).
- *Modem dialer* for connections via modem+ISP.
- PPP connection and TCP connections *control programs.*
- *Four simple applications:* a PING client, a resolver (name server access client, for example to convert site names to IP addresses), a simple telnet client, and a complete FTP client.
- *User's and programmer's manual,* in english. This manual explains how to install and use InterNestor Suite, and provides all the necessary information for developping internet based applications.

**Note:** InterNestor Suite requires [NestorMan](#nestorman) to work.

Downloads for InterNestor Suite:

- [INS-V10.LZH](https://www.konamiman.com/msx/insuite/ins-v10.lzh): **InterNestor Suite 1.0** , with all the components mentioned above plus the Erik Maas' Fossil driver for RS232, needed by the stack to work.

[Return to index](#index)

---

## InterNestor Lite

Note about InterNestor Lite 1.x

Starting at version 2.0, InterNestor Lite implements the TCP/IP UNAPI specification and is not compatible with version 1.x, which is discontinued.

If you want to use any of the older networking applications that target InterNestor Lite 1.x, you can download the old version in the [InterNestor Lite 1 section](#inl1).

InterNestor Lite is a TCP/IP stack that works on MSX2/2+/TR with at least 128K RAM. It supports two kinds of hardware: serial port (RS232) with modem, and the [Ethernet UNAPI](#unapi).

InterNestor Lite implements the [TCP/IP UNAPI](#tcpipunapi) specification, therefore you can use it to run the software in the [networking applications](#networking) section.

**Please note:** InterNestor Lite requires the UNAPI RAM helper in order to be installed, and as of version 2.1, it requires mapper support routines too. If you run MSX-DOS 2 or Nextor, mapper support routines are built-in and you just need to install the RAM helper using [RAMHELPR.COM](https://www.konamiman.com/msx/unapi/ramhelpr.com) before installing InterNestor. If you run MSX-DOS 1, you can install both the mapper support routines and the RAM helper using [MSR.COM](https://www.konamiman.com/msx/unapi/msr.com).

See also: [How to use a RaspberriPi + stunnel to access Internet via WiFi with Ethernet-only hardware](https://gist.github.com/Konamiman/110adcc485b372f1aff000b4180e2e10).

- [InterNestor Lite 2.0 for RS232](https://www.konamiman.com/msx/inl2/serial/inl.com): Allows you to connect your MSX to Internet by using a modem and an ISP account, or to connect to another machine who understands the PPP protocol by using a null-modem cable. Requires the Fossil driver.
- [Fossil driver for RS232](https://www.konamiman.com/msx/inl2/serial/driver.com): Needs to be installed in order to use the RS232 version of InterNestor Lite.
- [InterNestor Lite 2.3 for the Ethernet UNAPI](https://www.konamiman.com/msx/inl2/ethernet/inl.com): Allows you to connect your MSX to Internet by using a network card with an Ethernet UNAPI compatible BIOS (or by using any other kind of Ethernet UNAPI compatible software). [See what's new in v2.3](https://github.com/Konamiman/MSX/pull/22).
- [InterNestor Lite 2.3 source code in GitHub](https://github.com/Konamiman/MSX/tree/master/SRC/INL). Includes documentation for both users and developers: a getting started guide, command line and configuration reference, and the ugly technical details.

**NOTE:** If you have an ObsoNET card, make sure you have BIOS version 1.1 or newer on it, which implements the Ethernet UNAPI specification; otherwise you will not be able to use InterNestor Lite with your ObsoNET. You can download the latest ObsoNET BIOS from the [ObsoNET section.](#obsonet)

Note about InterNestor Lite 2 for RS-232

As you can see, InterNestor Lite for RS-232 is stuck at version 2.0. That's because I no longer have the hardware needed to test it. I don't want to publish software I haven't been able to test, therefore the RS-232 variant of InterNestor Lite is discontinued for now.

If you want to build the RS-232 variant of version 2.1 from [the sources](https://github.com/Konamiman/MSX/tree/master/SRC/INL) and test it yourself, I'll be glad to publish it here.

[Return to index](#index)

---

## Networking software

The applications of this section allow you to connect your MSX to Internet. All of them need an implementation of the [TCP/IP UNAPI specification](#tcpipunapi) to work, such as [InterNestor Lite](#inl2) or [the DenYoNet card](#denyonet).

[This floppy disk image](https://www.konamiman.com/msx/networking/msxinet.zip) contains [InterNestor Lite](#inl2) and all the applications listed in this section. It may be useful for you if you want to try the applications in an MSX emulator with network card emulation support, such as [blueMSX](http://www.bluemsx.com/).

The source code of all applications is available at [the networking section in Konamiman's MSX software repository](https://github.com/Konamiman/MSX/tree/master/SRC/NETWORK). Some are in assembler (with the MSX assembler Compass, can be assembled with [Sjasm 0.39h](https://github.com/Konamiman/Sjasm/releases/tag/v0.39h)), and some in C (with the [SDCC cross compiler](#sdcc)).

- [PING.COM](https://www.konamiman.com/msx/networking/ping.com): Simple PING client 1.1. Sends one ping request automatically, then sends additional requests when ENTER is pressed.
- [TFTP.COM](https://www.konamiman.com/msx/networking/tftp.com): TFTP client/server 1.1. TFTP is a simple and straighforward way to transfer single files between two computers. [See what's new in v1.1](https://github.com/Konamiman/MSX/pull/8).
- [TCPCON.COM](https://www.konamiman.com/msx/networking/tcpcon.com): TCP console 1.1. It is a simplified Telnet client, it just sends data from the keyboard to the network and from the network to the screen, ignoring the Telnet control codes.
- [FTP.COM](https://www.konamiman.com/msx/networking/ftp.com): FTP client 1.0. Command-line based FTP client, requires MSX-DOS 2 to work. The multiple file management commands (MGET, MPUT and MDELETE) require [NestorMan](#nestorman) to work.
- [SNTP.COM](https://www.konamiman.com/msx/networking/sntp.com): SNTP client 1.2. Allows you to configure the clock of your MSX by querying the current date and time to a time server. You can find a list of public time server at [the NTP pool page](http://www.pool.ntp.org/). [See what's new in v1.1](https://github.com/Konamiman/MSX/pull/9)
- [TWEETER.COM](https://www.konamiman.com/msx/networking/tweeter.com): MSX trivial tweeter 1.0. Allows you to send messages to Twitter from your MSX.
- [TWEETER.CHR](https://www.konamiman.com/msx/networking/msxtt-charmaps/cp850/tweeter.chr): CP850 character map file. If this file is placed in the same directory of TWEETER.COM, you will be able to include in your tweetes special characters pertaining to the CP850 character set (western european) such as vowels with tilde and others like ñ ¡ ¿. On japanese MSX you can generate these characters by using [NestorAcentos](https://www.konamiman.com/msx/misc/nac11.lzh).
- [HGET.COM](https://www.konamiman.com/msx/networking/hget.com): HTTP file downloader 1.3. A (very) simplified version of the popular tool WGET, it allows you to download files and resources by using the HTTP protocol. Supports basic HTTP authentication and continuing the retrieval of interrupted downloads. It has an "interactive" mode in which the URL of the resource to retrieve can be obtained from the console output of another program, by using pipelining (e.g. `type url.txt | hget con`). [See what's new in version 1.3.](https://github.com/Konamiman/MSX/pull/10)
- [GETURL.COM](https://www.konamiman.com/msx/networking/geturl.com): URL extractor 1.0. This is not strictly a network application, but it may be useful when used together with HGET. It searches inside a text file for a line with the format `[urlname] url`, then it sends the URL to the console. For example, if you have a file named `urls.txt` with one of the lines being `[knm] www.konamiman.com`, you can execute `geturl urls.txt knm | hget con` as an equivalent of `hget www.konamiman.com`.
- [MSXTDB.LZH](https://www.konamiman.com/msx/networking/msxtdb.lzh): MSX trivial dropbox 1.1. [Dropbox](http://www.dropbox.com/) is an online file storage service which offers both free and paid plans (at the time of this writing, there is one free plan that provides 2GB of storage space, and two paid plans that provide 50GB and 100GB). MSX trivial dropbox is a suite of programs that allows to manage, and to transfer files from/to, a Dropbox account from your MSX. The download includes a user manual.
- [OBSOSMB.COM](https://www.konamiman.com/msx/networking/obsosmb.com): ObsoSMB 1.0. ObsoSMB allows you to expose your MSX disk drives as shared folders to machines running Microsoft Windows; this is achieved by using SMB, a protocol defined by Microsoft for sharing resources across a network. Yo can then perform any operation on the exposed files and folders (transfer, rename, create, delete, change attributes) by using Windows explorer or any other file manager from your PC. *[\[User's manual\]](https://www.konamiman.com/msx/networking/obsosmb.txt)*,
- [OBSOFTP.COM](https://www.konamiman.com/msx/networking/obsoftp.com): ObsoFTP 1.0. ObsoFTP will turn your MSX into a FTP server, allowing you to easily transfer files between your MSX and other computers. This is a less powerful file sharing option than ObsoSMB, but more interoperable as it does not require a Windows client.

Note about MSX trivial tweeter user authorization

Before the application can send tweets on your behalf, you will need access to a computer with a web browser in order to perform an authorization process; this must be done only once per Twitter account.

It works this way: MSX trivial tweeter will connect to Twitter in order to get a temporary authorization token. Then, it will display you a long and ugly URL that you must type on the address bar of a web browser. From here, you confirm that you authorize MSX trivial tweeter to tweet on your behalf. You get then a PIN code, that you must type on your MSX.

It is not my fault. The OAuth protocol is quite cumbersome on non-web based Twitter clients.

Note about MSX trivial dropbox

Starting at version 1.1, MSX trivial dropbox is no longer a standalone application. It uses Dropbox API v1, which requires mandatory usage of [HTTPS](http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol_Secure). MSX computers can't currently handle HTTPS (or any other protocol on top of [SSL/TLS](http://en.wikipedia.org/wiki/Transport_Layer_Security)), therefore it is necessary to use a proxy (located in another computer) to convert plain TCP to SSL and the other way around (an example of such proxy is [stunnel](https://www.stunnel.org/)). Please read the MSX trivial dropbox user manual for details.

Also, as in the case of MSX trivial tweeter, a one-time authorization process with the involvement a web browser is needed before using the tool.

The following are not Internet applications but will be useful for you if you connect your MSX to Internet:

- [ETH.COM](https://www.konamiman.com/msx/networking/eth.com): Ethernet UNAPI control program 1.0. Allows you to perform various control tasks on your Ethernet hardware, such as obtaining and changing (when supported) the MAC address, or resetting the Ethernet hardware. *[\[Source code\]](https://github.com/Konamiman/MSX-UNAPI-specification/blob/master/tools/eth.c)*
- [TCPIP.COM](https://www.konamiman.com/msx/networking/tcpip.com): TCP/IP UNAPI control program 1.0. Allows you to perform various control tasks on any TCP/IP UNAPI implementation, such as manually setting the IP addresses, or enabling/disabling the automatic reply to incoming PINGs. *[\[Source code\]](https://github.com/Konamiman/MSX-UNAPI-specification/blob/master/tools/tcpip.c)*

[Return to index](#index)

---

## InterNestor Lite 1

Note: discontinued software

To get the latest version of InterNestor Lite, please take a look at the [current InterNestor Lite section](#inl2). Version 1.x is discontinued.

Starting at version 2.0, InterNestor Lite implements the TCP/IP UNAPI specification and is not compatible with versions 1.x: networking applications targetting the TCP/IP UNAPI implementations will not work on versions 1.x, and vice versa. For this reason, InterNestor Lite 1 is still available for download here, so you can still using the old applications made for versions 1.x.

Networking application developers should target the [TCP/IP UNAPI specification](#tcpipunapi) instead of InterNestor Lite for new applications. Moreover, to the extent possible, existing applications should be ported to target the TCP/IP specification.

*See also the [InterNestor Lite project site on SourceForge.net](https://sourceforge.net/projects/internestor).*

InterNestor Lite is a TCP/IP stack that works on MSX2/2+/TR with at least 128K RAM. It supports two kinds of hardware: serial port (RS232) with modem, and the [Ethernet UNAPI](#unapi).

- [INL11.LZH](https://www.konamiman.com/msx/inl1/inl11.lzh): InterNestor Lite 1.1.1. Includes both the serial and the Ethernet UNAPI version, as well as the Fossil driver (necessary for the serial version), and the user's and programmer's manual in spanish and english. It has support for UDP and TCP, as well as for sending and capturing raw datagrams, and built-in resolver; a simple PING client, a TFTP client/server, a TCP console -simplified Telnet client- and a Telnet client with partial support for VT100 escape codes are included (the first three applications include the source code).
	**NOTE:** If you have an ObsoNET card, make sure you have BIOS version 1.1 or newer on it, which implements the Ethernet UNAPI specification; otherwise you will not be able to use InterNestor Lite with your ObsoNET. You can download the latest ObsoNET BIOS from the [ObsoNET section.](#obsonet)
- [FTP.COM](https://www.konamiman.com/msx/inl1/ftp.com): FTP client for InterNestor Lite 1.x. This application is similar to the command-line based FTP client shipped with the Windows and Linux operating systems. It requires DOS 2, and the commands that operate on multiple files (MGET, MPUT and MDELETE) require also that [NestorMan](#nestorman) be installed.
- [INLIB](https://www.konamiman.com/msx/sdcc/inlib.zip): C library for InterNestor Lite 1.x. This is a library of functions for accessing InterNestor Lite capabilities from programs developed in C language. It is intended for use with the SDCC compiler. More information on the [SDCC section](#sdcc).
- [INL11SRC.LZH](https://www.konamiman.com/msx/inl1/inl11src.lzh): InterNestor Lite 1.1 source code. Licensed under [GPL](http://www.gnu.org/copyleft/gpl.html).

[Return to index](#index)

---

## Software for ObsoNET

ObsoNET is an Ethernet card for MSX computers, formerly designed and manufactured by Daniel Berdugo. In this section you will find the software that I have developed for this card.

**Important:** Please upgrade your ObsoNET card BIOS to version 1.2, which is compatible with the Ethernet UNAPI, so you can use the newest version of [InterNestor Lite](#inl2). The old InterNestor Lite for ObsoNET (version 1.0x) is now discontinued.

- [ONETM-S.TXT](https://www.konamiman.com/msx/obsonet/onetm-s.txt): **ObsoNET user's and programmer's manual.** Spanish version.
- [ONETM-E.TXT](https://www.konamiman.com/msx/obsonet/onetm-e.txt): **ObsoNET user's and programmer's manual.** English version.
- [ONETFRL.COM](https://www.konamiman.com/msx/obsonet/onetfrl.com): **ObsoNET Flash ROM loader 1.0.** This application is necessary in order to update the ObsoNET BIOS and burn custom programs on its ROM.
- **[BIOS.ROM](https://www.konamiman.com/msx/obsonet/bios.rom), [BIOS.DAT](https://www.konamiman.com/msx/obsonet/bios.dat): ObsoNET BIOS 1.3.** This version is compatible with BIOS 1.0, but adds compatibility with the [Ethernet UNAPI](#unapi). On the user's manual the differences between these files are explained.
- [BIOS10.LZH](https://www.konamiman.com/msx/obsonet/bios10.lzh):The old **BIOS version 1.0**, in case you experience problems with BIOS 1.3 (you should not, of course!)
- [InterNestor Lite](#inl2). With [BIOS 1.3](https://www.konamiman.com/msx/obsonet/bios.rom), you can use InterNestor Lite for the Ethernet UNAPI with your ObsoNET card.

As a starting point for working with ObsoNET, it is recommended to read sections 1 and 2 of ObsoNET manual, as well as section 2.3 of InterNestor Lite manual.

[Return to index](#index)

---

## Software for DenYoNet

DenYoNet is an Ethernet card for MSX computers, created by Dennis Koller and Jos van den Biggelaar, and produced by [Sunrise for MSX](http://www.msx.ch/sunformsx/). In this section you will find the software that I have developed for this card.

- [DENYOROM.COM](https://www.konamiman.com/msx/denyonet/denyorom.com): **DenYoNet flash ROM loader 1.1.** Tool to load the DenYoNet flash ROM with a ROM code file. *[\[Source code\]](https://www.konamiman.com/msx/denyonet/source/denyorom.asm)*
	**NOTE:** This ROM loader assumes that the MAC for the card is stored at position 16 of the ROM file (that is, immediately after the MSX ROM header) and provides three options: keep the MAC on the current card ROM (default), use the MAC on the new ROM file, or manually specify a new MAC. Please run the application without parameters for more information.
- [DENYOETH.ROM](https://www.konamiman.com/msx/denyonet/denyoeth.rom): **DenYoNet Ethernet UNAPI BIOS 1.5.** This is a ROM file that will made your DenYoNet compatible with the Ethernet UNAPI specification, so that you can use [networking applications](#networking) by installing a TCP/IP UNAPI implementation such as [InterNestor Lite](#inl2). *[\[Source code\]](https://www.konamiman.com/msx/denyonet/source/denyoeth.asm)*
- [DENYOTCP.ROM](https://www.konamiman.com/msx/denyonet/denyotcp.rom): **DenYoNet TCP/IP UNAPI BIOS 0.6.** This is a ROM file that will made your DenYoNet compatible with the TCP/IP UNAPI specification, so that you can use [networking applications](#networking) directly, without having to install a separate TCP/IP stack. *[\[Source code\]](https://www.konamiman.com/msx/denyonet/source/denyotcp.asm)*
- [DENYTCP2.ROM](https://www.konamiman.com/msx/denyonet/denytcp2.rom): An alternative version of DenYoNet TCP/IP UNAPI BIOS 0.6 that has the behavior of the ESC key reversed: BIOS is NOT initialized if the key is NOT pressed at boot time, and is initialized if the key is pressed.
- [DENYINIT.COM](https://www.konamiman.com/msx/denyonet/denyinit.com): **DenYoNet TCP/IP BIOS initialization tool.** If you boot your computer while pressing ESC (or while not pressing it, if you use the alternative BIOS), you can use this tool to initialize the BIOS. Usage: *denyinit \<DenyoNet slot>\[-\<subslot>\].* *[\[Source code\]](https://www.konamiman.com/msx/denyonet/source/denyinit.asm)*
- Version 0.6 is feature complete: in addition to the TCP and UDP connectivity provided by the embedded W5100, it has domain name resolver, DHCP client and support for sending PINGs. This version will escalate to 1.0 after additional testing is performed.

Note for Panasonic FS-A1 GT owners

There is a known bug in the DenYoNet TCP/IP UNAPI BIOS that manifests in MSX Turbo-R Panasonic FS-A1 GT computers and prevents the computer from booting. If you own a DenYoNet card and that MSX model (or any other model in which you experiment the same problem) please apply the following workaround while the bug is being investigated:

1. Flash the alternative BIOS version (DENYTCP2.ROM) in your DenYoNet.
2. Execute DENYINIT.COM from your AUTOEXEC.BAT, or manually before using networking software.

An alternative method to initialize the DenYoNet BIOS is by executing *CALL DENYOINIT* in the BASIC prompt.

[Return to index](#index)

---

## NestorMan

NestorMan is a dynamic memory manager for MSX2/2+/TR with MSX-DOS 2. It installs as a TSR, so it may be used by any other application. NestorMan offers the following capabilities:

- *Reservation of memory blocks with sizes between 1 byte and 16K.* This mechanism is much more versatile than the one provided by DOS 2, which only allows the allocation of whole 16K segments. After asking NestorMan for a new block of the desired size, it returns the number of the segment where the block has been reserved, as well as its starting address. NestorMan automatically handles the allocation of new segments when they are needed.
- *Double-chained lists creation.* These lists are data structures in which each item is stored with a pointer to the previous item and a pointer to the next item. It is possible to insert items (any data block with a size of up to 16K) and to extract them to/from any position on the list, as well as to "browse" the items (to move to the previous or to the next item, or to move to a given item providing his index number in the list).

Downloads for NestorMan:

- [NMAN122.LZH](https://www.konamiman.com/msx/nestorman/nman122.lzh): **NestorMan 1.22.** Includes user's manual in spanish and english.
- [TEXTOR.LZH](https://www.konamiman.com/msx/nestorman/textor.lzh): **TexTor 1.0.** It is a very simple text editor, similar to MS-DOS' EDLIN, that serves as an example of the use of NestorMan. Source code is included.

[Return to index](#index)

---

## MegaSCSI

MegaSCSI, developped by [ESE Artists Factory](http://www.hat.hi-ho.ne.jp/tujikawa/ese/) , is the best SCSI controller available for MSX. I'm really lucky of having one and I have developped some applications for being used with it. These applications are listed below:

- [WPE.LZH](https://www.konamiman.com/msx/megascsi/wpe.lzh): Two utilities, WP.COM and WE.COM, for write-protect and write-enable disk partitions created with MegaSCSI. Source code is included.
- [BOOT60.LZH](https://www.konamiman.com/msx/megascsi/boot60.lzh): Patch for the MegaSCSI boot program placed at SRAM. It forces the computer to boot in 60Hz mode, or in 50Hz mode if the H key is pressed while booting. Includes the source code.
- [CHGKEY.LZH](https://www.konamiman.com/msx/megascsi/chgkey.lzh): Patch for the MegaSCSI SRAM. Allows the use of the normal keyboard (keys 0-9 and A-F) instead of the numeric keyboard to emulate disk changes when using floppy emulation. Useful for Philips 8245 and similar computers users. Includes the source code.
- [PSETLIST.LZH](https://www.konamiman.com/msx/megascsi/psetlist.lzh): Includes two programs. PARSET is a partition setting program that uses the standard partition table on the boot sector of the disk instead of the file MEGASCSI.TBL, so it works with all the disks having this format: ESE-ASPI, IDE, all PC disks... PARLIST lists all the existing partitions on the disk, showing the length and the starting sector of each one. Source code is included.
- [NCDPLAY.LZH](https://www.konamiman.com/msx/megascsi/ncdplay.lzh): **NestorCDPlayer** is a CD Audio player for MegaSCSI. It installs as TSR and you can control the CD replaying process from within any application, by using CTRL/SHIFT + CODE/GRAPH key combinations. Source code is included.
- [NDICREAT.LZH](https://www.konamiman.com/msx/megascsi/ndicreat.lzh): This utility does not really require MegaSCSI to work, but without it it is not very useful. **NestorDiskImageCreator** creates empty disk images with any size between 10K and 32500K.

If you want to develop your own applications for MegaSCSI, this document will be very helpful for you:

- [MEGUIDE.TXT](https://www.konamiman.com/msx/megascsi/meguide.txt): Shortened english translation of the MegaSCSI's programming manual. It is not complete, but the basic concepts and the most important BIOS functions are explained.

[Return to index](#index)

---

## LPE-Z380

Some years ago [Leonardo Padial](http://msx.deneb.nl/) developped a Z380 card for MSX. Daniel Zorita and me helped him with the software development, and here is my contribution to that project:

- [EPROM30.LZH](https://www.konamiman.com/msx/lpe-z380/eprom30.lzh): Version 3.0 of the EPROM included in the card.
- [Z380MAN.TXT](https://www.konamiman.com/msx/lpe-z380/z380man.txt): LPE-Z380 with EPROM 3.0 programmer's manual in english.
- [Z380MAN.LZH](https://www.konamiman.com/msx/lpe-z380/z380man.lzh): Compressed version of the file Z380MAN.TXT.
- [ZUTILS.LZH](https://www.konamiman.com/msx/lpe-z380/zutils.lzh): Includes F2Z.COM, to load a file into the LPE-Z380 memory; Z2F.COM, to perform the reverse process; and ZEXE.COM, to execute a Z380 program.
- [CALLPCM.LZH](https://www.konamiman.com/msx/lpe-z380/callpcm.lzh): Sample of BASIC CALL command installable on the LPE-Z380 card. With this program it is possible to save and replay PCMs directly to/from the LPE-Z380 memory, using the Turbo-R microphone. It is a very simple program that does not include trigger level specification nor silence compression.

If you want to develop your own programs for LPE-Z380 and you don't have an assembler for Z380, the following file may be very helpful for you:

- [Z380MAC.TXT](https://www.konamiman.com/msx/lpe-z380/z380mac.txt): Macros for assembling Z380 instructions using a Z80 assembler, it is only necessary to slightly vary the original instructions syntax. The macros have been tested with Compass, they should not cause problems on other assemblers.
- [Z380MAC.LZH](https://www.konamiman.com/msx/lpe-z380/z380mac.lzh): Compressed version of the file Z380MAC.TXT.

[Return to index](#index)

---

## SDCC libraries

SDCC stands for *Small Devices C Compiler*. It is an open source C language cross-compiler available for Windows and Linux platforms, targetting the Z80 processor among others. SDCC can be obtained at [the SDCC project page](http://sdcc.sourceforge.net/); more information and resources about development of MSX applications using SDCC is available at [Avelino Herrera's MSX page](http://msx.atlantes.org/index_en.html) .

In this section you can find some libraries that can be useful when developing MSX applications with SDCC.

- [MSXCHAR](https://www.konamiman.com/msx/sdcc/msxchar.zip): Standard C console functions for MSX. This is a set of MSX compatible versions of the basic standard C console functions: *[\[Source code\]](https://github.com/Konamiman/MSX/tree/master/SRC/SDCC/char)*
	- *putchar*, used by *puts* and *printf*. There are two variants: one for MSX-BASIC and one for MSX-DOS, you must use one or the other depending on your project type.
		- *getchar*, used by *gets*. Again, there are MSX-BASIC and MSX-DOS variants.
		- Simplified versions of *printf* and *sprintf*. Two variants are offered, with and without support for printing long (32 bit) numbers. By using these versions instead of the ones that come built-in with the SDCC Z80 library your program will be up to about 2K smaller (when using the variant without long support). See [the source code](https://github.com/Konamiman/MSX/blob/master/SRC/SDCC/char/printf_simple.c) for information about the supported format specifiers.

About the console functions and the standard Z80 library

SDCC comes with a Z80 version of the standard C library, located at *(SDCC folder)\\lib\\z80\\z80.lib*. This library already includes the *putchar*, *printf* and *sprintf* modules (but *putchar* is useless for MSX and *printf* is very big). By adding the filenames of the appropriate module (*.rel*) files from MSXCHAR to the compilation command line, the compiler will effectively use those modules instead of the built-in ones.

If you are going to always use the simplified *printf/sprintf* module, you can remove the built-in module from the standard library and add the simplified one, then you won't need to add the filename to the compilation command line every time. You can do that by using the *sdar* tool (part of the SDCC install):

```
sdar d <SDCC root>/lib/z80/z80.lib sprintf.rel
sdar d <SDCC root>/lib/z80/z80.lib vprintf.rel
sdar q <SDCC root>/lib/z80/z80.lib printf_simple.rel
```

You can also do the same with *putchar*, provided that you target either MSX-BASIC or MSX-DOS for all your developments.

- [CRT0 for MSX-DOS](https://www.konamiman.com/msx/sdcc/crt0_msxdos.zip): Startup code files that allow the generation of MSX-DOS executable files with SDCC. There are two versions, a short one that allows `void main()` only, and a more complex one that allows `int main(char** argv, int argc)`. See the header of the source code for usage details. *[\[Source code\]](https://github.com/Konamiman/MSX/tree/master/SRC/SDCC/crt0-msxdos)*
- [CRT0 for MSX-BASIC](https://github.com/Konamiman/MSX/blob/master/SRC/SDCC/crt0_msxbasic.asm): Startup code files that allow the generation of MSX-BASIC executable binary files with SDCC. You need to modify the ORG directive as appropriate for your project and assemble the file.
- [ASMLIB](https://www.konamiman.com/msx/sdcc/asmlib.zip): C library for assembler and UNAPI interop. This is a library that allows to execute arbitrary assembler code (for example, BIOS routines and MSX-DOS functions) from C code. It contains generic assembly interop functions and also functions to interact with [UNAPI](#unapi) implementations. *[\[Source code\]](https://github.com/Konamiman/MSX/tree/master/SRC/SDCC/asmlib)*
- [INLIB](https://www.konamiman.com/msx/sdcc/inlib.zip): C library for InterNestor Lite 1.x. This is a library of functions for accessing [InterNestor Lite 1.x](#inl1) capabilities from within Internet client applications made with SDCC.
	**Note:** This library is for InterNestor Lite 1.x only and **should not be used for new applications**. In order to develop applications that will work on InterNestor Lite 2.0+ (and on any other [TCP/IP UNAPI](#tcpipunapi) implementation), yo should use ASMLIB instead.
- [BASE64LIB](https://www.konamiman.com/msx/sdcc/base64lib.zip): C library for Base64 encoding and decoding. This is a library of functions for Base64 encoding and decoding any amount of binary data. *[\[Source code\]](https://github.com/Konamiman/MSX/tree/master/SRC/SDCC/base64lib)*
- [SHALIB](https://www.konamiman.com/msx/sdcc/sha1.lib): C library for SHA1 hashing. This is a library of functions for generating SHA1 and HMAC-SHA1 hashes of any amount of data. *[\[Source code\]](https://github.com/Konamiman/MSX/tree/master/SRC/SDCC/sha1lib)*

[Return to index](#index)

---

## Sunrise IDE tools

This section contains the tools that allow to flash [Nextor](#nextor) kernels in a Sunrise IDE or compatible controller. None of these has been made by me, but are published here for convenience with permission from the authors.

- [**IDEFL128.COM**](https://www.konamiman.com/msx/misc/IDE/IDEFL128.COM): A modified version of IDEFLOAD.COM, the Sunrise IDE flash ROM loader, that allows flashing 128K ROM files (the original IDEFLOAD tool flashes 64K files only). Use this tool for Sunrise IDE controllers. Tool developed by Jon De Schrijder.
- [**IDETB128.COM**](https://www.konamiman.com/msx/misc/IDE/IDETB128.COM): Use this tool for [Tecnobytes](http://www.tecnobytes.com.br/) IDE controllers. Tool developed by Tecnobytes (adapted from IDEFL128).
- [**CIDEB128.BAS**](https://www.konamiman.com/msx/misc/IDE/CIDEB128.BAS) and [**CIDEBIOS.BIN**](https://www.konamiman.com/msx/misc/IDE/CIDEBIOS.BIN): Use this tool for Ciel IDE controllers. Tool developed originally by Adriano Cunha, adapted to 128K ROMS by Piter Punk.
- [**README.TXT**](https://www.konamiman.com/msx/misc/IDE/README.TXT): Contains useful information about the above tools and the Nextor driver for IDE devices.

[Return to index](#index)

---

## Miscellaneous

Here you have some of the smaill utilities that I have developped along these years of obsolete programming, all of them for MSX2/2+/TR and most of them for MSX-DOS 2. I hope that some of them will be useful for you.

- [MEM.LZH](https://www.konamiman.com/msx/misc/mem.lzh): Small program that shows information about the total, allocated and free mapped memory, divided in slots. Requires standard mapper support routines to work.
- [CHCOPY2.LZH](https://www.konamiman.com/msx/misc/chcopy2.lzh): **Chapuza Copy 2.0.** Diskette copy utility that uses all the free RAM and the VRAM to minimize disk changes. Requires MSX-DOS 2 to work.
- [BOREHD.LZH](https://www.konamiman.com/msx/misc/borehd.lzh): **Boot Register for MSX with Hard Disk.** Executing this program from the AUTOEXEC.BAS of your hard disk you will be able to count how many times you have booted your computer from a given reference date, as well as the date and time of the last boot and the current boot. Requires MSX-DOS 2 to work.
- [RAMDD.LZH](https://www.konamiman.com/msx/misc/ramdd.lzh): **Registro de Arranque para MSX con Disco Duro.** Spanish version of BOREHD.
- [NAC11.LZH](https://www.konamiman.com/msx/misc/nac11.lzh): **NestorAcentos 1.1.** Resident program that allows the generation of vowels with tilde and other characters like ñ ¡ ¿ using the KANA key in japanese MSX computers.
- [NEM3-SCC.LZH](https://www.konamiman.com/msx/misc/nem3-scc.lzh): This is the Nemesis 3 SCC sound master files made by Martos a long time ago, but with one interisting modification: now you can switch on and off sepparately every SCC and PSG channel, as well as to pause the music. Useful to compose arrangements.
- **MKROMDSK 1.3**: Application that will be useful for those having a writable Flash ROM cartridge. It creates a ROM file from the contents of the RAM disk that exists when executing it. If this ROM file is burned on the Flash cartridge, when booting the computer a read-only disk drive will appear with all the files and directories that were present on the RAM disk. Besides, the resulting ROM incorporates the DOS 2 kernel.
	Version 1.3 corrects a bug that caused the generated ROMs not to work on machines without an already initialized MSX-DOS 2 kernel.
	MKROMDSK requires MSX-DOS 2 to work, and is composed of two files:
- [MKROMDSK.COM](https://www.konamiman.com/msx/misc/mkromdsk.com): The application executable file.
- [MKROMDSK.DAT](https://www.konamiman.com/msx/misc/mkromdsk.dat): Template used to generate ROM files. If you have a MSX-DOS 2.20 kernel image, you don't need to download this file, since MKROMDSK.COM can generate it from that image. (**NOTE:** kernel 2.30, present on MSX Turbo-R DiskROM, can **NOT** be used; it must be a 2.20 kernel).
- [**MKROMD1 1.0**](https://www.konamiman.com/msx/misc/mkromd1.com): This application is identical to MKROMDSK, excepto that generated ROMs incorporate the DOS 1 kernel instead of the DOS 2 kernel. This way, generated ROMs can be used on MSX2 with 64K RAM, or even on MSX1.
- [**Rookie Drive FDD ROM**](https://github.com/Konamiman/RookieDrive-FDD-ROM): This project implements a standard MSX-DOS 1 DiskROM that allows using standard USB floppy disk drives, thus effectively turning [Rookie Drive](http://rookiedrive.com/en) into an "old-school" MSX floppy disk controller with a few extra perks. The ROMs themselves (several variants are available) are in [the releases section](https://github.com/Konamiman/RookieDrive-FDD-ROM/releases).
- [**MSR.COM**](https://www.konamiman.com/msx/unapi/msr.com): Installs standard mapper support routines that are compatible with the one supplied by MSX-DOS 2 and [Nextor](#nextor). It also installs an [UNAPI](#unapi) compatible RAM helper.
- [**PMEXT 2.22**](https://www.konamiman.com/msx/misc/pmext.com): Not made by me, but may be useful for you. You can use this application to extract.LZH compressed files from MSX-DOS.

Not directly related to MSX but may be of interest for you:

- [Z80.NET](https://bitbucket.org/konamiman/z80dotnet): A Z80 simulator developed in C#. Useful as the core component to develop computer emulators or code debuggers, or to test small pieces of Z80 code.

[Return to index](#index)

---

## MSX2 Technical Handbook

This is the official technical reference of the MSX2 standard, edited by [ASCII corporation](http://www.ascii.co.jp/) in 1987, converted to text files. I typed all of it manually in 1997, using photocopies as reference (I had never seen the original book); I used about four months for the whole task. I have corrected some failures of the original text and I have added information about Turbo-BASIC.

- [INDEX.TXT](https://www.konamiman.com/msx/msx2th/index.txt): Index en english.
- [INDICE.TXT](https://www.konamiman.com/msx/msx2th/indice.txt): Index in spanish.
- [TH-1.TXT](https://www.konamiman.com/msx/msx2th/th-1.txt): Chapter 1, **MSX System Overview.**
- [TH-2.TXT](https://www.konamiman.com/msx/msx2th/th-2.txt): Chapter 2, **BASIC.**
- [TH-3.TXT](https://www.konamiman.com/msx/msx2th/th-3.txt): Chapter 3, **MSX-DOS.**
- [TH-4A.TXT](https://www.konamiman.com/msx/msx2th/th-4a.txt): Chapter 4, **VDP and display screen** (parts 1-5).
- [TH-4B.TXT](https://www.konamiman.com/msx/msx2th/th-4b.txt): Chapter 4, **VDP and display screen** (part 6).
- [TH-5A.TXT](https://www.konamiman.com/msx/msx2th/th-5a.txt): Chapter 5, **Access to peripherals through BIOS** (parts 1-6).
- [TH-5B.TXT](https://www.konamiman.com/msx/msx2th/th-5b.txt): Chapter 5, **Access to peripherals through BIOS** (part 7).
- [KUNBASIC.TXT](https://www.konamiman.com/msx/msx2th/kunbasic.txt): Turbo-BASIC reference manual.
- [TH-AP.TXT](https://www.konamiman.com/msx/msx2th/th-ap.txt): Appendices. Includes:
- Appendix 1 - BIOS listing
- Appendix 2 - MATH-PACK
- Appendix 3 - Bit Block Transfer
- Appendix 4 - Work Area Listing
- Appendix 5 - VRAM Map
- Appendix 6 - I/O Map
- Appendix 8 - Control Codes
- Appendix 10- Escape Sequences
- [TH.LZH](https://www.konamiman.com/msx/msx2th/th.lzh): All the files above packed into a single compressed file.
- [KUNESP.TXT](https://www.konamiman.com/msx/msx2th/kunesp.txt): Turbo-BASIC reference manual in spanish. Unknown author, sent by [Werner Augusto Roder Kai](mailto:wernerkai@mailcity.com) .

[Return to index](#index)

---

## Easymbler

Easymbler is a Z80 assembler course (but oriented to MSX, of course) that I wrote for the disk magazine Eurolink, published by MSX MEN (Ramón Ribas and Daniel Zorita) some years ago. The basic idea was that it had to be eay to understand and funny to read, and maybe with this last point I went too far... **Note: it is available in spanish only.** For this reason, the description of the downloadables below is left in spanish.

- [EASYMB1.TXT](https://www.konamiman.com/msx/easymbler/easymb1.txt): Primera entrega. **Introducción al código máquina. Descripción del Z80.**
- [EASYMB2.TXT](https://www.konamiman.com/msx/easymbler/easymb2.txt): Segunda entrega. **Instrucciones del Z80.**
- [EASYMB3.TXT](https://www.konamiman.com/msx/easymbler/easymb3.txt): Tercera entrega. **Introducción a los ensambladores y a la arquitectura del MSX. Técnicas básicas de programación.**
- [EASYMB4.TXT](https://www.konamiman.com/msx/easymbler/easymb4.txt): Cuarta entrega. **Funcionamiento y manejo de los slots del MSX.**
- [EASYMB5.TXT](https://www.konamiman.com/msx/easymbler/easymb5.txt): Quinta entrega. **La memoria mapeada del MSX.**

[Return to index](#index)

---

## InterNestor Suite project

I studied telecommunication engineering in [UPC](http://www.upc.es/), Barcelona, between 1993 and 2002. The final project I developped in order to obtain my degree had the title *"InterNestor Suite: design and implementation of a TCP/IP stack for MSX computers"* ; yes, it is the same InterNestor Suite you can download from this page.

Following is the project report I wrote and the presentantion I shown the exam day, december 11th 2002. By the way I obtained the maximum grade for this project.:-) **Note: it is available in spanish only.**

- [MEMINS.ZIP](https://www.konamiman.com/msx/insuite/memins.zip): Project report delivered to teachers in MS Word 97 format.
- [PRESINS.ZIP](https://www.konamiman.com/msx/insuite/presins.zip): Presentation shown the exam day in MS PowerPoint 97 format.

[Return to index](#index)

---

## MSX-UNAPI specification

*See also the [UNAPI project repository in GitHub](https://github.com/Konamiman/MSX-UNAPI-specification).*

MSX-UNAPI stands for *MSX unified API definition and discovery standard*. It is a proposal of a coding standard aimed to hardware and software developers.

When MSX hobbyists develop new hardware for MSX machines, they equip the devices with a ROM containing code that provides an API (Application Program Interface), a set of routines that are used by software applications in order to access the hardware. How this API is designed and implemented depends only on the hardware developer criteria, since there is not a standarized way to do it.

The MSX-UNAPI specification aims to provide a standarized way to *define, implement, discover and use* such APIs, so that devices with the same function made by different developers may have compatible APIs.

What's new in version 1.1

Now the UNAPI specification offers support for *specificationless applications*, that is, sotware applications that do not conform to any API standard but that make use of the remaining infrastructure offered by the UNAPI standard, especially the discovery procedure and the RAM helper. An example of specificationless application is a TSR that installs on a RAM segment.

Also, the RAM helper has been improved: it now offers a routine that allows calling an address on a RAM segment (not any address, but a predefined set of 64 addresses) with only five bytes of code. This allows to patch hooks so that they invoke code on a RAM segment without having to allocate space on page 3 (apart from the space for the RAM helper itself, which is installed only once).

Finally, installing the RAM helper is no longer mandatory for RAM based implementations: they have the option to refuse to install instead if no RAM helper is already installed.

It is easier than it seems (really!) and it can be really useful for hardware and software developers. If you are interested, here are the available documents about the MSX-UNAPI specification:

- [Introduction to the MSX-UNAPI specification](https://github.com/Konamiman/MSX-UNAPI-specification/blob/master/docs/Introduction%20to%20MSX-UNAPI.md): You better start reading this. It is a short text introducing the key concepts of the specification.
- [MSX-UNAPI specification v1.1](https://github.com/Konamiman/MSX-UNAPI-specification/blob/master/docs/MSX%20UNAPI%20specification%201.1.md): The complete specification, containing all the ugly details.
- Sample code: The source code of some fully working examples that may help you to understand the whole thing. The following files are available:
- [Sample implementation in ROM](https://github.com/Konamiman/MSX-UNAPI-specification/blob/master/examples/unapi-rom.asm).
- [Sample implementation in RAM](https://github.com/Konamiman/MSX-UNAPI-specification/blob/master/examples/unapi-ram.asm).
- [Sample implementation in a Nextor driver](https://github.com/Konamiman/MSX-UNAPI-specification/blob/master/examples/unapi-nextor.asm).
- [Sample specificationless application.](https://github.com/Konamiman/MSX-UNAPI-specification/blob/master/examples/unapi-specless.asm) It consists of a TSR that installs on a RAM segment and patches the timer interrupt hook to make the CAPS led blink.
- [Standalone RAM helper installer](https://github.com/Konamiman/MSX-UNAPI-specification/blob/master/tools/ramhelpr.asm). This source can also generate MSR.COM, the standard mapper support routines installer.
- [UNAPI implementations lister, a sample client software](https://github.com/Konamiman/MSX-UNAPI-specification/blob/master/tools/apilist.asm). *Client software* is the code that invokes API routines in order to perform some task with the hardware.
- SDCC library: If you prefer to program in C language, there is a library that will allow you to interact with UNAPI implementations from within applications developed with the SDCC compiler. See the [SDCC section](#sdcc).
- Utilities: UNAPI related applications that you may find useful:
- [Standalone RAM helper installer](https://www.konamiman.com/msx/unapi/ramhelpr.com). If you want standard mapper support routines to be installed too, use [MSR.COM](https://www.konamiman.com/msx/unapi/msr.com) instead.
- [UNAPI implementations lister](https://www.konamiman.com/msx/unapi/apilist.com).
- [Ethernet UNAPI implementations control program](https://www.konamiman.com/msx/unapi/eth.com). The source code is included in the [ASMLIB library](#sdcc) package.

The following are UNAPI compliant API specifications I have developed:

- [Ethernet UNAPI specification v1.1](https://github.com/Konamiman/MSX-UNAPI-specification/blob/master/docs/Ethernet%20UNAPI%20specification%201.1.md): The first UNAPI compliant API specification developed, aimed to Ethernet hardware developers.
- [TCP/IP UNAPI specification v1.1](https://github.com/Konamiman/MSX-UNAPI-specification/blob/master/docs/TCP-IP%20UNAPI%20specification.md): An API specification for TCP/IP stacks.

Ethernet vs TCP/IP UNAPIs

Developers of networking hardware (or rather, developers of BIOS software for networking hardware) can now choose between implementing the Ethernet UNAPI specification or the TCP/IP UNAPI specification.

Implementing the Ethernet UNAPI specification is simple and straighforward (there are just a few routines to implement) and is the best option when using simple hardware that cannot process TCP/IP by itself. However, in order to use networking software a TCP/IP stack such as [InterNestor Lite](#inl2) must be installed, which places the TCP/IP processing burden on the MSX itself.

On the other hand, implementing the TCP/IP UNAPI specification requires more work, but is the best option for complex hardware with embedded TCP/IP capabilities. In this case, no separate TCP/IP stack installation is required, and networking applications can be used right away.

Please take a look at the [InterNestor Lite](#inl2) section and the [networking software](#networking) section to find applications that make use of these specifications.

[Return to index](#index)

---

## Obsolete Procedure Call

*See also [the OPC repository at GitHub](http://github.com/konamiman/opc)*

Obsolete Procedure Call (OPC) is a protocol intended for performing remote access to a machine that is controlled (or simulates being controlled) by a Z80 processor. It can be useful for testing hardware without having to physically use the target computer (using a modern machine with modern tools instead), or to test Z80 code agains a real Z80-based system.

- [OPC protocol specification](https://github.com/Konamiman/OPC/blob/master/OPC.md)
- [OPC server v1.0](https://github.com/Konamiman/OPC/releases/download/v1.0.1/OPC.server.for.MSX.with.TCP.transport.zip): for MSX-DOS and MSX-BASIC, using TCP as transport (TCP/IP UNAPI).
- [OPC client library v1.0](https://github.com/Konamiman/OPC/releases/download/v1.0.1/OPC.client.library.for.NET.v1.0.zip): for.NET, includes a sample application that retrieves and shows system information from a MSX computer.

[Return to index](#index)

---

## What's new?

In this section the changes made to this page are listed in chronological order.

31 january 2023

- Added [InterNestor Lite 2.3](#inl2), [fixes an issue that caused some routers to ignore DHCP packets](https://github.com/Konamiman/MSX/pull/22).

28 november 2021

- SNTP.COM updated to v1.2, see [the pull request in GitHub](https://github.com/Konamiman/MSX/pull/13)
- NBASIC.BIN file is now actually v1.11, was v1.10 by mistake
- NestorBASIC English manual improved, see [the pull request in GitHub](https://github.com/Konamiman/MSX/pull/18)

1 august 2020

- Links updated to v2.1.0 in [the Nextor section](#nextor)

19 august 2019

- Added HGET 1.3, TFTP 1.1 and SNTP 1.1 to the [networking applications section](#networking).
- Added [InterNestor Lite 2.2](#inl2), it adds support for acting as a SOCKS5 client.
- [InterNestor Lite](#inl2) documentation text files removed, as now the documentation is in [the GitHub repository](https://github.com/Konamiman/MSX/tree/master/SRC/INL).
- Source code files links removed from the [networking applications section](#networking), as now all are available at [the GitHub repository](https://github.com/Konamiman/MSX/tree/master/SRC/NETWORK).

24 june 2019

- Published MSR.COM, the standard mapper support routines + UNAPI RAM helper installer, in the [miscellaneous](#miscelanea) section.
- All links to documents and sample code in the [UNAPI section](#unapi) now point to the [MSX-UNAPI repository in GitHub](https://github.com/Konamiman/MSX-UNAPI-specification).
- RAMHELPR.COM in the [UNAPI section](#unapi) updated to v1.2, it doesn't read from the mapper ports when no mapper support routines are availanle anymore.
- TCPIP.COM in the [networking section](#unapi) updated to v1.1, to be aware of the changes in v1.1 of the TCP/IP UNAPI specification.
- [InterNestor Lite](#inl2) for the Ethernet UNAPI updated to v2.1, it's now compliant with the TCP/IP UNAPI specification v1.1 and it now requires mapper support routines to be installed.
- Added the note about the discontinuation of [InterNestor Lite](#inl2) for RS-232.

15 may 2019

- Published [ObsoNET BIOS 1.3](#obsonet). This version solves a bug that caused crashes when using an external memory mappers.

29 april 2019

- Links updated to v2.1.0-beta 2 in [the Nextor section](#nextor)
- *crt0\_msxdos* in the [SDCC section](#sdcc) updated to properly handle initialization of global variables

8 february 2019

- Links updated to v2.1.0-beta 1 in [the Nextor section](#nextor)

1 december 2018

- Added the Rookie Drive FDD ROM on the [miscellaneous](#miscelanea) section.

20 september 2018

- Added Nextor 2.0.5 beta 1 and the link to [the Nextor project in GitHub](http://github.com/Konamiman/Nextor)

27 february 2018

- Added the link to [the copy of mato34.es](https://www.konamiman.com/mato34/index-e.html)

21 january 2018

- Links updated in the [OPC](#opc) section (server is now available for MSX-BASIC).

18 january 2018

- Added MKROMDSK 1.3 on the [miscellaneous](#miscelanea) section.

16 january 2018

Changes to the [SDCC section](#sdcc):

- Sources removed from the linked files, added links to the sources in GitHub (except for INLIB).
- MSXCHAR library replaced with a ZIP file containing the module files (and there are now two variants of printf, with sources available).
- Explanation about how to handle the standard SDCC Z80 library updated.
- The AsmCall function (part of ASMLIB) does not modify itself anymore, therefore it's now ROM friendly.
- Added CRT0 for MSX-BASIC.

1 january 2018

- Added the [OPC](#opc) section.
- Links to repositories in BitBucket replaced with links to the new repositories in GitHub.
- Links to the discussion sites removed.
- Link to InterNestor Lite in SourceForge removed.
- Profile links updated.

15 march 2015

- Added Nextor 2.1 Alpha 2 in the [Nextor](#nextor) section.
- Added the [Sunrise IDE tools](#ide) section.

2 february 2015

- Added a link to [Konamiman's software discussion site](http://konamiman.bitbucket.org/).

21 november 2014

- Added a link to the [MSX software repository](http://www.bitbucket.org/konamiman/msx).

15 october 2014

- Added Nextor 2.0.4 and 2.1 Alpha 1b in the [Nextor](#nextor) section.
- Added a reference to the Z80.NET project in the [Miscellaneous](#miscelanea) section.
- Added Patreon as a new donation method in [the donations section](#donate).

9 may 2014

- Added Nextor 2.0.3, together with updated versions of the Getting Started guide, the User Manual and the Programmers Reference, in the [Nextor](#nextor) section.
- Added [the Volume Size Fix Tool](#vsft) in the [Nextor](#nextor) section.
- CRT0 for MSXDOS fixed (it contained unusable.REL files) in the [SDCC section](#sdcc).

8 april 2014

- Added Nextor 2.0.2, together with a corrected version of the Getting Started guide, in the [Nextor](#nextor) section.
- Added Flattr as a new donation method in [the donations section](#donate).

4 april 2014

- Added [the donations section](#donate).
- Added Nextor 2.0.1, together with a new version of MKNEXROM and the Driver Development guide, in the [Nextor](#nextor) section.
- Added Nextor 2.1 Alpha 1 in the [Nextor](#nextor) section.

12 february 2014

- Added Nextor 2.0 final, plus the source code for FDISK and the tools, in the [Nextor](#nextor) section.

1 february 2014

- Added MSX trivial dropbox 1.1 to the [networking applications section](#networking).
- Added versions 1.1 of PING and TCPCON to the [networking applications section](#networking).
- Added DenyoNet TCP/IP UNAPI BIOS 0.6, its alternative version, the DENYINIT.COM tool and the note for Panasonic FS-A1 GT users to the [DenYoNet section](#denyonet).

1 july 2013

- Added Nextor 2.0 Beta 2 in the [Nextor](#nextor) section.

1 march 2013

- Added Nextor 2.0 Beta 1 in the [Nextor](#nextor) section.
- Added the MegaFlashROM SCC+ SD version of the Nextor kernel in the [Nextor](#nextor) section.

1 september 2011

- Added Nextor 2.0 Alpha 2b in the [Nextor](#nextor) section.
- The Sunrise IDE driver for [Nextor](#nextor) has been updated.
- Added the IDEFL128.COM tool in the [miscellaneous](#miscelanea) section.

1 august 2011

- Added Nextor 2.0 Alpha 2b and the Nextor Getting Started Guide in the [Nextor](#nextor) section.
- Corrected the links to the online documentation in the [Nextor](#nextor) section, they no longer require logging in to a Google acount for being viewed.

1 july 2011

- Added the [Nextor](#nextor) section, with version 2.0 Alpha 1.

26 may 2011

- Published [ObsoNET BIOS 1.2](#obsonet). This version solves a bug that caused some computers to hang when trying to access the floppy disk drive.
- Published [Denyonet TCP/IP UNAPI BIOS 0.5 and Ethernet UNAPI BIOS 1.5](#denyonet). These versions solve the same bug as ObsoNET BIOS 1.2.
- Corrected the BIOSDOS2.ROM file ([Obsonet section](#obsonet)), which was corrupted.

8 april 2011

- Added ObsoFTP 1.0, ObsoSMB 1.0 and the disk image containing all the networking applications to the [networking applications section](#networking).

4 february 2011

- Added HGET 1.1 and MSX trivial dropbox to the [networking applications section](#networking).
- Added PMEXT.COM to the [miscellaneous section](#miscelanea).

10 january 2011

- Added HGET and GETURL to the [networking applications section](#networking).
- Added the TCP/IP UNAPI BIOS 0.4 to the [DenYoNet section](#denyonet).

2 september 2010

- Added the MSXCHAR, CRT0\_MSX, SHA1 and BASE64 libraries at the [SDCC section](#sdcc).
- Added the [TCP/IP UNAPI specification](#tcpipunapi) to the [UNAPI section](#unapi).
- [InterNestor Lite 1](#inl1) is now discontinued, but still available for download.
- Added [InterNestor Lite 2](#inl2), which has its own section, separated from InterNestor Lite 1.
- Added the [networking applications section](#networking), with the TCP/IP UNAPI version of the old INL 1 applications (PING, TCP console, TFTP, FTP) and four new applications: a SNTP client, MSX trivial tweeter, the Ethernet UNAPI control program, and the TCP/IP UNAPI control program. All with source code.
- Added the [DenYoNet section](#denyonet), with the flash ROM loader, Ethernet UNAPI BIOS 1.4, and TCP/IP UNAPI BIOS 0.1.

23 february 2010

- Added the [SDCC section](#sdcc), with two libraries: the already existing INLIB, and the new ASMLIB.
- Added the Ethernet UNAPI implementations control program in the [UNAPI section](#unapi).

19 february 2010

- The [Ethernet UNAPI RAM helper](#unapi) stepped to version 1.1. This version does not destroy the contents of the SHELL environment item, thus avoiding "Wrong version of COMMAND" errors.

11 february 2010

- The [Ethernet UNAPI specification](#unapi) stepped to version 1.1.

4 february 2010

- The [MSX-UNAPI specification](#unapi) stepped to version 1.1.
- Added the standalone RAM helper and the sample TSR on the [UNAPI section](#unapi).
- Added links to SourceForge.net on the [UNAPI section](#unapi) and the [InterNestor Lite section](#inl1).

14 september 2007

- Published [InterNestor Lite 1.1.1](#inl1).

12 september 2007

- The [MSX-UNAPI specification](#unapi) stepped to version 1.0.
- Published the [Ethernet UNAPI specification](#unapi).
- Published [ObsoNET BIOS 1.1](#obsonet).
- Published [InterNestor Lite 1.1](#inl1). Now both InterNestor Lite versions (for serial port and for Ethernet) are distributed in a single package. Also, now there is one single user manual for both versions.
- Published the source code of [InterNestor Lite](#inl1).
- InterNestor Lite for ObsoNET is now discontinued. It has been replaced by InterNestor Lite for Ethernet.

25 july 2007

- Added the [MSX-UNAPI section](#unapi).

29 june 2007

- Yep, the main page has disappeared. It was not useful anyway. If you want to know more about me and can read spanish, [visit my blog](http://konamiman.blogspot.com/) .
- This page is now XHTML compliant, and uses CSS for the presentation (which is still very simple anyway). See the nice banners at the end of the page.
- References to Dumas have been temporarily removed. The project is currently frozen but ~~I hope that~~ not dead.

18 may 2006

- Added a link to [**Konamiman's blog**](http://konamiman.blogspot.com/) (in spanish).

21 april 2006

- Removed the ObsoNET status page and added the Dumas project information page.

5 december 2005

- Removed the link to ILAC (InterNestor Lite Applications Contest) until I decide whether I re-open it or not.

10 september 2005

- Added MKROMDSK 1.2 and MKROMD1 1.0 on the [miscellaneous](#miscelanea) section.

24 april 2005

- Added InterNestor Lite 1.02 on both the [InterNestor Lite](#inl1) section and the [ObsoNET](#obsonet) section.
- Added version 1.01 of the FTP application on the [InterNestor Lite](#inl1) section.

31 march 2005

- Added the FTP application on the [InterNestor Lite](#inl1) section.
- Added the [Software for ObsoNET](#obsonet) section.
- Added MKROMDSK 1.1 on the [miscellaneous](#miscelanea) section.

22 december 2004

- Added the MKROMDSK application on the [miscellaneous](#miscelanea) section.

6 december 2004

- Added [NestorBASIC 1.11](#nestorbasic), also the sample program TCPCON-L on TCPCON.LZH has been updated.

5 december 2004

- Added [InterNestor Lite 1.0](#inl1) and the INLIB library.

20 august 2004

- Added the ILAC '04 page.

19 august 2004

- Added the ObsoNET page.

7 july 2004

- Added the fourth beta of [InterNestor Lite](#inl1).

15 june 2004

- Added version 1.10 of [NestorBASIC](#nestorbasic).

5 june 2004

- Added the third beta of [InterNestor Lite](#inl1).

6 january 2004

- Added the second beta of [InterNestor Lite](#inl1).

1 october 2003

- Added the first beta of [InterNestor Lite](#inl1).

7 july 2003

- Inauguration of the new look of the page, both the main page and the MSX page.
- Released [NestorBASIC 1.0](#nestorbasic) and the new sample program TCPCON.
- Released the university's [report and presentation](#proyectointernestor) of InterNestor Suite.

[Return to index](#index)

---