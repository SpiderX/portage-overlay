# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Amp/Dns"
PHP_REQ_USE="filter,ipv6?"

inherit composer git-r3

DESCRIPTION="Async DNS resolution for PHP"
HOMEPAGE="https://github.com/amphp/dns"
EGIT_REPO_URI="https://github.com/amphp/dns.git"

LICENSE="MIT"
SLOT="0"
IUSE="ipv6"

RDEPEND="dev-php/amphp-amp
	dev-php/amphp-byte-stream
	dev-php/amphp-cache
	dev-php/amphp-parser
	dev-php/amphp-windows-registry
	dev-php/daverandom-libdns
	dev-php/revolt-event-loop"

PATCHES=( "${FILESDIR}/${PN}"-2.4.0-tests-DnsCacheTrainer.patch
	"${FILESDIR}/${PN}"-2.4.0-tests-DnsConfigTest.patch
	"${FILESDIR}/${PN}"-2.4.0-tests-IntegrationTest.patch
	"${FILESDIR}/${PN}"-2.4.0-tests-Rfc1035StubResolverTest.patch
	"${FILESDIR}/${PN}"-2.4.0-tests-phpunit.xml.patch )

composer_enable_tests phpunit

src_prepare() {
	composer_src_prepare

	use ipv6 || eapply "${FILESDIR}/${PN}"-2.4.0-tests-no-ipv6.patch
}
