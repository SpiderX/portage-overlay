# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMPOSER_INSTALL_PATH="Symfony/Component/Uid"
COMPOSER_INSTALL_SRC="."

inherit composer optfeature

DESCRIPTION="Object-oriented API to generate and represent UIDs"
HOMEPAGE="https://github.com/symfony/uid"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/symfony-polyfill-uuid"
BDEPEND="test? ( dev-php/doctrine-deprecations
		dev-php/pecl-ds
		dev-php/symfony-console
		dev-php/symfony-deprecation-contracts
		dev-php/symfony-phpunit-bridge )"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-7.4.17-tests.patch )
composer_enable_tests phpunit

pkg_postinst() {
	optfeature "PHP extention with uuid" dev-php/pecl-uuid
}
