# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Contracts/HttpClient"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Symfony HttpClient Contracts"
HOMEPAGE="https://github.com/symfony/http-client-contracts"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ipv6"
RESTRICT="test" # no tests

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	composer_src_prepare

	use ipv6 || eapply "${FILESDIR}/${PN}"-3.6.0-no-ipv6.patch
}
