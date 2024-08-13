# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/composer/pcre.git"

inherit git-r3

DESCRIPTION="PCRE wrapping library that offers type-safe preg_ replacements"
HOMEPAGE="https://github.com/composer/pcre"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # https://github.com/sebastianbergmann/phpunit/issues/5062

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"

src_install() {
	einstalldocs
	insinto /usr/share/php/Composer/Pcre
	doins -r "${FILESDIR}"/autoload.php src/.
}
