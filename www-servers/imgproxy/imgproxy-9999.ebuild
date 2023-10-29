# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/imgproxy/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Server for resizing and converting remote images"
HOMEPAGE="https://github.com/imgproxy/imgproxy"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

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
	ego build -buildmode=pie -trimpath
}

src_install() {
	einstalldocs
	dobin imgproxy
}
