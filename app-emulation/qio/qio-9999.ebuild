# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/gamelinux/${PN}.git"

inherit git-r3

DESCRIPTION="QEMU Init OpenRC"
HOMEPAGE="https://github.com/SpiderX/qio"
SRC_URI=""

LICENSE="MIT"
SLOT=0
KEYWORDS=""

RDEPEND="!app-emulation/qemu-init-scripts
	app-emulation/qemu
	net-misc/socat"

src_install() {
	newinitd qemu.initd qemu
	newconfd qemu.confd qemu
	dosym qemu /etc/init.d/kvm
}
