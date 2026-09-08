# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="DaveRandom/LibDNS"
COMPOSER_PKG="LibDNS"
PHP_REQ_USE="ctype"

inherit composer git-r3

DESCRIPTION="DNS implementation in pure PHP"
HOMEPAGE="https://github.com/DaveRandom/LibDNS"
EGIT_REPO_URI="https://github.com/DaveRandom/LibDNS.git"

LICENSE="MIT"
SLOT="0"
IUSE="ipv6"

RDEPEND="dev-php/daverandom-callback-validator
	dev-php/daverandom-enum
	dev-php/daverandom-network-primitives"

PATCHES=( "${FILESDIR}/${PN}"-9999-src-functions.patch
	"${FILESDIR}/${PN}"-9999-src-HostsFile.patch
	"${FILESDIR}/${PN}"-9999-src-ParsingContext.patch
	"${FILESDIR}/${PN}"-9999-tests-BigEndToEndTest.patch
	"${FILESDIR}/${PN}"-9999-tests-HostsFileTest.patch )

src_prepare() {
	composer_src_prepare

	sed -i '/addPsr4/s|LibDNS|DaveRandom\\\\LibDNS|' src/autoload.php || die "sed failed"
	use ipv6 || eapply "${FILESDIR}/${PN}"-9999-tests-no-ipv6.patch
}
