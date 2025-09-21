# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Provides basic utilities for the filesystem"
HOMEPAGE="https://github.com/symfony/filesystem"
EGIT_REPO_URI="https://github.com/symfony/filesystem.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-polyfill-ctype
	dev-php/symfony-polyfill-mbstring"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit
		>=dev-php/symfony-process-6 )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	# skipped 3, needs tty, without it skipped 5
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Filesystem
	doins -r Exception ./*.php
}
