# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/tylertreat/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Network problems simulator"
HOMEPAGE="https://github.com/tylertreat/Comcast"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

src_prepare() {
	default

	sed -i '/require/d' go.mod || die "sed failed"
	touch go.sum || die "touch failed"
}

src_compile() {
	go build -o comcast -ldflags "-X main.version=${PV}" \
		|| die "build failed"
}

src_install() {
	einstalldocs
	dobin comcast
}
