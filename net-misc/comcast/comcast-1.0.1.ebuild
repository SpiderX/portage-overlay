# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/tylertreat/comcast"

inherit golang-base

DESCRIPTION="Network problems simulator"
HOMEPAGE="https://github.com/tylertreat/comcast"
SRC_URI="https://github.com/tylertreat/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Use local path instead of url
PATCHES=( "${FILESDIR}"/"${P}"-build.patch )

src_compile() {
	go build -o comcast -ldflags "-X main.version=${PV}" \
		|| die "build failed"
}

src_install() {
	einstalldocs
	dobin comcast
}
