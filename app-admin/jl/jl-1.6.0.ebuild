# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A tool for working with structured JSON logging"
HOMEPAGE="https://github.com/koenbollen/jl"
SRC_URI="https://github.com/koenbollen/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	ego build
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin jl
}
