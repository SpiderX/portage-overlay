# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//composer-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="PCRE wrapping library that offers type-safe preg_ replacements"
HOMEPAGE="https://github.com/composer/pcre"
SRC_URI="https://github.com/composer/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # https://github.com/sebastianbergmann/phpunit/issues/5062

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"

src_install() {
	einstalldocs
	insinto /usr/share/php/Composer/Pcre
	doins -r "${FILESDIR}"/autoload.php src/.
}
