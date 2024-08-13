# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//league-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="URI manipulation Library"
HOMEPAGE="https://github.com/thephpleague/uri"
SRC_URI="https://github.com/thephpleague/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*[xml]
	dev-php/fedora-autoloader
	dev-php/league-uri-interfaces"

src_install() {
	einstalldocs
	insinto /usr/share/php/League/Uri
	doins -r UriTemplate "${FILESDIR}"/autoload.php ./*.php
}
