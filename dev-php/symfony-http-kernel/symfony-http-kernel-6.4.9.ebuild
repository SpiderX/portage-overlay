# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//symfony-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Structured process for converting a Request into a Response"
HOMEPAGE="https://github.com/symfony/http-kernel"
SRC_URI="https://github.com/symfony/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-error-handler
	dev-php/symfony-event-dispatcher
	dev-php/symfony-http-foundation
	dev-php/symfony-polyfill-ctype
	dev-php/psr-log"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit
		dev-php/symfony-browser-kit
		dev-php/symfony-clock
		dev-php/symfony-config
		dev-php/symfony-console
		dev-php/symfony-dependency-injection
		dev-php/symfony-expression-language
		dev-php/symfony-http-client-contracts
		dev-php/symfony-phpunit-bridge
		>=dev-php/symfony-process-6.4.8
		dev-php/symfony-property-access
		dev-php/symfony-routing
		dev-php/symfony-serializer
		dev-php/symfony-stopwatch
		dev-php/symfony-validator
		dev-php/symfony-uid
		>=dev-php/twig-3.10.3 )"

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
	# ignore risky tests
	sed -i '/failOnRisky/s|true|false|' phpunit.xml.dist \
		|| die "sed failed for phpunit.xml.dist"
	# remove composer specific test
	sed -i '/testGetScript/,+8d' Tests/HttpKernelBrowserTest.php \
		|| die "sed failed for HttpKernelBrowserTest.php"
	# rename class not extending TestCase
	mv Tests/Fixtures/KernelFor{Test,}.php || die "mv failed"
	sed -i '/class Kernel/s|Test||' Tests/Fixtures/KernelFor.php \
		|| die "sed failed for KernelFor.php"
	# rename, descrease timeout, change serialize after rename
	sed -i  -e 's/KernelForTest/KernelFor/' \
		-e 's/KernelForW/KernelForTestW/' \
		-e '/sleep/s|60||' \
		-e '/expected/s|57|53|' Tests/KernelTest.php \
		|| die "sed failed for KernelTest.php"
	sed -i '/class/s|Test$||' Tests/Fixtures/KernelForTestWithLoadClassCache.php \
		|| die "sed failed for KernelForTestWithLoadClassCache.php"
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/HttpKernel
	doins -r Attribute Bundle CacheClearer CacheWarmer Config Controller \
		ControllerMetadata DataCollector Debug DependencyInjection \
		Event EventListener Exception Fragment HttpCache Log \
		Profiler Resources ./*.php
}
