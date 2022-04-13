# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/rs/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="The power of curl, the ease of use of httpie"
HOMEPAGE="https://github.com/rs/curlie"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	LDFLAGS="-X main.version=${PV} -X \"main.date=${DATE}\""

	go build -ldflags "${LDFLAGS}" -o bin/curlie || die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin bin/curlie
}
