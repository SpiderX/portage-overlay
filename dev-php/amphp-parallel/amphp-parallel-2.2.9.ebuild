# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//amphp-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="An advanced parallelization library for PHP"
HOMEPAGE="https://github.com/amphp/parallel"
SRC_URI="https://github.com/amphp/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/amphp-amp
	dev-php/amphp-byte-stream
	dev-php/amphp-cache
	dev-php/amphp-parser
	dev-php/amphp-pipeline
	dev-php/amphp-process
	dev-php/amphp-serialization
	dev-php/amphp-socket
	dev-php/amphp-sync
	dev-php/fedora-autoloader
	dev-php/revolt-event-loop"
BDEPEND="test? ( dev-php/composer
		dev-php/pecl-parallel
		dev-php/phpunit )"

PATCHES=( "${FILESDIR}/${PN}"-2.2.9-autoload.patch )

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
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml.dist,test,examples} "${S}" \
		|| die "cp failed"
	# fix abstract class with Test suffix
	mv test/Context/AbstractContextTest{,Abstract}.php \
		|| die "mv failed for AbstractContextTest"
	sed -i '/class /s|AbstractContextTest|AbstractContextTestAbstract|' \
		test/Context/AbstractContextTestAbstract.php \
		|| die "sed failed for AbstractContextTest"
	sed -i '/class /s|$|Abstract|' \
		test/Context/{Process,Thread}ContextTest.php \
		|| die "sed failed for ContextTest"
	mv test/Worker/AbstractWorkerTest{,Abstract}.php \
		|| die "mv failed for AbstractWorkerTest"
	sed -i '/class /s|AbstractWorkerTest|AbstractWorkerTestAbstract|' \
		test/Worker/AbstractWorkerTestAbstract.php \
		|| die "sed failed for AbstractWorkerTest"
	sed -i '/^class /s|$|Abstract|' test/Worker/{Process,Thread}WorkerTest.php \
		|| die "sed failed for WorkerTest"
	sed -i '/class /s|$|Abstract|' test/Worker/AbstractPoolTest.php \
		|| die "sed failed for AbstractPoolTest.php"
	mv test/Worker/AbstractPoolTest{,Abstract}.php \
		|| die "mv failed for AbstractPoolTest"
	sed -i '/class /s|AbstractPoolTest|AbstractPoolTestAbstract|' \
		test/Worker/AbstractPoolTestAbstract.php \
		|| die "sed failed for AbstractPoolTest"
	sed -i '/^class /s|$|Abstract|' test/Worker/{Process,Thread}PoolTest.php \
		|| die "sed failed for PoolTest"
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Amp/Parallel
	doins -r src/.
}
