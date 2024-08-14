# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//symfony-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Symfony polyfill for intl's idn_to_ascii and idn_to_utf8 functions"
HOMEPAGE="https://github.com/symfony/polyfill-intl-idn"
SRC_URI="https://github.com/symfony/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-polyfill-intl-normalizer"

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Polyfill/Intl/Idn
	doins -r Resources "${FILESDIR}"/autoload.php ./*.php
}
