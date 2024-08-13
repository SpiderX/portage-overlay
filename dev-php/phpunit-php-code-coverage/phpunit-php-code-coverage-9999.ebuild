# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/sebastianbergmann/${PN}.git"

inherit git-r3 optfeature

DESCRIPTION="Library for PHP code coverage information"
HOMEPAGE="https://github.com/sebastianbergmann/php-code-coverage"

LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

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
BDEPEND="test? ( dev-php/phpunit )"

DOCS=( {ChangeLog-10.1,README}.md )

src_prepare() {
	default

	# remove test
	sed -i '/testCanBeCreatedFromDefaults/,+8d' \
		tests/tests/Report/Html/CustomCssFileTest.php \
		|| die "sed for CustomCssFileTest.php failed"
	# The attribute 'ignoreIndirectDeprecations' is not allowed
	sed -i 's|ignoreIndirectDeprecations="true" ||' phpunit.xml \
		|| die "sed for phpunit.xml failed"
	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/SebastianBergmann/CodeCoverage
	doins -r src/.
}

pkg_postinst() {
	optfeature "support line coverage" dev-php/phpcov
	optfeature "line coverage as well as branch and path coverage" dev-php/xdebug
}
