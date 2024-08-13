# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/symfony/polyfill-intl-normalizer.git"

inherit git-r3

DESCRIPTION="Symfony polyfill for intl's Normalizer class"
HOMEPAGE="https://github.com/symfony/polyfill-intl-normalizer"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Polyfill/Intl/Normalizer
	doins -r Resources "${FILESDIR}"/autoload.php ./*.php
}
