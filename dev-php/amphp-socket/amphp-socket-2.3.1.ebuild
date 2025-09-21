# Copyright 1999-2025 Gentoo Authors
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
KEYWORDS="~amd64"
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
	# fix non-static data provider deprecation
	sed -i  -e '/bindToDataProvider(/s|function|static function|' \
		-e '/backlogDataProvider(/s|function|static function|' \
		test/BindContextTest.php \
		|| die "sed failed for BindContextTest.php"
	sed -i '/defaultCertificateDataProvider(/s|function|static function|' \
		test/ServerTlsContextTest.php \
		|| die "sed failed for ServerTlsContextTest.php"
	sed -i  -e '/minimumVersionDataProvider(/s|function|static function|' \
		-e '/minimumVersionInvalidDataProvider(/s|function|static function|' \
		-e '/peerNameDataProvider(/s|function|static function|' \
		-e '/certificateDataProvider(/s|function|static function|' \
		-e '/verifyDepthDataProvider(/s|function|static function|' \
		-e '/verifyDepthInvalidDataProvider(/s|function|static function|' \
		-e '/ciphersDataProvider(/s|function|static function|' \
		-e '/caFileDataProvider(/s|function|static function|' \
		-e '/caPathDataProvider(/s|function|static function|' \
		-e '/invalidSecurityLevelDataProvider(/s|function|static function|' \
		-e '/ validSecurityLevelDataProvider(/s|function|static function|' \
		test/{Client,Server}TlsContextTest.php \
		|| die "sed failed for ClientTlsContextTest.php"
	sed -i  -e '/bindToDataProvider(/s|function|static function|' \
		-e '/withConnectTimeoutDataProvider(/s|function|static function|' \
		-e '/withConnectTimeoutInvalidTimeoutDataProvider(/s|function|static function|' \
		-e '/withDnsTypeRestrictionDataProvider(/s|function|static function|' \
		-e '/withDnsTypeRestrictionInvalidTypeDataProvider(/s|function|static function|' \
		test/ConnectContextTest.php \
		|| die "sed failed for ConnectContextTest.php"
	sed -i  -e '/provideConnectArgs(/s|function|static function|' \
		-e '/provideConnectTlsArgs(/s|function|static function|g' \
		test/IntegrationTest.php \
		|| die "sed failed for IntegrationTest.php"
	sed -i  -e '/parseUriDataProvider(/s|function|static function|' \
		-e '/parseUriInvalidUriDataProvider(/s|function|static function|g' \
		-e '/parseUriInvalidSchemeDataProvider(/s|function|static function|g' \
		-e '/normalizeBindToOptionDataProvider(/s|function|static function|g' \
		-e '/normalizeBindToOptionInvalidBindToDataProvider(/s|function|static function|g' \
		-e '/normalizeBindToOptionInvalidPortDataProvider(/s|function|static function|g' \
		-e '/normalizeBindToOptionInvalidIpv4DataProvider(/s|function|static function|g' \
		test/Internal/FunctionsTest.php \
		|| die "sed failed for FunctionsTest.php"
	sed -i '/constructorParametersProvider(/s|function|static function|' \
		test/PendingAcceptErrorTest.php \
		|| die "sed failed for PendingAcceptErrorTest.php"
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Amp/Socket
	doins -r src/.
}
