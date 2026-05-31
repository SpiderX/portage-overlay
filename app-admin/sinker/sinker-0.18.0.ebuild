# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Sync images from one container registry to another"
HOMEPAGE="https://github.com/plexsystems/sinker"
SRC_URI="https://github.com/plexsystems/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

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
