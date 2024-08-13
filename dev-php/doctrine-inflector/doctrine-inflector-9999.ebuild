# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/doctrine/inflector.git"

inherit git-r3

DESCRIPTION="Doctrine Inflector"
HOMEPAGE="https://github.com/doctrine/inflector"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		lib/Doctrine/Inflector/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# fix abstract class with Test suffix
	mv tests/Doctrine/Tests/Inflector/Rules/LanguageFunctionalTest{,Abstract}.php \
		|| die "mv failed"
	sed -i '/class/s|FunctionalTest|FunctionalTestAbstract|' \
		tests/Doctrine/Tests/Inflector/Rules/LanguageFunctionalTestAbstract.php \
		|| die "sed failed for LanguageFunctionalTestAbstract.php"
	sed -i  -e '/class/s/$/Abstract/' \
		-e '/LanguageFunctionalTest;/s/;$/Abstract;/' \
		tests/Doctrine/Tests/Inflector/Rules/{French/French,Portuguese/Portuguese}FunctionalTest.php \
		tests/Doctrine/Tests/Inflector/Rules/English/EnglishFunctionalTest.php \
		tests/Doctrine/Tests/Inflector/Rules/NorwegianBokmal/NorwegianBokmalFunctionalTest.php \
		tests/Doctrine/Tests/Inflector/Rules/{Spanish/Spanish,Turkish/Turkish}FunctionalTest.php \
		|| die "sed failed"
}

src_test() {
	phpunit --bootstrap vendor/autoload.php --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php
	doins -r lib/.
}
