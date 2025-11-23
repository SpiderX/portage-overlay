# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo git-r3 go-module

DESCRIPTION="Network problems simulator"
HOMEPAGE="https://github.com/tylertreat/Comcast"
EGIT_REPO_URI="https://github.com/tylertreat/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
	sed -i '/require/d' "${S}"/go.mod || die "sed failed"
	edo touch "${S}"/go.sum
	go-module_live_vendor
}

src_compile() {
	ego build -o comcast -ldflags "-X main.version=${PV}"
}

src_install() {
	einstalldocs
	dobin comcast
}
