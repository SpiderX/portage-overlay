# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//cache-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Shared interfaces for tags. These are soon-to-be-PSR"
HOMEPAGE="https://github.com/php-cache/tag-interop"
SRC_URI="https://github.com/php-cache/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="!dev-php/cache
	dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/psr-cache"

DOCS=( {Changelog,README}.md )

src_install() {
	einstalldocs
	insinto /usr/share/php/Cache/TagInterop
	doins -r "${FILESDIR}"/autoload.php ./*.php
}
