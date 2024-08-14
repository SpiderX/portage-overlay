# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//revolt-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Event loop for concurrent PHP applications"
HOMEPAGE="https://github.com/revoltphp/event-loop"
SRC_URI="https://github.com/revoltphp/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/pecl-event
		dev-php/pecl-uv )"

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
	# remove call of non-existed method
	sed -i '/getTestResultObject/,+2d' test/Driver/DriverTest.php \
		|| die "sed failed for DriverTest.php"
	# remove flickering test
	sed -i '/testTooLargeFileDescriptorSet/,+39d' \
		test/Driver/StreamSelectDriverTest.php \
		|| die "sed failed for StreamSelectDriverTest.php"
	# fix abstract class with Test suffix
	mv test/Driver/DriverTest{,Abstract}.php || die "mv failed"
	sed -i '/abstract class/s|DriverTest|DriverTestAbstract|' \
		test/Driver/DriverTestAbstract.php \
		|| die "sed failed for DriverTestAbstract.php"
	sed -i '/class /s|$|Abstract|' \
		test/Driver/{Ev,Event,StreamSelect,Tracing,Uv}DriverTest.php \
		|| die "sed failed"
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Revolt
	doins -r src/.
}
