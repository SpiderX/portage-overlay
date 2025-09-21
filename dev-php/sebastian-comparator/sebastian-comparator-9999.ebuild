# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Compare PHP values for equality"
HOMEPAGE="https://github.com/sebastianbergmann/comparator"
EGIT_REPO_URI="https://github.com/sebastianbergmann/comparator.git"

LICENSE="BSD"
SLOT="0"
IUSE="bcmath test"
REQUIRED_USE="test? ( bcmath )"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[bcmath?,xml,unicode]
	dev-php/fedora-autoloader
	>=dev-php/sebastian-diff-6.0.2
	dev-php/sebastian-exporter"
BDEPEND="dev-php/theseer-Autoload
	test? ( dev-php/phpunit )"

DOCS=( {ChangeLog,README}.md )

src_prepare() {
	default

	# testDouble(): Argument #3 ($methods) must be of type ?array, bool given
	rm tests/unit/MockObjectComparatorTest.php || die "rm failed"
	phpab -q -o src/autoload.php -t fedora2 src || die "phpab failed"
	phpab -q -o tests/autoload.php -t fedora2 tests/_fixture || die "phpab test failed"
	install -D -m 644 "${FILESDIR}"/autoload.php \
		vendor/autoload.php || die "install failed"
}

src_test() {
	# skipped 5
	phpunit --bootstrap vendor/autoload.php --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/SebastianBergmann/Comparator
	doins -r src/.
}
