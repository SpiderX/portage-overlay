# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="TextUI frontend for php-code-coverage"
HOMEPAGE="https://github.com/sebastianbergmann/phpcov"
EGIT_REPO_URI="https://github.com/sebastianbergmann/phpcov.git"

LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

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
	# remove tests with hardcoded path in data
	rm tests/end-to-end/patch-coverage/valid-arguments-with-invalid-path-prefix.phpt \
		tests/end-to-end/patch-coverage/valid-arguments-without-path-prefix.phpt \
		tests/end-to-end/execute/valid-script-argument-with-cli-include-with-text-report.phpt \
		tests/end-to-end/merge/valid-directory-with-text-report.phpt \
		tests/end-to-end/merge/valid-directory-with-text-report-stdout.phpt \
		tests/end-to-end/patch-coverage/valid-arguments-with-valid-path-prefix.phpt \
		|| die "rm failed"
}

src_test() {
	# skipped 2
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
