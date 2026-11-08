# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module tmpfiles

DESCRIPTION="A private Certificate Authority for internal (lab) use"
HOMEPAGE="https://github.com/hakwerk/labca"
SRC_URI="https://github.com/hakwerk/labca/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"
S="${WORKDIR}/${P}/gui"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="acct-group/labca
	acct-user/labca"

src_compile() {
	LDFLAGS="-w -X main.standaloneVersion=${PV}"
	ego build -ldflags "${LDFLAGS}" -tags standalone -o labca-gui
}

src_test() {
	ego test ./...
}

src_install() {
	dobin labca-gui
	diropts -o labca -g labca
	keepdir /var/log/labca
	newinitd "${FILESDIR}"/labca.initd labca
	newconfd "${FILESDIR}"/labca.confd labca
	newtmpfiles "${FILESDIR}"/labca.tmpfile labca.conf
}

pkg_postinst() {
	tmpfiles_process labca.conf
}
