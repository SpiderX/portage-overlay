# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_P="release-v${PV}"

inherit autotools toolchain-funcs

DESCRIPTION="LibYAML binding for Lua"
HOMEPAGE="https://github.com/gvvaughan/lyaml"
SRC_URI="https://github.com/gvvaughan/${PN}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/lua:0
	dev-libs/libyaml"
DEPEND="${RDEPEND}
	sys-devel/libtool"

S="${WORKDIR}/${PN}-${MY_P}"

src_prepare() {
	default
	eautoreconf
}

src_compile() {
	emake CC="$(tc-getCC)"
}
