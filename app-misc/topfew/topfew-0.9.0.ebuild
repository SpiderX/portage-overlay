# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="Finds most often fields in a stream of records"
HOMEPAGE="https://github.com/timbray/topfew"
SRC_URI="https://github.com/timbray/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	go build -o tf || die "build failed"
}

src_test() {
	go test -v ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin tf
	doman doc/tf.1
}
