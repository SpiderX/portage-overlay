# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/composer/${PN}.git"

inherit git-r3

DESCRIPTION="PCRE wrapping library that offers type-safe preg_ replacements"
HOMEPAGE="https://github.com/composer/pcre"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no phpunit

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="dev-php/theseer-Autoload"

src_prepare() {
	default

	phpab --quiet --output src/autoload.php \
		--template fedora2 --basedir src/ src \
		|| die "phpab failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Composer/Pcre
	doins -r src/.
}
