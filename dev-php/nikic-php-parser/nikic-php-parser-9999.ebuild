# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/nikic/PHP-Parser.git"

inherit git-r3

DESCRIPTION="A PHP parser written in PHP"
HOMEPAGE="https://github.com/nikic/PHP-Parser"

LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[tokenizer]
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/phpunit )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		lib/PhpParser/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_compile() { :; }

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/nikic
	doins -r lib/.
}
