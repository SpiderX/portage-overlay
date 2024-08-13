# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//nyholm-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A super lightweight PSR-7 implementation"
HOMEPAGE="https://github.com/Nyholm/psr7"
SRC_URI="https://github.com/Nyholm/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/psr-http-factory
	dev-php/psr-http-message"
BDEPEND="test? ( dev-php/composer
		dev-php/http-interop-http-factory-tests
		dev-php/php-http-message-factory
		dev-php/php-http-psr7-integration-tests
		dev-php/phpunit )"

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
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml.dist,tests} "${S}" \
		|| die "cp failed"
	mkdir -p vendor/http-interop/http-factory-tests || die "mkdir failed"
	ln -s ../../../../../../../../../../usr/share/php/Interop/Http/Factory/ \
		vendor/http-interop/http-factory-tests/test \
		|| die "ln failed"
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Nyholm/Psr7
	doins -r src/.
}
