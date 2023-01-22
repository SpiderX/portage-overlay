# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/olav-st/${PN}.git"
PYTHON_COMPAT=( python3_{8..11} )

inherit cmake git-r3 python-single-r1 xdg

DESCRIPTION="Screenshot capturing and sharing tool over various services"
HOMEPAGE="https://screencloud.net"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="dev-libs/quazip
	>=dev-python/PythonQt-3.2[${PYTHON_SINGLE_USEDEP},extensions]
	dev-qt/qtmultimedia:5[widgets]
	dev-qt/qtconcurrent:5
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	dev-qt/qtxml:5"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	dev-libs/openssl:0="

PATCHES=( "${FILESDIR}/${P}"-python-link.patch
	"${FILESDIR}/${P}"-install.patch )

src_prepare() {
	# Corrent finding QuaZip
	sed -i  -e '/FIND_LIBRARY/s/quazip-qt5/quazip1-qt5/' \
		-e '/PATH_SUFFIXES/s| include/quazip$| include/QuaZip-Qt5-1.2/quazip include/QuaZip-Qt5-1.3/quazip|' \
		-e '/FIND_PACKAGE_HANDLE_STANDARD_ARGS/s|quazip|QuaZip|' \
		cmake/modules/FindQuaZip.cmake || die "sed failed for FindQuaZip.cmake"

	cmake_src_prepare
}
