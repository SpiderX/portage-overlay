# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMPOSER_INSTALL_PATH="Doctrine/DBAL"
PHP_REQ_USE="pdo,mysql?,postgres?,sqlite?"

inherit composer optfeature

DESCRIPTION="Doctrine Database Abstraction Layer"
HOMEPAGE="https://github.com/doctrine/dbal"
SRC_URI="https://github.com/doctrine/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-patches.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="mysql postgres sqlite"
REQUIRED_USE="test? ( mysql postgres sqlite )"

RDEPEND="dev-php/doctrine-deprecations
	dev-php/psr-cache
	dev-php/psr-log"
BDEPEND="test? ( dev-php/symfony-cache
		dev-php/symfony-console )"

EPHPUNIT_BOOTSTRAP='vendor/autoload.php'
COMPOSER_TEST_PATCHES=( "${WORKDIR}/${P}-patches/tests" )
composer_enable_tests phpunit

pkg_postinst() {
	optfeature "Support of helpful console commands such as SQL execution" dev-php/symfony-console
}
