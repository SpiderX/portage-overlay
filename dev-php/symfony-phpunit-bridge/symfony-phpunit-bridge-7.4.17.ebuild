# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Bridge/PhpUnit"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Symfony PHPUnit Bridge"
HOMEPAGE="https://github.com/symfony/phpunit-bridge"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="test? ( dev-php/doctrine-deprecations
		dev-php/symfony-deprecation-contracts
		dev-php/symfony-error-handler )"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-7.4.17-tests.patch )
composer_enable_tests phpunit

src_install() {
	composer_src_install

	doins bin/simple-phpunit.php
	exeinto /usr/share/php/"${COMPOSER_INSTALL_PATH}"
	doexe bin/simple-phpunit
	dosym ../share/php/"${COMPOSER_INSTALL_PATH}"/simple-phpunit \
		/usr/bin/simple-phpunit
}
