# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/amphp/sync.git"

inherit git-r3

DESCRIPTION="Non-blocking synchronization primitives for PHP"
HOMEPAGE="https://github.com/amphp/sync"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="test" # 5 class abstract

RDEPEND="dev-lang/php:*
	dev-php/amphp-amp
	dev-php/amphp-pipeline
	dev-php/amphp-serialization
	dev-php/fedora-autoloader
	dev-php/revolt-event-loop"
BDEPEND="test? ( dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Amp/Sync
	doins -r src/.
}
