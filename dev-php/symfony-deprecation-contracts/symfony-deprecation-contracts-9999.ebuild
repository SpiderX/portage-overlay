# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="A generic function and convention to trigger deprecation notices"
HOMEPAGE="https://github.com/symfony/deprecation-contracts"
EGIT_REPO_URI="https://github.com/symfony/deprecation-contracts.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="dev-php/theseer-Autoload"

DOCS=( {CHANGELOG,README}.md )

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Contracts/Deprecation
	doins -r "${FILESDIR}"/autoload.php ./*.php
}
