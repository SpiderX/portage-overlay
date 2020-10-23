# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/plexsystems/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Sync images from one container registry to another"
HOMEPAGE="https://github.com/plexsystems/sinker"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-X github.com/plexsystems/sinker/internal/commands.sinkerVersion=${PV}"
	go build -ldflags="${LDFLAGS}" || die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin sinker
}
