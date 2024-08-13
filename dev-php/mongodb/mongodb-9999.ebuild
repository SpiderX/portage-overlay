# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/mongodb/mongo-php-library.git"

inherit git-r3

DESCRIPTION="The Official MongoDB PHP library"
HOMEPAGE="https://github.com/mongodb/mongo-php-library"

LICENSE="MIT"
SLOT="0"
RESTRICT="test"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/jean85-pretty-package-versions
	dev-php/pecl-mongodb
	dev-php/symfony-polyfill-php80
	dev-php/symfony-polyfill-php81"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
}

src_test() {
	phpunit --testsuite unit || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/MongoDB
	doins -r src/.
}
