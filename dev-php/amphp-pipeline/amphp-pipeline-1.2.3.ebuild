# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//amphp-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Concurrent iterators and pipeline operations"
HOMEPAGE="https://github.com/amphp/pipeline"
SRC_URI="https://github.com/amphp/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/amphp-amp
	dev-php/fedora-autoloader
	dev-php/revolt-event-loop"
BDEPEND="test? ( dev-php/amphp-phpunit-util
		dev-php/composer
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
	# fix non-static data provider deprecation
	sed -i '/getArrays(/s|function|static function|g' \
		test/{Concat,Merge}Test.php \
		|| die "sed failed for getArrays"
	sed -i '/provideInvalidIteratorArguments(/s|function|static function|g' \
		test/FromIterableTest.php \
		|| die "sed failed for FromIterableTest.php"
	sed -i '/provideBufferSize(/s|function|static function|g' \
		test/QueueTest.php \
		|| die "sed failed for QueueTest.php"
	# remove tests with timeout
	sed -i '/testBackPressure(/,+23d' test/FromIterableGeneratorTest.php \
		|| die "sed failed for FromIterableGeneratorTest.php"
	sed -i '/testCompleteBeforeSourceCompletes(/,+14d' test/TakeTest.php \
		|| die "sed failed for TakeTest.php"
	sed -i '/testSlowConsumer(/,+10d' test/FromIterableTest.php \
		|| die "sed failed for FromIterableTest.php"
	sed -i  -e '/testPipelineFailsConcurrent1(/,+63d' \
		-e '/testPipelineFailsConcurrent2(/,+43d' test/MapTest.php \
		|| die "sed failed for MapTest.php"
	rm test/MergeTest.php || die "rm failed for MergeTest.php"
	sed -i  -e '/testBackPressureOnComplete(/,+28d' \
		-e '/testBackPressureOnDisposal/,+19d' test/QueueTest.php \
		|| die "sed failed for QueueTest.php"
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Amp/Pipeline
	doins -r src/.
}
