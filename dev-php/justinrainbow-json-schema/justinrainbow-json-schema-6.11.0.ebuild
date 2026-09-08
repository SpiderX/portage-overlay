# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_AUTOLOAD="src/JsonSchema"
COMPOSER_INSTALL_PATH=""
PHP_REQ_USE="curl?"

inherit composer

DESCRIPTION="JSON Schema for PHP"
HOMEPAGE="https://github.com/jsonrainbow/json-schema"
SRC_URI="https://github.com/jsonrainbow/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-patches.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="curl"
REQUIRED_USE="test? ( curl )"

RDEPEND="!dev-php/json-schema
	dev-php/marc-mabe-php-enum"
BDEPEND="test? ( dev-php/json-schema-test-suite )"

COMPOSER_TEST_PATCHES=( "${WORKDIR}/${P}-patches/tests" )
composer_enable_tests phpunit

src_test() {
	composer_prepare_tests
	edo mkdir -p vendor/json-schema
	edo ln  -s ../../../../../../../../../../usr/share/php/json-schema-test-suite vendor/json-schema
	ephpunit
}
