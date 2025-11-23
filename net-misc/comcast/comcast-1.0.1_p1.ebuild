# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo go-module

COMMIT="145d02155cffc03bb4ed878c9d6441dc49f3cdaa"

DESCRIPTION="Network problems simulator"
HOMEPAGE="https://github.com/tylertreat/comcast"
SRC_URI="https://github.com/tylertreat/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # needs pf

src_unpack() {
	default
	sed -i '/require/d' "${S}"/go.mod || die "sed failed"
	edo touch "${S}"/go.sum
}

src_compile() {
	ego build -o comcast -ldflags "-X main.version=${PV}"
}

src_install() {
	einstalldocs
	dobin comcast
}
