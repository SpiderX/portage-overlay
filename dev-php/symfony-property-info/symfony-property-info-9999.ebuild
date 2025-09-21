# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Symfony PropertyInfo Component"
HOMEPAGE="https://github.com/symfony/property-info"
EGIT_REPO_URI="https://github.com/symfony/property-info.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-string"
BDEPEND="test? ( dev-php/phpdocumentor-reflection-docblock
		dev-php/phpunit
		dev-php/symfony-cache
		dev-php/symfony-dependency-injection
		dev-php/symfony-phpunit-bridge
		dev-php/symfony-serializer
		dev-php/symfony-type-info )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	# skipped 7
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/PropertyInfo
	doins -r DependencyInjection Extractor PhpStan Util ./*.php
}
