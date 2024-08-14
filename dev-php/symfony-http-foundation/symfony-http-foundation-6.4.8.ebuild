# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//symfony-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Defines an object-oriented layer for the HTTP specification"
HOMEPAGE="https://github.com/symfony/http-foundation"
SRC_URI="https://github.com/symfony/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ipv6 test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-polyfill-mbstring
	dev-php/symfony-polyfill-php83"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit
		dev-php/symfony-expression-language
		dev-php/symfony-mime
		dev-php/symfony-phpunit-bridge
		>=dev-php/symfony-process-6.4.8
		dev-php/symfony-rate-limiter
		net-misc/curl )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev "${PN/-/\/}:${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml.dist,Tests} "${S}" \
		|| die "cp failed"
	# https://github.com/symfony/symfony/issues/25445
	eapply "${FILESDIR}/${PN}"-6.4.8-test-session.patch
	if ! use ipv6 ; then
		rm Tests/{IpUtilsTest,RequestTest}.php || die "rm failed for ipv6"
	fi
	# remove tests
	rm Tests/Session/Storage/Handler/AbstractSessionHandlerTest.php \
		|| die "rm failed for AbstractSessionHandlerTest.php"
	rm Tests/ResponseFunctionalTest.php \
		|| die "rm failed for ResponseFunctionalTest.php"
	# remove test with unsupported method TestFailure
	rm Tests/Test/Constraint/{RequestAttribute,ResponseCookie}ValueSameTest.php \
		Tests/Test/Constraint/Response{HasCookie,HasHeader}Test.php \
		Tests/Test/Constraint/Response{IsRedirected,IsSuccessful}Test.php \
		Tests/Test/Constraint/Response{Format,Header,StatusCode}SameTest.php \
		|| die "rm failed"
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/HttpFoundation
	doins -r Exception File RateLimiter RequestMatcher Session Test ./*.php
}
