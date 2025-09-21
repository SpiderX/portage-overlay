# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="URI manipulation Library"
HOMEPAGE="https://github.com/thephpleague/uri"
EGIT_REPO_URI="https://github.com/thephpleague/uri.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*[xml]
	dev-php/fedora-autoloader
	dev-php/league-uri-interfaces"

src_install() {
	einstalldocs
	insinto /usr/share/php/League/Uri
	doins -r UriTemplate "${FILESDIR}"/autoload.php ./*.php
}
