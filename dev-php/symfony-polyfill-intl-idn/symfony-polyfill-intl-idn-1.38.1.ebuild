# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMPOSER_INSTALL_PATH="Symfony/Polyfill/Intl/Idn"
COMPOSER_INSTALL_SRC="."

inherit composer optfeature

DESCRIPTION="Symfony polyfill for intl's idn_to_ascii and idn_to_utf8 functions"
HOMEPAGE="https://github.com/symfony/polyfill-intl-idn"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-php/symfony-polyfill-intl-normalizer"

pkg_postinst() {
	optfeature "Support of more locales" dev-lang/php[intl]
}
