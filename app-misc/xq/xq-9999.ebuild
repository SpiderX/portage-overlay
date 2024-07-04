# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/sibprogrammer/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Command-line JSON processor for binary data"
HOMEPAGE="https://github.com/sibprogrammer/xq"

LICENSE="MIT"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	COMMIT="$(git log -n 1 --format='%h')"
	LDFLAGS="-X main.version=${PV} -X \"main.date=${DATE}\" -X main.commit=${COMMIT}"

	ego build -ldflags "${LDFLAGS}" -trimpath
}

src_test() {
	ego test -v ./...
}

src_install() {
	einstalldocs
	dobin xq
	newman docs/xq.man xq.1
}
