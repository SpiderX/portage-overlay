# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/Seldaek/signal-handler.git"

inherit git-r3

DESCRIPTION="Simple unix signal handler"
HOMEPAGE="https://github.com/Seldaek/signal-handler"

LICENSE="MIT"
SLOT="0"
IUSE="pcntl test"
REQUIRED_USE="test? ( pcntl )"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[pcntl?]
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 /dev/null \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Seld/SignalHandler
	doins -r src/.
}
