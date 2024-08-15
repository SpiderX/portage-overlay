# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/sebastianbergmann/comparator.git"

inherit git-r3

DESCRIPTION="Compare PHP values for equality"
HOMEPAGE="https://github.com/sebastianbergmann/comparator"

LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[xml,unicode]
	dev-php/fedora-autoloader
	>=dev-php/sebastian-diff-5.1.1
	dev-php/sebastian-exporter"
BDEPEND="dev-php/theseer-Autoload
	test? ( dev-php/phpunit )"

DOCS=( {ChangeLog,README}.md )

src_prepare() {
	default

	# testDouble(): Argument #3 ($methods) must be of type ?array, bool given
	rm tests/unit/MockObjectComparatorTest.php || die "rm failed"
	# The attribute 'ignoreIndirectDeprecations' is not allowed
	sed -i 's|ignoreIndirectDeprecations="true" ||' phpunit.xml \
		|| die "sed failed"
	phpab -q -o src/autoload.php -t fedora2 src || die "phpab failed"
	phpab -q -o tests/autoload.php -t fedora2 tests || die "phpab test failed"
	install -D -m 644 "${FILESDIR}"/autoload.php \
		vendor/autoload.php || die "install failed"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/SebastianBergmann/Comparator
	doins -r src/.
}
