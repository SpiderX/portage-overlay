# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Symfony PasswordHasher Component"
HOMEPAGE="https://github.com/symfony/password-hasher"
EGIT_REPO_URI="https://github.com/symfony/password-hasher.git"

LICENSE="MIT"
SLOT="0"
IUSE="argon2 sodium test"
REQUIRED_USE="test? ( argon2 sodium )"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[argon2?,sodium?]
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/phpunit
		dev-php/symfony-console
		dev-php/symfony-security-core )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	# skipped — testBcryptWithNulByteWithNativePasswordHash
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/PasswordHasher
	doins -r Command Exception Hasher ./*.php
}
