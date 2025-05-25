# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module tmpfiles

DESCRIPTION="A private Certificate Authority for internal (lab) use"
HOMEPAGE="https://github.com/hakwerk/labca"
EGIT_REPO_URI="https://github.com/hakwerk/${PN}.git"
S="${WORKDIR}/${P}/gui"

LICENSE="MPL-2.0"
SLOT="0"

RDEPEND="acct-group/labca
	acct-user/labca"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-w -X main.standaloneVersion=${PV}"

	ego build -ldflags "${LDFLAGS}" -tags standalone \
		-o labca-gui
}

src_test() {
	ego test -work ./...
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
