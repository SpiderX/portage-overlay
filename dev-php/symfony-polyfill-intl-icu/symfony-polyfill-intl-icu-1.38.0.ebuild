# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMPOSER_INSTALL_PATH="Symfony/Polyfill/Intl/Icu"
COMPOSER_INSTALL_SRC="."

inherit composer optfeature

DESCRIPTION="Symfony polyfill for intl's ICU-related data and classes"
HOMEPAGE="https://github.com/symfony/polyfill-intl-icu"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

pkg_postinst() {
	optfeature "Support of more locales" dev-lang/php[intl]
}
