# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/muesli/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Disk Usage/Free Utility"
HOMEPAGE="https://github.com/muesli/duf"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	COMMIT="$(git rev-parse --short HEAD)"
	LDFLAGS="-s -w -X main.Version=${PV} -X main.CommitSHA=${COMMIT}"

	go build -ldflags "${LDFLAGS}" -trimpath || die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin duf
	doman duf.1
}
