# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/symfony/deprecation-contracts.git"

inherit git-r3

DESCRIPTION="A generic function and convention to trigger deprecation notices"
HOMEPAGE="https://github.com/symfony/deprecation-contracts"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no phpunit

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="dev-php/theseer-Autoload"

DOCS=( {CHANGELOG,README}.md )

PATCHES=( "${FILESDIR}/${PN}"-3.5.0-autoload.patch )

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/DeprecationContracts
	doins -r *.php
}
