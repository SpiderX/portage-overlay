# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/sebastianbergmann/php-invoker.git"

inherit git-r3

DESCRIPTION="Library to invoke PHP callables with a timeout"
HOMEPAGE="https://github.com/sebastianbergmann/php-invoker"

LICENSE="BSD"
SLOT="0"
IUSE="pcntl test"
REQUIRED_USE="test? ( pcntl )"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[pcntl?]
	dev-php/fedora-autoloader"
BDEPEND="dev-php/theseer-Autoload
	test? ( dev-php/phpunit )"

DOCS=( {ChangeLog,README}.md )

src_prepare() {
	default

	phpab -q -o src/autoload.php -t fedora2 src || die "phpab failed"
	install -D -m 644 /dev/null \
		vendor/autoload.php || die "install failed"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/SebastianBergmann/Invoker
	doins -r src/.
}
