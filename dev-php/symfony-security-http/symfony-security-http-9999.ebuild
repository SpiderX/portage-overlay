# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Symfony Security HTTP Component"
HOMEPAGE="https://github.com/symfony/security-http"
EGIT_REPO_URI="https://github.com/symfony/security-http.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-http-foundation
	dev-php/symfony-http-kernel
	dev-php/symfony-polyfill-mbstring
	dev-php/symfony-property-access
	dev-php/symfony-security-core
	dev-php/symfony-service-contracts"
BDEPEND="test? ( dev-php/phpunit
		dev-php/symfony-expression-language
		dev-php/symfony-http-client
		dev-php/symfony-http-client-contracts
		dev-php/symfony-phpunit-bridge
		dev-php/symfony-rate-limiter
		dev-php/symfony-routing
		dev-php/symfony-security-csrf
		dev-php/symfony-translation )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# remove tests require web-token/jwt-signature
	rm Tests/AccessToken/Oidc/OidcTokenHandlerTest.php \
		|| die "rm failed"
}

src_test() {
	# skipped 14
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Security/Http
	doins -r AccessToken Attribute Authentication Authenticator \
		Authorization Controller EntryPoint Event \
		EventListener Firewall Impersonate LoginLink Logout \
		RateLimiter RememberMe Session Util ./*.php
}
