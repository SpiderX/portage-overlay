# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Finds most often fields in a stream of records"
HOMEPAGE="https://github.com/timbray/topfew"
SRC_URI="https://github.com/timbray/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	ego build -o tf
}

src_test() {
	ego test -v ./...
}

src_install() {
	einstalldocs
	dobin tf
	doman doc/tf.1
}
