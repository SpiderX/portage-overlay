# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Event loop for concurrent PHP applications"
HOMEPAGE="https://github.com/revoltphp/event-loop"
EGIT_REPO_URI="https://github.com/revoltphp/event-loop.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )" # fails in sandbox only

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/pecl-ev
		dev-php/pecl-event
		dev-php/pecl-uv )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# remove flickering test
	sed -i '/testTooLargeFileDescriptorSet/,+39d' \
		test/Driver/StreamSelectDriverTest.php \
		|| die "sed failed for StreamSelectDriverTest.php"
	# fix non-static data provider deprecation
	sed -i '/provideRegistrationArgs(/s|function|static function|' \
		test/Driver/DriverTest.php \
		|| die "sed failed for provideRegistrationArgs"
}

src_test() {
	# don't select memoryleak group since it requires not existed
	# after phpunit 10 method getTestResultObject()
	phpunit --group default --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Revolt
	doins -r src/.
}
