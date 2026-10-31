# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="TheSeer/DirectoryScanner"

inherit composer

DESCRIPTION="A recursive directory scanner and filter"
HOMEPAGE="https://github.com/theseer/DirectoryScanner"
SRC_URI="https://github.com/theseer/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="dev-php/theseer-Autoload"

PATCHES=( "${FILESDIR}/${PN}"-1.3.3-tests.patch
	"${FILESDIR}/${PN}"-1.3.3-tests-phpunit.xml.patch )

composer_enable_tests phpunit

src_prepare() {
	default

	edo phpab -q -o src/autoload.php -t fedora2 src

	# rename legacy test files to match PHPUnit 12 test discovery conventions
	mv tests/directoryscanner.test.php tests/DirectoryScannerTest.php || die
	mv tests/phpfilter.test.php tests/PHPFilterIteratorTest.php || die
}

src_test() {
	ephpunit
}
