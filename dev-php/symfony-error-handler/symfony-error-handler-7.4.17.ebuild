# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/ErrorHandler"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Tools to manage errors and ease debugging PHP code"
HOMEPAGE="https://github.com/symfony/error-handler"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/psr-log
	dev-php/symfony-polyfill-php85
	dev-php/symfony-var-dumper"
BDEPEND="test? ( dev-php/doctrine-deprecations
		dev-php/symfony-console
		dev-php/symfony-deprecation-contracts
		dev-php/symfony-http-kernel
		dev-php/symfony-phpunit-bridge
		dev-php/symfony-serializer )"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-7.4.17-tests.patch )
composer_enable_tests phpunit

src_install() {
	composer_src_install

	exeinto /usr/share/php/"${COMPOSER_INSTALL_PATH}"/Resources/bin
	doexe Resources/bin/patch-type-declarations
}
