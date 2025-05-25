# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit fcaps git-r3 go-module systemd tmpfiles

DESCRIPTION="A private certificate authority and ACME server"
HOMEPAGE="https://github.com/smallstep/certificates"
EGIT_REPO_URI="https://github.com/smallstep/certificates.git"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="acct-group/step
	acct-user/step
	sys-apps/pcsc-lite"

DOCS=( {CHANGELOG,README}.md )

FILECAPS=( cap_net_bind_service+ep usr/bin/step-ca )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	LDFLAGS="-w -X main.Version=${PV} -X \"main.BuildTime=${DATE}\""

	ego build -ldflags "${LDFLAGS}" ./cmd/...
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin step-ca
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
