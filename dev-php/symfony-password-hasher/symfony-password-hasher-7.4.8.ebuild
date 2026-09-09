# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/PasswordHasher"
COMPOSER_INSTALL_SRC="."
PHP_REQ_USE="argon2?,sodium?"

inherit composer

DESCRIPTION="Symfony PasswordHasher Component"
HOMEPAGE="https://github.com/symfony/password-hasher"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="argon2 sodium"
REQUIRED_USE="test? ( argon2 sodium )"

BDEPEND="test? ( dev-php/symfony-console
		dev-php/symfony-security-core )"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-7.4.8-tests-NativePasswordHasherTest.patch
	"${FILESDIR}/${PN}"-7.4.8-tests-SodiumPasswordHasherTest.patch )
composer_enable_tests phpunit
