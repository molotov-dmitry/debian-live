#!/bin/bash

ROOT_PATH="$(cd "$(dirname "$0")" && pwd)"
cd "${ROOT_PATH}" || exit 1

lb config \
	--distribution buster \
	--architecture amd64 \
	--debian-installer live \
	--binary-images iso-hybrid \
	--debconf-frontend dialog \
	--chroot-filesystem squashfs \
	--apt-options "--force-yes --yes" \
	--mode debian \
	--system live \
	--firmware-binary true \
	--archive-areas "main non-free contrib"
#	--parent-mirror-bootstrap 'http://mirror.yandex.ru/debian/' \
#	--parent-mirror-binary 'http://mirror.yandex.ru/debian/' \
#	--mirror-bootstrap 'http://mirror.yandex.ru/debian/' \
#	--mirror-binary 'http://mirror.yandex.ru/debian/'

mkdir -p config/package-lists

echo "task-gnome-desktop" > config/package-lists/desktop.list.chroot
echo "debian-installer-launcher" > config/package-lists/installer.list.chroot
