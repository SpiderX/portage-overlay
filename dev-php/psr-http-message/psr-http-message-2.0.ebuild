# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//psr-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Common interfaces for HTTP messages"
HOMEPAGE="https://github.com/php-fig/http-message"
SRC_URI="https://github.com/php-fig/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"

DOCS=( {CHANGELOG,README}.md )

src_install() {
	einstalldocs
	insinto /usr/share/php/Psr/Http/Message
	doins -r "${FILESDIR}"/autoload.php src/.
}
