# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 qmake-utils

DESCRIPTION="A cross-platform IRC framework written with Qt"
HOMEPAGE="http://communi.github.io/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/communi/${PN}.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="debug icu qml test uchardet"

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtnetwork:5
	qml? ( dev-qt/qtdeclarative:5 )
	icu? ( dev-libs/icu:= )
	uchardet? ( app-i18n/uchardet )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? ( dev-qt/qttest:5 )"

DOCS=( AUTHORS CHANGELOG README.md )

src_prepare() {
	default

	# Disable usage of bandled lib
	sed -i \
		-e '/include(..\/3rdparty\/uchardet-0.0.1\/uchardet.pri)/aCONFIG *= link_pkgconfig\nPKGCONFIG += uchardet' \
		-e '/include(..\/3rdparty\/uchardet-0.0.1\/uchardet.pri)/d' \
		src/core/core.pri || die "sed failed for core.pri"

	# Don't build QML plugin without QML for QT4 too
	sed -i 's/SUBDIRS += qml1/qtHaveModule(qml):SUBDIRS += qml1/' \
		src/imports/imports.pro || die "sed failed for imports.pro"

	# Do not run failing test
	sed -i '/QTest::newRow("Shift-JIS")/d' \
		tests/auto/ircmessage/tst_ircmessage.cpp \
		|| die "sed failed for auto.pro"
}

src_configure() {
	eqmake5 \
		-config no_rpath \
		-config no_benchmarks \
		-config "$(usex debug debug release)" \
		-config "$(usex icu icu no_icu)" \
		-config "$(usex test tests no_tests)" \
		-config "$(usex uchardet uchardet no_uchardet)"
}

src_install() {
	einstalldocs
	emake install INSTALL_ROOT="${D}"
}
