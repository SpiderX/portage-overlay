# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 optfeature

DESCRIPTION="Symfony polyfill for intl's grapheme_ functions"
HOMEPAGE="https://github.com/symfony/polyfill-intl-grapheme"
EGIT_REPO_URI="https://github.com/symfony/polyfill-intl-grapheme.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Polyfill/Intl/Grapheme
	doins -r "${FILESDIR}"/autoload.php ./*.php
}

pkg_postinst() {
	optfeature "Support of more locales" dev-lang/php[intl]
}
