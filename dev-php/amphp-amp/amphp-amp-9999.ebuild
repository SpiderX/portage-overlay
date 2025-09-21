# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="A non-blocking concurrency framework for PHP applications"
HOMEPAGE="https://github.com/amphp/amp"
EGIT_REPO_URI="https://github.com/amphp/amp.git"

LICENSE="MIT"
SLOT="0"
IUSE="pcntl test"
REQUIRED_USE="test? ( pcntl )"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[pcntl?]
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
	# fix non-static data provider deprecation
	sed -i  -e '/provideObjectFactories(/s|function|static function|' \
		test/WeakClosureTest.php \
		|| die "sed failed for WeakClosureTest.php"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Amp
	doins -r src/.
}
