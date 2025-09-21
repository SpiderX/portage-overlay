# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Symfony HttpClient Contracts"
HOMEPAGE="https://github.com/symfony/http-client-contracts"
EGIT_REPO_URI="https://github.com/symfony/http-client-contracts.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	! use ipv6 && eapply "${FILESDIR}/${PN}"-3.6.0-no-ipv6.patch
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Contracts/HttpClient
	doins -r Exception Test "${FILESDIR}"/autoload.php ./*.php
}
