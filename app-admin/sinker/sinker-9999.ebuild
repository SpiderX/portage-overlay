# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/plexsystems/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Sync images from one container registry to another"
HOMEPAGE="https://github.com/plexsystems/sinker"

LICENSE="MIT"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-X github.com/plexsystems/sinker/internal/commands.sinkerVersion=${PV}"
	ego build -ldflags="${LDFLAGS}"
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin sinker
}
