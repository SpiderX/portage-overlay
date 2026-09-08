# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMPOSER_INSTALL_PATH="Doctrine/Deprecations"

inherit composer optfeature

DESCRIPTION="Doctrine Deprecations"
HOMEPAGE="https://github.com/doctrine/deprecations"
SRC_URI="https://github.com/doctrine/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="test? ( dev-php/psr-log )"

COMPOSER_TEST_FILES=( test_fixtures )
composer_enable_tests phpunit

pkg_postinst() {
	optfeature "Logging deprecations via PSR-3 logger" dev-php/psr-log
}
