# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//phpunit-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="TextUI frontend for php-code-coverage"
HOMEPAGE="https://github.com/sebastianbergmann/phpcov"
SRC_URI="https://github.com/sebastianbergmann/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/phpunit
	dev-php/phpunit-php-code-coverage
	dev-php/phpunit-php-file-iterator
	dev-php/sebastian-cli-parser
	dev-php/sebastian-diff
	dev-php/sebastian-version"
BDEPEND="test? ( dev-php/phpunit )"

PATCHES=( "${FILESDIR}/${PN}"-9.0.2-autoload.patch )

DOCS=( {ChangeLog,README}.md )

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
		|| die "cp failed"
	# remove tests with hardcoded path in data
	rm tests/end-to-end/merge/valid-directory-with-text-report-stdout.phpt \
		tests/end-to-end/patch-coverage/valid-arguments-with-valid-path-prefix.phpt \
		tests/end-to-end/merge/valid-directory-with-text-report.phpt \
		|| die "rm failed"
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/SebastianBergmann/PHPCOV
	doins -r src/.

	exeinto /usr/share/php/SebastianBergmann/PHPCOV
	doexe phpcov
	dosym ../share/php/SebastianBergmann/PHPCOV/phpcov \
		/usr/bin/phpcov
}
