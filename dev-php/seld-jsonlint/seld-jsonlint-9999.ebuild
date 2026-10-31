# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_AUTOLOAD="src/Seld/JsonLint"
COMPOSER_INSTALL_PATH="Seld/JsonLint"

inherit composer git-r3

DESCRIPTION="JSON Lint for PHP"
HOMEPAGE="https://github.com/Seldaek/jsonlint"
EGIT_REPO_URI="https://github.com/Seldaek/jsonlint.git"

LICENSE="MIT"
SLOT="0"

PATCHES=( "${FILESDIR}/${PN}"-1.12.1-cli-autoload.patch )

EPHPUNIT_BOOTSTRAP="vendor/autoload.php"
EPHPUNIT_ARGS=( --no-configuration tests )
composer_enable_tests phpunit

src_install() {
	composer_src_install
	dobin bin/jsonlint
}
