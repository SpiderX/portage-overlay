# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//amphp-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Non-blocking socket and TLS functionality for PHP"
HOMEPAGE="https://github.com/amphp/socket"
SRC_URI="https://github.com/amphp/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ipv6 test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*[ipv6?,ssl]
	dev-php/amphp-amp
	dev-php/amphp-byte-stream
	dev-php/amphp-dns
	dev-php/fedora-autoloader
	dev-php/kelunik-certificate
	dev-php/league-uri
	dev-php/league-uri-interfaces
	dev-php/revolt-event-loop"
BDEPEND="test? ( dev-php/composer
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
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml.dist,test} "${S}" \
		|| die "cp failed"
	pushd test/tls || die "pushd failed"
	./regenerate.sh || die "ssl regenerate failed"
	popd || die "popd failed"
	! use ipv6 && eapply "${FILESDIR}/${PN}"-2.3.1-test-no-ipv6.patch
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Amp/Socket
	doins -r src/.
}
