# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="nikic/PHPFuzzer"
COMPOSER_PKG="PHP-Fuzzer"
PHP_REQ_USE="pcntl"

inherit composer git-r3

DESCRIPTION="Experimental fuzzer for PHP libraries"
HOMEPAGE="https://github.com/nikic/php-fuzzer"
EGIT_REPO_URI="https://github.com/nikic/php-fuzzer.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-php/nikic-include-interceptor
	dev-php/nikic-php-parser
	dev-php/ulrichsg-getopt-php"

PATCHES=( "${FILESDIR}/${PN}"-0.0.11-tests.patch )

composer_enable_tests phpunit

src_install() {
	composer_src_install
	# install files into COMPOSER_INSTALL_PATH
	dobin bin/php-fuzzer
}
