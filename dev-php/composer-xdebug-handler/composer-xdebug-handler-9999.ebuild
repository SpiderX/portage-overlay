# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Composer/XdebugHandler"

inherit composer git-r3

DESCRIPTION="Restart a CLI process without loading the xdebug extension"
HOMEPAGE="https://github.com/composer/xdebug-handler"
EGIT_REPO_URI="https://github.com/composer/xdebug-handler.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-php/composer-pcre
	dev-php/psr-log"

# XDEBUG_MODE=debug overrides xdebug.mode=off in the test subprocess
EPHPUNIT_EXCLUDE_FILTER='testNoRestartWhenModeOff'
COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-3.0.5-tests-EnvironmentTest.patch
	"${FILESDIR}/${PN}"-3.0.5-tests-IniFilesTest.patch
	"${FILESDIR}/${PN}"-3.0.5-tests-PhpConfigTest.patch
	"${FILESDIR}/${PN}"-3.0.5-tests-RestartTest.patch
	"${FILESDIR}/${PN}"-3.0.5-tests-SettingsTest.patch )
composer_enable_tests phpunit

src_test() {
	composer_prepare_tests
	XDEBUG_MODE=debug ephpunit
}
