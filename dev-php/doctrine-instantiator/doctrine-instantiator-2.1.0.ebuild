# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_AUTOLOAD="src/Doctrine/Instantiator"
COMPOSER_INSTALL_PATH=""
PHP_REQ_USE="pdo"

inherit composer

DESCRIPTION="Doctrine Instantiator"
HOMEPAGE="https://github.com/doctrine/instantiator"
SRC_URI="https://github.com/doctrine/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-2.1.0-tests.patch )
composer_enable_tests phpunit

src_test() {
	edo composer create-project --ignore-platform-req=php -q --no-install --prefer-source \
		"${COMPOSER_PN}:${PV}" "${COMPOSER_SRC}"
	edo cp -r "${COMPOSER_SRC}"/{phpunit.xml.dist,tests} "${S}"
	composer_test_patch
	ephpunit
}
