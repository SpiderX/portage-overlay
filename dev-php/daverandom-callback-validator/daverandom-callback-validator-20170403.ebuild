# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_PKG="CallbackValidator"
COMPOSER_INSTALL_PATH="DaveRandom/CallbackValidator"

inherit composer

COMMIT="d87a08cddbc6099816ed01e50ce25cdfc43b542f"

DESCRIPTION="Tools for validating callback signatures in PHP"
HOMEPAGE="https://github.com/DaveRandom/CallbackValidator"
SRC_URI="https://github.com/DaveRandom/${COMPOSER_PKG}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${COMPOSER_PKG}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-php/phpunit )"

PATCHES=( "${FILESDIR}/${PN}"-20170403-BasePhp71Test.patch
	"${FILESDIR}/${PN}"-20170403-phpunit.xml.patch )

src_test() {
	ephpunit
}
