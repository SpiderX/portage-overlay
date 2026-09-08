# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_AUTOLOAD="src/JsonSchema"
COMPOSER_INSTALL_PATH=""
PHP_REQ_USE="curl?"

inherit composer git-r3

DESCRIPTION="JSON Schema for PHP"
HOMEPAGE="https://github.com/jsonrainbow/json-schema"
EGIT_REPO_URI="https://github.com/jsonrainbow/json-schema.git"
SRC_URI="https://github.com/SpiderX/portage-overlay/releases/download/${PN}-6.11.0/${PN}-6.11.0-patches.tar.xz"

LICENSE="MIT"
SLOT="0"
IUSE="curl"
REQUIRED_USE="test? ( curl )"

RDEPEND="!dev-php/json-schema
	dev-php/marc-mabe-php-enum"
BDEPEND="test? ( dev-php/json-schema-test-suite )"

PATCHES=( "${WORKDIR}/${PN}-6.11.0-patches/tests" )

composer_enable_tests phpunit

src_unpack() {
	git-r3_src_unpack
	unpack ${A}
}

src_prepare() {
	composer_src_prepare

	edo mkdir -p vendor/json-schema
	edo ln  -s ../../../../../../../../../../usr/share/php/json-schema-test-suite vendor/json-schema
}
