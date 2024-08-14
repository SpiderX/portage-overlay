# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/symfony/security-http.git"

DESCRIPTION="Symfony Security HTTP Component"
HOMEPAGE="https://github.com/symfony/security-http"

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
	# ignore risky tests
	sed -i '/failOnRisky/s|true|false|' phpunit.xml.dist \
		|| die "sed failed for phpunit.xml.dist"
	# remove tests require web-token/jwt-signature
	rm Tests/AccessToken/Oidc/OidcTokenHandlerTest.php \
		|| die "rm failed"
	# rename object
	sed -i '/Mock_/s|Mock|MockObject|' \
		Tests/Authentication/AuthenticatorManagerTest.php \
		Tests/Controller/UserValueResolverTest.php \
		|| die "sed failed for AuthenticatorManagerTest.php"
}

src_test() {
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
