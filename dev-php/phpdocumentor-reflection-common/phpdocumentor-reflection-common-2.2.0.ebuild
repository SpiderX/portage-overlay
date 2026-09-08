# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_AUTOLOAD="src/Common"
COMPOSER_INSTALL_PATH="phpDocumentor/Reflection"

inherit composer

DESCRIPTION="phpDocumentor ReflectionCommon component"
HOMEPAGE="https://github.com/phpDocumentor/ReflectionCommon"
SRC_URI="https://github.com/phpDocumentor/${COMPOSER_PKG/-/}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ReflectionCommon-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-2.2.0-tests.patch )
composer_enable_tests phpunit
