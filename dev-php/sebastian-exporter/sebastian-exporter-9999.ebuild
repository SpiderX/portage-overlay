# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Export PHP variables for visualization"
HOMEPAGE="https://github.com/sebastianbergmann/exporter"
EGIT_REPO_URI="https://github.com/sebastianbergmann/exporter.git"

LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[unicode]
	dev-php/fedora-autoloader
	dev-php/sebastian-recursion-context"
BDEPEND="dev-php/theseer-Autoload
	test? ( dev-php/phpunit )"

DOCS=( {ChangeLog,README}.md )

src_prepare() {
	default

	phpab -q -o src/autoload.php -t "${FILESDIR}"/autoload.php.tpl \
		src || die "phpab failed"
	phpab -q -o tests/autoload.php -t fedora2 tests || die "phpab test failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install failed"
}

src_test() {
	# skipped — testShortenedExportDoesNotInitializeLazyObject
	phpunit --bootstrap vendor/autoload.php --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/SebastianBergmann/Exporter
	doins -r src/.
}
