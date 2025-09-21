# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Webmozart Assert"
HOMEPAGE="https://github.com/webmozarts/assert"
EGIT_REPO_URI="https://github.com/webmozarts/assert.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="test" # not ready for phpunit 11

RDEPEND="dev-lang/php:*[ctype]
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit )"

DOCS=( {CHANGELOG,README}.md )

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
	insinto /usr/share/php/Webmozart/Assert
	doins -r src/.
}
