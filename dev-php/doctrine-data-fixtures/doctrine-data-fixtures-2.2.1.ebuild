# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMPOSER_INSTALL_PATH="Doctrine/Common/DataFixtures"
PHP_REQ_USE="pdo,sqlite?"

inherit composer optfeature

DESCRIPTION="Doctrine Data Fixtures Extension"
HOMEPAGE="https://github.com/doctrine/data-fixtures"
SRC_URI="https://github.com/doctrine/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="sqlite"
REQUIRED_USE="test? ( sqlite )"

RDEPEND="dev-php/doctrine-persistence
	dev-php/psr-log"
BDEPEND="test? ( dev-php/doctrine-dbal
		dev-php/doctrine-orm
		dev-php/symfony-cache
		dev-php/symfony-var-exporter )"

EPHPUNIT_BOOTSTRAP='vendor/autoload.php'
composer_enable_tests phpunit

pkg_postinst() {
	optfeature "Loading ORM fixtures" dev-php/doctrine-orm
}
