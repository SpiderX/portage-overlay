# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/php-cache/tag-interop.git"

inherit git-r3

DESCRIPTION="Shared interfaces for tags. These are soon-to-be-PSR"
HOMEPAGE="https://github.com/php-cache/tag-interop"

LICENSE="MIT"
SLOT="0"
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
