# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_AUTOLOAD="src/Seld/JsonLint"

inherit composer

DESCRIPTION="JSON Lint for PHP"
HOMEPAGE="https://github.com/Seldaek/jsonlint"
SRC_URI="https://github.com/Seldaek/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=( "${FILESDIR}/${PN}"-1.12.1-cli-autoload.patch )

EPHPUNIT_BOOTSTRAP="vendor/autoload.php"
EPHPUNIT_ARGS=( --no-configuration tests )
COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-1.12.1-phpunit12.patch )
composer_enable_tests phpunit

src_install() {
	composer_src_install
	dobin bin/jsonlint
}
