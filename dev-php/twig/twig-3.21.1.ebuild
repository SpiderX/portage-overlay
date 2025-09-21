# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN^}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="PHP templating engine with syntax similar to Django"
HOMEPAGE="https://github.com/twigphp/Twig"
SRC_URI="https://github.com/twigphp/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test" # not ready for phpunit 11
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-polyfill-ctype
	dev-php/symfony-polyfill-mbstring"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit
		dev-php/psr-container
		dev-php/symfony-phpunit-bridge )"

DOCS=( CHANGELOG README.rst )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev "${PN}/${PN}:${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN}"/"${PN}"/{phpunit.xml.dist,tests} "${S}" \
		|| die "cp failed"
	# https://github.com/twigphp/twig/commit/9282dbcc42b897b4f3c4dacbd767d1e7b1ff1b75
	eapply "${FILESDIR}/${PN}"-3.21.1-tests-static.patch
	# https://github.com/twigphp/twig/commit/f2053bbea0fec2635681846c181c69ca2b22d410
	eapply "${FILESDIR}/${PN}"-3.21.1-tests-phpunit-11.patch
	# fix non-static data provider deprecation
	sed -i '/getTests(/s|function|static function|' \
		src/Test/NodeTestCase.php \
		|| die "sed failed for NodeTestCase.php"
	# skipped 5
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Twig
	doins -r src/.
}
