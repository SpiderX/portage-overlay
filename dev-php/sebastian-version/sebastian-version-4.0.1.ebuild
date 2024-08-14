# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//sebastian-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Library that helps with managing the version number"
HOMEPAGE="https://github.com/sebastianbergmann/version"
SRC_URI="https://github.com/sebastianbergmann/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="dev-php/theseer-Autoload"

DOCS=( {ChangeLog,README}.md )

src_prepare() {
	default

	phpab -q -o src/autoload.php -t fedora2 src || die "phpab failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/SebastianBergmann/Version
	doins -r src/.
}
