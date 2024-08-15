# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/sebastianbergmann/diff.git"

inherit git-r3

DESCRIPTION="PHP Diff implementation"
HOMEPAGE="https://github.com/sebastianbergmann/diff"

LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/phpunit
	>=dev-php/symfony-process-6.4.8"
BDEPEND="dev-php/theseer-Autoload
	test? ( dev-php/phpunit )"

DOCS=( {ChangeLog,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		vendor/autoload.php || die "install failed"
	phpab -q -o src/autoload.php -t fedora2 src || die "phpab failed"
	phpab -q -o tests/autoload.php -t fedora2 tests || die "phpab test failed"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/SebastianBergmann/Diff
	doins -r src/.
}
