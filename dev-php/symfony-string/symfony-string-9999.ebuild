# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/symfony/string.git"

inherit git-r3

DESCRIPTION="An object-oriented API to strings"
HOMEPAGE="https://github.com/symfony/string"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no phpunit

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-polyfill-ctype
	dev-php/symfony-polyfill-intl-grapheme
	dev-php/symfony-polyfill-intl-normalizer
	dev-php/symfony-polyfill-mbstring"
BDEPEND="dev-php/theseer-Autoload"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	phpab --quiet --output autoload.php \
		--template fedora2 --basedir . . \
		|| die "phpab failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/String
	doins -r Exception Inflector Resources Slugger *.php
}
