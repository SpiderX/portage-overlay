# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Network problems simulator"
HOMEPAGE="https://github.com/tylertreat/comcast"
SRC_URI="https://api.github.com/repos/tylertreat/${PN}/tarball/0465cfc -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # needs pf

S="${WORKDIR}/tylertreat-${PN}-0465cfc"

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
