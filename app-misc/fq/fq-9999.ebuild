# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/wader/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Command-line JSON processor for binary data"
HOMEPAGE="https://github.com/wader/fq"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

DOCS=( {CHANGES,README}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-s -w"

	go build -ldflags "${LDFLAGS}" -trimpath || die "build failed"
}

src_test() {
	emake test
}

src_install() {
	einstalldocs
	dobin fq
}
