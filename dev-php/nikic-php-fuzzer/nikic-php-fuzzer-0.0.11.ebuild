# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="nikic/PHPFuzzer"
COMPOSER_PKG="PHP-Fuzzer"
PHP_REQ_USE="pcntl"

inherit composer

DESCRIPTION="Experimental fuzzer for PHP libraries"
HOMEPAGE="https://github.com/nikic/php-fuzzer"
SRC_URI="https://github.com/nikic/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-php/nikic-include-interceptor
	dev-php/nikic-php-parser
	dev-php/ulrichsg-getopt-php"
BDEPEND="test? ( dev-php/phpunit )"

PATCHES=( "${FILESDIR}/${PN}"-0.0.11-bin.patch
	"${FILESDIR}/${PN}"-0.0.11-tests.patch )

src_test() {
	ephpunit
}

src_install() {
	composer_src_install
	# install files into COMPOSER_INSTALL_PATH
	dobin bin/php-fuzzer
}
