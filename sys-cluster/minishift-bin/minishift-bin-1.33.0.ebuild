# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/-bin/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Single Node OpenShift Cluster"
HOMEPAGE="https://github.com/minishift/minishift"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/releases/download/v${PV}/${MY_P}-linux-amd64.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${MY_P}-linux-amd64"

QA_PREBUILT="usr/bin/minishift"

src_install() {
	dobin minishift
}

pkg_postinst() {
	elog "You may want to install the following optional dependency:"
	elog "  app-emulation/virtualbox or app-emulation/virtualbox-bin"
}
