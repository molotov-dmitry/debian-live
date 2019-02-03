#!/bin/bash

ROOT_PATH="$(cd "$(dirname "$0")" && pwd)"
cd "${ROOT_PATH}" || exit 1

lb config \
	--distribution stretch \
	--architecture amd64 \
	--debian-installer live \
	--binary-images iso-hybrid \
	--debconf-frontend dialog \
	--chroot-filesystem squashfs \
	--parent-mirror-bootstrap 'http://mirror.yandex.ru/debian/' \
	--parent-mirror-binary 'http://mirror.yandex.ru/debian/' \
	--mirror-bootstrap 'http://mirror.yandex.ru/debian/' \
	--mirror-binary 'http://mirror.yandex.ru/debian/' \
	--archive-areas "main non-free contrib" \
	--apt-options "--force-yes --yes" \
	--mode debian \
	--system live \
	--firmware-binary true

mkdir -p config/package-lists/

echo "task-gnome-desktop" > config/package-lists/desktop.list.chroot
