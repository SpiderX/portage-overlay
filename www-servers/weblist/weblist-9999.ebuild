# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module shell-completion systemd

COMMIT="dcf8b70"

DESCRIPTION="A modern, elegant file browser for the web"
HOMEPAGE="https://github.com/umputun/weblist"
EGIT_REPO_URI="https://github.com/umputun/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="acct-group/weblist
	acct-user/weblist"
BDEPEND=">=dev-lang/go-1.26.1:="

src_unpack() {
	git-r3_src_unpack
}

src_compile() {
	DATE="$(date -u '+%Y%m%dT%H%M%S')"
	LDFLAGS="-w -X \"main.revision=${PV} (master-${COMMIT}-${DATE})\""

	GOFLAGS="-v -x -mod=vendor" \
		ego build -ldflags "${LDFLAGS}" -o weblist
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" ego test -work ./...
}

src_install() {
	einstalldocs
	dobin weblist
	diropts -o weblist -g weblist
	keepdir /var/log/weblist
	newbashcomp completions/weblist.bash weblist
	newfishcomp completions/weblist.fish weblist
	newzshcomp completions/weblist.zsh _weblist
	newinitd "${FILESDIR}"/weblist.initd weblist
	newconfd "${FILESDIR}"/weblist.confd weblist
	systemd_dounit "${FILESDIR}"/weblist.service
}
