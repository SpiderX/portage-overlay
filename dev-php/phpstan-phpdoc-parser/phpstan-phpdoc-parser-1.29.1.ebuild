# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//phpstan-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="PHPDoc Parser for PHPStan"
HOMEPAGE="https://github.com/phpstan/phpdoc-parser"
SRC_URI="https://github.com/phpstan/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

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
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev "${PN/-/\/}:${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml,tests,doc} "${S}" \
		|| die "cp failed"
	# remove coverage
	sed -i '/<coverage/,+13d' phpunit.xml || die "sed failed for phpunit.xml"
	# replace path to abnfgen
	sed -i '/abnfgen/s|tools/abnfgen|../../../../../../../usr/bin|' \
		tests/PHPStan/Parser/FuzzyTest.php \
		|| die "sed failed for FuzzyTest.php"
	phpunit --bootstrap vendor/autoload.php --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/PHPStan/PhpDocParser
	doins -r src/.
}
