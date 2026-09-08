# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="SebastianBergmann/Comparator"
PHP_MIN_VER="8.3"
PHP_REQ_USE="bcmath?,xml,unicode"

inherit composer

DESCRIPTION="Compare PHP values for equality"
HOMEPAGE="https://github.com/sebastianbergmann/comparator"
SRC_URI="https://github.com/sebastianbergmann/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bcmath"
REQUIRED_USE="test? ( bcmath )"

RDEPEND="dev-php/sebastian-diff
	dev-php/sebastian-exporter"
BDEPEND="dev-php/theseer-Autoload"

DOCS=( {ChangeLog,README}.md )

EPHPUNIT_BOOTSTRAP='vendor/autoload.php'
composer_enable_tests phpunit

src_prepare() {
	composer_src_prepare

	edo phpab -q -o src/autoload.php -t fedora2 src
}

src_test() {
	composer_prepare_tests
	edo phpab -q -o tests/autoload.php -t fedora2 tests
	ephpunit
}
