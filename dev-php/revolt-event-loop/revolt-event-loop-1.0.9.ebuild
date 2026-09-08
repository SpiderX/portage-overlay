# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Revolt"

inherit composer

DESCRIPTION="Event loop for concurrent PHP applications"
HOMEPAGE="https://github.com/revoltphp/event-loop"
SRC_URI="https://github.com/revoltphp/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="test? ( dev-php/pecl-ev
		dev-php/pecl-event
		dev-php/pecl-uv )"

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-1.0.9-tests-DriverTest.patch
	"${FILESDIR}/${PN}"-1.0.9-tests-phpunit.xml.patch
	"${FILESDIR}/${PN}"-1.0.9-tests-StreamSelectDriverTest.patch
	"${FILESDIR}/${PN}"-1.0.9-tests-TracingDriverTest.patch )
composer_enable_tests phpunit
