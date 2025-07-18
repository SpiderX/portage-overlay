# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="QEMU Init OpenRC"
HOMEPAGE="https://github.com/SpiderX/qio"
SRC_URI="https://github.com/SpiderX/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64 ~x86"

RDEPEND="!app-emulation/qemu-init-scripts
	app-emulation/qemu
	net-misc/socat"

src_install() {
	newinitd qemu.initd qemu
	newconfd qemu.confd qemu
	dosym qemu /etc/init.d/kvm
}
