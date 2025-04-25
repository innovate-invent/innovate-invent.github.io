---
title: Decapitating GPT
excerpt: Using hexdump to parse GPT headers
published: true
tags: [ GPT, partition table, hexdump, bash, linux, disk, disk image, deserialize ]
at_url: at://did:plc:gdfkbwgnydyn4xgea7e7e6ht/app.bsky.feed.post/3lnni3cbyts2w
---

I found a need to parse GPT headers directly from a potentially corrupt or truncated disk
image. [`sgdisk`](https://man.archlinux.org/man/sgdisk.8) makes a best effort when printing out the table, but its
output is hard to parse. [`sfdisk`](https://man7.org/linux/man-pages/man8/sfdisk.8.html) provides very nice output
options but fails to read an image that doesn't have both the header and trailer GPT tables. I also wanted access to the
GUID and CRC values for some additional logic.

```shell 
$ sgdisk -p disk.img
Disk /dev/nvme0n1: 1000215216 sectors, 476.9 GiB
Model: SAMSUNG MZVL2512HCJQ-00BH1              
Sector size (logical/physical): 512/512 bytes
Disk identifier (GUID): 50BA123A-641E-419F-AE95-93E722FBAE66
Partition table holds up to 128 entries
Main partition table begins at sector 2 and ends at sector 33
First usable sector is 34, last usable sector is 1000215182
Partitions will be aligned on 2048-sector boundaries
Total free space is 2669 sectors (1.3 MiB)

Number  Start (sector)    End (sector)  Size       Code  Name
   1            2048            4095   1024.0 KiB  EF02  
   2            4096          503807   244.0 MiB   EF00  EFI System Partition
   3          503808         8503295   3.8 GiB     8300  
   4         8503296      1000214527   472.9 GiB   8300  
```

Looking around for what in my environment would allow me to parse the table myself in a declaritive way without having
to munge bytes myself, I found hexdump. It provides a way to convert binary data to human-readable, or more importantly,
machine parseable output.

[hexdump](https://man7.org/linux/man-pages/man1/hexdump.1.html) from util-linux version 2.37.2 is what I have. You may
encounter reimplementations of it for other OSs with different features.

Wikipedia provides a nice reference for the data layout of
the [GPT table](https://en.wikipedia.org/wiki/GUID_Partition_Table). I am not going to go into detail on the table
layout here, I encourage you to have a look. I will note that GPT refers
to [LBA](https://en.wikipedia.org/wiki/Logical_block_addressing)s, which are (generally) 512 byte chunks/sectors/blocks
that it divides the block device into.

Hexdump can accept a format string describing how to parse and print the binary data. It borrows from
the [`printf`](https://man7.org/linux/man-pages/man3/fprintf.3.html) token scheme. The format string is composed of a
chain of space separated "format units" that describe how to deserialize the data and print it. Each unit is composed of
two numbers and a double-quoted string containing the printf token (`[c/b] "%s"`). Either number is optional, but if
provided must include the `/` to distinguish which one you are providing. The first number is a count of the number of
times to repeat the format unit. The second number is a count of the bytes to consume for each iteration. The string can
only contain a single printf `%` token. You can think of it like for each count of bytes it passes it to the printf
function
with the bytes as a single argument.

hexdumps behaviour for when it consumes bytes or not from the input stream is inconsistent and seems to depend on the
state it is in from the previous format unit. Generally I have found if the string doesn't contain a printf token, it
doesn't consume bytes from the stream regardless of the numbers preceding the token. This is specifically true when you
provide the empty string to try and discard bytes (`1/4 ""`). It doesn't seem to work and I just needed to print the
bytes in a way that could be ignored. The exception seems to be if it is the last format unit.

hexdump also allows you to provide a file that contains the format string rather than trying to manage it on the command
line. The way it handles the file is a bit odd. Each line in the file is used to format the input, meaning multiple
lines will repeatedly output the same input file from the beginning rather than allow you to have a single format string
spanning multiple lines.

For your copy-pasta delight I have provided three files:

Copy the following into a file named `gpt_header`

```bash
#!/usr/bin/env -S bash -c 'hexdump -v -s$(( ${BLOCK_SIZE:-512} * ${OFFSET_LBA:-1} )) -n${BLOCK_SIZE:-512} -f <(tail -n +2 $0 | tr "\n" " ") $1'

"Signature='" 8/1 "%1_u" "'\n" 
"Header_Revision=" 2/2 "%u" "\n" 
"Header_Size=" 1/4 "%u" "\n" 
"Header_CRC32='" 1/4 "%x" "'\n"
"#Reserved" 1/4 "%d\n"
"Current_LBA=" 1/8 "%u" "\n"
"Backup_LBA=" 1/8 "%u" "\n"
"First_usable_LBA=" 1/8 "%u" "\n"
"Last_usable_LBA=" 1/8 "%u" "\n"
"Disk_GUID='" 1/4 "%08X-" 2/2 "%04X-" 2/1 "%02X" "-" 6/1 "%02X" "'\n"
"Partition_Entries_LBA=" 1/8 "%u" "\n"
"Partition_Max_Count=" 1/4 "%u" "\n"
"Partition_Entry_Size=" 1/4 "%u" "\n"
"Partition_Entries_CRC32='" 1/4 "%x" "'\n"
1/420 ""
```

Copy the following into a file named `gpt_entries`

```bash
#!/usr/bin/env -S bash -c 'hexdump -v -s$(( ${BLOCK_SIZE:-512} * ( ${OFFSET_LBA:-1} + 1 ) )) -n$(( ${LIMIT:-128} * 128 )) -f <(tail -n +2 $0 | tr "\n" " ") $1'

1/4 "%08X-" 2/2 "%04X-" 2/1 "%02X" "-" 6/1 "%02X" "\t"
1/4 "%08X-" 2/2 "%04X-" 2/1 "%02X" "-" 6/1 "%02X" "\t"
1/8 "%u" "\t"
1/8 "%u" "\t"
1/8 "%08x" "\t"
72/1 "%1_p" "\n"
```

You will see that I have included a shebang in the files allowing you to `chmod +x gpt_header gpt_entries` and execute
the files directly rather than having to manage separate bash scripts. The shebangs also include a workaround that
allows a single format string to span multiple lines for easier reading. Each script is passed a single argument, the
path to the disk image or block device.

If for whatever reason your disk has a sector size other than 512 bytes you can set an env
variable `BLOCK_SIZE=<your sector size>`. If whatever partitioned your disk did not put the GPT header at LBA 1, you can
specify the offset (in LBAs) via the `OFFSET_LBA=<your GPT offset>` env variable. `gpt_entries` also allows you to
specify a limit on the number of entries it lists via the `LIMIT=` env variable.

What always surprises me is the number of people who do not know you can inline environment variables for any executable
command by putting their declaration before the executable path.

For example, rather than

```bash
export BLOCK_SIZE=512
export OFFSET_LBA=1
export LIMIT=3
./gpt_entries disk.img
```

You can simply write it like this and the variables will be set within the `./gpt_entries` execution environment.

```bash
BLOCK_SIZE=512 OFFSET_LBA=1 LIMIT=3 ./gpt_entries disk.img
```

### Obligatory example outputs

```shell
$ ./gpt_header disk.img 
Signature='EFI PART'
Header_Revision=01
Header_Size=92
Header_CRC32='c87f96b0'
#Reserved0
Current_LBA=1
Backup_LBA=1000215215
First_usable_LBA=34
Last_usable_LBA=1000215182
Disk_GUID='50BA123A-641E-419F-AE95-93E722FBAE66'
Partition_Entries_LBA=2
Partition_Max_Count=128
Partition_Entry_Size=128
Partition_Entries_CRC32='1c30552d'
```

```shell
$ ./gpt_entries disk.img | head
21686148-6449-6E6F-744E-656564454649	D0269D3E-2390-4536-97CD-D1E1F2DAD9D2	      2048	      4095	00000000	........................................................................
C12A7328-F81F-11D2-BA4B-00A0C93EC93B	E2FFD449-0A42-4613-8110-2FB7FF137BF8	      4096	    503807	00000000	E.F.I. .S.y.s.t.e.m. .P.a.r.t.i.t.i.o.n.................................
0FC63DAF-8483-4772-8E79-3D69D8477DE4	A6A09F63-13E2-401D-B450-5816661E4E45	    503808	   8503295	00000000	........................................................................
0FC63DAF-8483-4772-8E79-3D69D8477DE4	0BC98C47-894A-461E-A033-CB99D3D2E93A	   8503296	1000214527	00000000	........................................................................
00000000-0000-0000-0000-000000000000	00000000-0000-0000-0000-000000000000	         0	         0	00000000	........................................................................
00000000-0000-0000-0000-000000000000	00000000-0000-0000-0000-000000000000	         0	         0	00000000	........................................................................
00000000-0000-0000-0000-000000000000	00000000-0000-0000-0000-000000000000	         0	         0	00000000	........................................................................
00000000-0000-0000-0000-000000000000	00000000-0000-0000-0000-000000000000	         0	         0	00000000	........................................................................
00000000-0000-0000-0000-000000000000	00000000-0000-0000-0000-000000000000	         0	         0	00000000	........................................................................
00000000-0000-0000-0000-000000000000	00000000-0000-0000-0000-000000000000	         0	         0	00000000	........................................................................
```

Unfortunately hexdump can't format UTF16 encoded strings, so you get `.` for each null byte in the label.

Note, there is nothing stopping you from re-working these scripts to output as JSON or any format you like.

For completeness, here is a bash script that brings everything together and cleans up the output.

```bash
#!/usr/bin/bash

set -eu

BLOCK_SIZE=${BLOCK_SIZE:-512}
OFFSET_LBA=${OFFSET_LBA:-1}

disk="${1?'You must provide the path to the GPT disk as the first argument'}"
src="$(dirname ${BASH_SOURCE[0]})"

source <($src/gpt_header $disk)

# Validate header info
[[ $Signature == 'EFI PART' ]] || {
  echo "Unexpected header signature: $Signature"
  exit 1
}

[[ $Header_Revision == 01 ]] || {
  echo "Unexpected GPT revision: $Header_Revision"
  exit 1
}

dd="dd if=$disk of=/dev/stdout bs=1 status=none"
# The CRC field needs to be zero'd for the calculation
calculatedCRC=$(cat <($dd skip=$(( OFFSET_LBA * BLOCK_SIZE )) count=16) <(head -c4 /dev/zero) <($dd skip=$(( (OFFSET_LBA * BLOCK_SIZE) + 20 )) count=72) | crc32 /dev/stdin)
[[ $calculatedCRC == $Header_CRC32 ]] || {
  echo "Unexpected header CRC: expected $Header_CRC32 got $calculatedCRC"
  exit 1
}

$src/gpt_header $disk

# List partition entries filtering out unused entries and remove the null bytes from the labels
echo # blank line
fmt='% 36s % 36s % 10s % 10s % 10s %s\n'
printf "$fmt" 'Type GUID' 'Partition GUID' 'Start LBA' 'Last LBA' 'Attributes' 'Label'
$src/gpt_entries $disk | grep -v '^00000000-0000-0000-0000-000000000000' | sed -e "s/^/'/g;s/\t/' '/g;s/$/'/g" | tr -d '.' | xargs -l printf "$fmt"
```

Output

```shell
$ ./dumpgpt.sh disk.img 
Signature='EFI PART'
Header_Revision=01
Header_Size=92
Header_CRC32='c87f96b0'
#Reserved0
Current_LBA=1
Backup_LBA=1000215215
First_usable_LBA=34
Last_usable_LBA=1000215182
Disk_GUID='50BA123A-641E-419F-AE95-93E722FBAE66'
Partition_Entries_LBA=2
Partition_Max_Count=128
Partition_Entry_Size=128
Partition_Entries_CRC32='1c30552d'

                           Type GUID                       Partition GUID  Start LBA   Last LBA Attributes Label
21686148-6449-6E6F-744E-656564454649 D0269D3E-2390-4536-97CD-D1E1F2DAD9D2       2048       4095   00000000 
C12A7328-F81F-11D2-BA4B-00A0C93EC93B E2FFD449-0A42-4613-8110-2FB7FF137BF8       4096     503807   00000000 EFI System Partition
0FC63DAF-8483-4772-8E79-3D69D8477DE4 A6A09F63-13E2-401D-B450-5816661E4E45     503808    8503295   00000000 
0FC63DAF-8483-4772-8E79-3D69D8477DE4 0BC98C47-894A-461E-A033-CB99D3D2E93A    8503296 1000214527   00000000 
```

I hope you have found this informative on the use of hexdump, bash, and general parsing of binary data like GPT headers.
Here is a bonus script that I created to extract a partition image from a disk image. There are better utilities that
already exist to do this but this was a proof-of-concept for a more complex system.

```bash
#!/usr/bin/env bash
# Use: ./dumppartition 'E2FFD449-0A42-4613-8110-2FB7FF137BF8' disk.img part.img
set -eu -o pipefail

BLOCK_SIZE=${BLOCK_SIZE:-512}
OFFSET_LBA=${OFFSET_LBA:-1}

search="${1?"The first argument must be either a GUID or disk label to search for"}"
disk="${2?'You must provide the path to the GPT disk as the second argument'}"
out="${3?"The third argument must be a path to write the partition"}"
src="$(dirname ${BASH_SOURCE[0]})"

source <($src/gpt_header $disk)

# Validate header info
[[ $Signature == 'EFI PART' ]] || {
  echo "Unexpected header signature: $Signature"
  exit 1
}

[[ $Header_Revision == 01 ]] || {
  echo "Unexpected GPT revision: $Header_Revision"
  exit 1
}

dd="dd if=$disk of=/dev/stdout bs=1 status=none"
# The CRC field needs to be zero'd for the calculation
calculatedCRC=$(cat <($dd skip=$(( OFFSET_LBA * BLOCK_SIZE )) count=16) <(head -c4 /dev/zero) <($dd skip=$(( (OFFSET_LBA * BLOCK_SIZE) + 20 )) count=72) | crc32 /dev/stdin)
[[ $calculatedCRC == $Header_CRC32 ]] || {
  echo "Unexpected header CRC: expected $Header_CRC32 got $calculatedCRC"
  exit 1
}

found="$($src/gpt_entries $disk | grep -v '^00000000-0000-0000-0000-000000000000' | tr -d '.' | grep -m1 -F "$search")" || {
  echo "No matching partition found"
  exit 1
}

startLBA=$(cut -f3 <<<"$found")
lastLBA=$(cut -f4 <<<"$found")

dd if=$disk of=$out skip=$startLBA count=$(( lastLBA - startLBA + 1 )) bs=$BLOCK_SIZE
```