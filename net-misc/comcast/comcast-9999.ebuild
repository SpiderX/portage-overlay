# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 golang-base

DESCRIPTION="Network problems simulator"
HOMEPAGE="https://github.com/tylertreat/Comcast"
EGIT_REPO_URI="https://github.com/tylertreat/Comcast.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-lang/go:0="
DEPEND="${RDEPEND}"

# Use local path instead of url
PATCHES=( "${FILESDIR}"/${PN}-1.0.1-build.patch )

src_compile() {
	GOPATH="${S}:$(get_golibdir_gopath)" go build -v -ldflags \
		"-X main.version=${PV}" -x -work ${PN}.go || die "build failed"
}

src_install() {
	default

	GOBIN="${D}/usr/bin/" go install -v -ldflags \
		"-X main.version=${PV}" -x -work ${PN}.go || die "install failed"
}
