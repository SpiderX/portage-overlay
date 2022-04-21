# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils

DESCRIPTION="A cross-platform IRC framework written with Qt"
HOMEPAGE="https://communi.github.io"
SRC_URI="https://github.com/communi/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug icu qml test uchardet"
REQUIRED_USE="?? ( icu uchardet )"
RESTRICT="!test? ( test )"

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtnetwork:5
	qml? ( dev-qt/qtdeclarative:5 )
	icu? ( dev-libs/icu:= )
	uchardet? ( app-i18n/uchardet )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	test? ( dev-qt/qttest:5 )"

DOCS=( {CHANGELOG,README}.md )

src_configure() {
	eqmake5 \
		-config no_rpath \
		-config no_benchmarks \
		-config no_examples \
		-config "$(usex debug debug release)" \
		-config "$(usex icu icu no_icu)" \
		-config "$(usex qml qml no_qml)" \
		-config "$(usex test tests no_tests)" \
		-config "$(usex uchardet uchardet no_uchardet)"
}

src_install() {
	einstalldocs
	emake install INSTALL_ROOT="${D}"
}
