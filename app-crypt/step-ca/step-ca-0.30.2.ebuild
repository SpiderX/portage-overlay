# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo fcaps go-module systemd tmpfiles

DESCRIPTION="A private certificate authority and ACME server"
HOMEPAGE="https://github.com/smallstep/certificates"
SRC_URI="https://github.com/smallstep/certificates/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"
S="${WORKDIR}/certificates-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="utils"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="acct-group/step
	acct-user/step
	sys-apps/pcsc-lite"
BDEPEND=">=dev-lang/go-1.25.0"

DOCS=( {CHANGELOG,README}.md )

FILECAPS=( cap_net_bind_service+ep usr/bin/step-ca )

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	LDFLAGS="-w -X main.Version=${PV} -X \"main.BuildTime=${DATE}\""

	ego build -ldflags "${LDFLAGS}" ./cmd/...

	if use utils ; then
		edo pushd scripts/badger-migration
		ego build -o badger-migration
		edo popd
	fi
}

src_test() {
	ego test ./...
}

src_install() {
	einstalldocs
	dobin step-ca
	use utils && dobin scripts/badger-migration/badger-migration
	diropts -o step -g step
	keepdir /var/log/step-ca
	newinitd "${FILESDIR}"/step-ca.initd step-ca
	newconfd "${FILESDIR}"/step-ca.confd step-ca
	systemd_dounit systemd/step-ca.service
	newtmpfiles "${FILESDIR}"/step-ca.tmpfile step-ca.conf
}

pkg_postinst() {
	tmpfiles_process step-ca.conf
	fcaps_pkg_postinst
}
