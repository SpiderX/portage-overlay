# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Symfony Cache Contracts"
HOMEPAGE="https://github.com/symfony/cache-contracts"
EGIT_REPO_URI="https://github.com/symfony/cache-contracts.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/psr-cache"

DOCS=( {CHANGELOG,README}.md )

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Contracts/Cache
	doins -r "${FILESDIR}"/autoload.php ./*.php
}
