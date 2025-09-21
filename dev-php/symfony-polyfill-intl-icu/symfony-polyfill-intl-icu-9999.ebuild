# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 optfeature

DESCRIPTION="Symfony polyfill for intl's ICU-related data and classes"
HOMEPAGE="https://github.com/symfony/polyfill-intl-icu"
EGIT_REPO_URI="https://github.com/symfony/polyfill-intl-icu.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Polyfill/Intl/Icu
	doins -r DateFormat Exception Resources "${FILESDIR}"/autoload.php ./*.php
}

pkg_postinst() {
	optfeature "Support of more locales" dev-lang/php[intl]
}
