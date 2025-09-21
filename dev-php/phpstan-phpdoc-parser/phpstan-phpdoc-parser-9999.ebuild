# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="PHPDoc Parser for PHPStan"
HOMEPAGE="https://github.com/phpstan/phpdoc-parser"
EGIT_REPO_URI="https://github.com/phpstan/phpdoc-parser.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/composer
		dev-php/doctrine-annotations
		dev-php/phpunit
		>=dev-php/symfony-process-6
		dev-util/abnfgen )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# replace path to abnfgen
	sed -i '/abnfgen/s|tools/abnfgen|../../../../../../../usr/bin|' \
		tests/PHPStan/Parser/FuzzyTest.php \
		|| die "sed failed for FuzzyTest.php"
	eapply "${FILESDIR}/${PN}"-2.3.0-tests-phpunit-11.patch
}

src_compile() { :; }

src_test() {
	phpunit --bootstrap vendor/autoload.php --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/PHPStan/PhpDocParser
	doins -r src/.
}
