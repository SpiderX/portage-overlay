# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/symfony/routing.git"

inherit git-r3

DESCRIPTION="Symfony Routing Component"
HOMEPAGE="https://github.com/symfony/routing"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-deprecation-contracts"
BDEPEND="test? ( dev-php/doctrine-annotations
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
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Routing
	doins -r Annotation Attribute DependencyInjection Exception \
		Generator Loader Matcher Requirement ./*.php
}
