# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//amphp-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Async DNS resolution for PHP"
HOMEPAGE="https://github.com/amphp/dns"
SRC_URI="https://github.com/amphp/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ipv6 test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*[filter,ipv6?]
	dev-php/amphp-amp
	dev-php/amphp-byte-stream
	dev-php/amphp-cache
	dev-php/amphp-parser
	dev-php/amphp-windows-registry
	dev-php/daverandom-libdns
	dev-php/fedora-autoloader
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
	# replace non-existed method
	sed -i 's/expectErrorMessage/expectExceptionMessage/' \
		test/UdpSocketTest.php || die "sed failed for UdpSocketTest.php"
	# fix abstract class with Test suffix
	mv test/SocketTest{,Abstract}.php || die "mv failed"
	sed -i '/class /s|SocketTest|SocketTestAbstract|' \
		test/SocketTestAbstract.php || die "sed failed SocketTestAbstract.php"
	sed -i '/class /s|$|Abstract|' test/{Tcp,Udp}SocketTest.php \
		|| die "sed failed"
	! use ipv6 && eapply "${FILESDIR}/${PN}"-2.2.0-test-no-ipv6.patch
	phpunit --group default --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Amp/Dns
	doins -r src/.
}
