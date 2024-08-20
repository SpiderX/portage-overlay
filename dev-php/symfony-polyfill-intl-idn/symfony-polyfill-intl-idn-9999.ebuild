# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/symfony/polyfill-intl-idn.git"

inherit git-r3 optfeature

DESCRIPTION="Symfony polyfill for intl's idn_to_ascii and idn_to_utf8 functions"
HOMEPAGE="https://github.com/symfony/polyfill-intl-idn"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-polyfill-intl-normalizer"

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Polyfill/Intl/Idn
	doins -r Resources "${FILESDIR}"/autoload.php ./*.php
}

pkg_postinst() {
	optfeature "Support of more locales" dev-lang/php[intl]
}
