# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/phpstan/phpdoc-parser.git"

inherit git-r3

DESCRIPTION="PHPDoc Parser for PHPStan"
HOMEPAGE="https://github.com/phpstan/phpdoc-parser"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/composer
		dev-php/doctrine-annotations
		dev-php/phpunit
		>=dev-php/symfony-process-6.4.8
		dev-util/abnfgen )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# remove coverage
	sed -i '/<coverage/,+13d' phpunit.xml || die "sed failed for phpunit.xml"
	# replace path to abnfgen
	sed -i '/abnfgen/s|tools/abnfgen|../../../../../../../usr/bin|' \
		tests/PHPStan/Parser/FuzzyTest.php \
		|| die "sed failed for FuzzyTest.php"
}

src_test() {
	phpunit --bootstrap vendor/autoload.php --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/PHPStan/PhpDocParser
	doins -r src/.
}
