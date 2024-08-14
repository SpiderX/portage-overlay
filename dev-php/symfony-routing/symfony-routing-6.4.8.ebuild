# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//symfony-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Symfony Routing Component"
HOMEPAGE="https://github.com/symfony/routing"
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
	dev-php/symfony-deprecation-contracts"
BDEPEND="test? ( dev-php/composer
		dev-php/doctrine-annotations
		dev-php/phpunit
		dev-php/psr-log
		dev-php/symfony-config
		dev-php/symfony-dependency-injection
		dev-php/symfony-expression-language
		dev-php/symfony-http-foundation
		dev-php/symfony-phpunit-bridge
		dev-php/symfony-yaml )"

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
	# test calls undefined method getName
	rm Tests/Generator/Dumper/CompiledUrlGeneratorDumperTest.php \
		|| die "rm failed for CompiledUrlGeneratorDumperTest.php"
	# remove non-existed method
	sed -i "s/\$this->getExpectedException() ?: //" \
		Tests/Matcher/UrlMatcherTest.php \
		|| die "sed failed for UrlMatcherTest.php"
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Routing
	doins -r Annotation Attribute DependencyInjection Exception \
		Generator Loader Matcher Requirement ./*.php
}
