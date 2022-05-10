#!/bin/bash

ROOT_PATH="$(cd "$(dirname "$0")" && pwd)"
cd "${ROOT_PATH}" || exit 1

set -e

lb clean --all

lb config \
	--distribution testing \
	--architecture amd64 \
	--debian-installer live \
	--binary-images iso-hybrid \
	--debconf-frontend dialog \
	--chroot-filesystem squashfs \
	--apt-options "--force-yes --yes" \
	--mode debian \
	--system live \
	--firmware-binary true \
        --parent-debian-installer-distribution daily \
	--archive-areas "main non-free contrib" \
	--parent-mirror-bootstrap 'http://mirror.yandex.ru/debian/' \
	--parent-mirror-binary 'http://mirror.yandex.ru/debian/' \
	--mirror-bootstrap 'http://mirror.yandex.ru/debian/' \
	--mirror-binary 'http://mirror.yandex.ru/debian/'

mkdir -p config/package-lists

echo 'linux-headers-generic firmware-linux-free amd64-microcode firmware-iwlwifi firmware-linux firmware-linux-nonfree firmware-misc-nonfree firmware-sof-signed intel-microcode' > config/package-lists/kernel.list.chroot
echo 'grub-common grub2-common grub-pc grub-pc-bin grub-efi-ia32-bin grub-efi-amd64-bin' > config/package-lists/boot.list.chroot
echo 'task-gnome-desktop task-laptop laptop-mode-tools cups foomatic-db-compressed-ppds rsync' > config/package-lists/core.list.chroot

lb build

mv -f live-image-amd64.hybrid.iso /media/documents/Distrib/OS/debian-testing-gnome-amd64.iso
