# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//composer-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Utilities to scan PHP code and generate class maps"
HOMEPAGE="https://github.com/composer/class-map-generator"
SRC_URI="https://github.com/composer/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/composer-pcre
	dev-php/fedora-autoloader
	>=dev-php/symfony-finder-6"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit
		>=dev-php/symfony-filesystem-6 )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install failed"
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev "${PN/-/\/}":"${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml.dist,tests} "${S}" \
		|| die "cp tests failed"
	# fix non-static data provider deprecation
	sed -i '/getTestCreateMapTests(/s|function|static function|' \
		tests/ClassMapGeneratorTest.php \
		|| die "sed failed for ClassMapGeneratorTest.php"
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Composer/ClassMapGenerator
	doins -r src/.
}
