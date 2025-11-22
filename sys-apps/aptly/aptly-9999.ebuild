# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo git-r3 go-module shell-completion systemd

DESCRIPTION="A swiss army knife for Debian repository management"
HOMEPAGE="https://github.com/aptly-dev/aptly"
EGIT_REPO_URI="https://github.com/aptly-dev/${PN}.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # needs etcd

RDEPEND="acct-group/aptly
	acct-user/aptly"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_prepare() {
	default

	# set version (mian.go)
	edo echo "${PV}" > VERSION
}

src_compile() {
	ego build -o cmd/aptly
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin cmd/aptly
	doman man/aptly.1
	dobashcomp completion.d/aptly
	dozshcomp completion.d/_aptly
	systemd_dounit "${FILESDIR}"/aptly-api.service
	systemd_dounit "${FILESDIR}"/aptly.service
	newinitd "${FILESDIR}"/aptly.initd aptly
	newconfd "${FILESDIR}"/aptly.confd aptly
	newinitd "${FILESDIR}"/aptly-api.initd aptly-api
	newconfd "${FILESDIR}"/aptly-api.confd aptly-api

	diropts -o aptly -g aptly -m 0700
	keepdir /etc/aptly
	insopts -o aptly -g aptly -m 0644
	insinto /etc/aptly
	doins "${FILESDIR}"/aptly.conf
}
