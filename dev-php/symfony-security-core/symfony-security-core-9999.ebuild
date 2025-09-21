# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Symfony Security Core Component"
HOMEPAGE="https://github.com/symfony/security-core"
EGIT_REPO_URI="https://github.com/symfony/security-core.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-event-dispatcher-contracts
	dev-php/symfony-password-hasher
	dev-php/symfony-service-contracts"
BDEPEND="test? ( dev-php/phpunit
		dev-php/symfony-dependency-injection
		dev-php/symfony-expression-language
		dev-php/symfony-http-foundation
		dev-php/symfony-phpunit-bridge
		dev-php/symfony-translation
		dev-php/symfony-validator )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	# skipped 4
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Security/Core
	doins -r Authentication Authorization Event Exception \
		Resources Role Signature Test User Validator ./*.php
}
