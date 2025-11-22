# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="Server for resizing and converting remote images"
HOMEPAGE="https://github.com/imgproxy/imgproxy"
EGIT_REPO_URI="https://github.com/imgproxy/${PN}.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # fails

RDEPEND="media-libs/vips:0="
BDEPEND="virtual/pkgconfig"

DOCS=( {CHANGELOG,README}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_prepare() {
	default

	sed -i '/vips7compat.h/d' vips/vips.h || die "sed failed"
}

src_compile() {
	ego build
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin imgproxy
}
