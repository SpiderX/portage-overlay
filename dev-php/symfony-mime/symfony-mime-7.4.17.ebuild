# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/Mime"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Symfony MIME Component"
HOMEPAGE="https://github.com/symfony/mime"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/symfony-deprecation-contracts
	dev-php/symfony-polyfill-intl-idn
	dev-php/symfony-polyfill-mbstring"
BDEPEND="test? ( dev-php/egulias-email-validator
		dev-php/league-html-to-markdown
		dev-php/phpdocumentor-reflection-docblock
		dev-php/symfony-dependency-injection
		dev-php/symfony-phpunit-bridge
		>=dev-php/symfony-process-7
		dev-php/symfony-property-access
		dev-php/symfony-property-info
		dev-php/symfony-serializer )"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-7.4.17-tests.patch )
composer_enable_tests phpunit
