# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="QEMU Init OpenRC"
HOMEPAGE="https://github.com/SpiderX/qio"
EGIT_REPO_URI="https://github.com/gamelinux/${PN}.git"

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
