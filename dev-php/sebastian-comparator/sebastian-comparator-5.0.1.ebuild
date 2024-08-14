# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//sebastian-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Compare PHP values for equality"
HOMEPAGE="https://github.com/sebastianbergmann/comparator"
SRC_URI="https://github.com/sebastianbergmann/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*[xml,unicode]
	dev-php/fedora-autoloader
	dev-php/sebastian-diff
	dev-php/sebastian-exporter"
BDEPEND="dev-php/theseer-Autoload
	test? ( dev-php/composer
		dev-php/phpunit )"

DOCS=( {ChangeLog,README}.md )

src_prepare() {
	default

	phpab -q -o src/autoload.php -t fedora2 src || die "phpab failed"
	install -D -m 644 "${FILESDIR}"/autoload.php \
		vendor/autoload.php || die "install failed"
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev "${PN/-/\/}:${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml,tests} "${S}" \
		|| die "cp failed"
	phpab -q -o tests/autoload.php -t fedora2 tests || die "phpab test failed"
	# remove tests with deprecated method
	rm tests/MockObjectComparatorTest.php || die "rm failed"
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/SebastianBergmann/Comparator
	doins -r src/.
}
