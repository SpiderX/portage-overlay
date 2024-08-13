# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature

MY_PN="${PN//phpunit-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Library for PHP code coverage information"
HOMEPAGE="https://github.com/sebastianbergmann/php-code-coverage"
SRC_URI="https://github.com/sebastianbergmann/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*[xml,xmlwriter]
	dev-php/fedora-autoloader
	dev-php/nikic-php-parser
	dev-php/phpunit-php-file-iterator
	dev-php/phpunit-php-text-template
	dev-php/sebastian-code-unit-reverse-lookup
	dev-php/sebastian-complexity
	dev-php/sebastian-environment
	dev-php/sebastian-lines-of-code
	dev-php/sebastian-version
	dev-php/theseer-tokenizer"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit )"

DOCS=( {ChangeLog-10.1,README}.md )

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
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml,tests} "${S}" \
		|| die "cp tests failed"
	sed -i '/testCanBeCreatedFromDefaults/,+8d' \
		tests/tests/Report/Html/CustomCssFileTest.php || die "sed failed"
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/SebastianBergmann/CodeCoverage
	doins -r src/.
}

pkg_postinst() {
	optfeature "support line coverage" dev-php/phpunit-phpcov
	optfeature "line coverage as well as branch and path coverage" dev-php/xdebug
}
