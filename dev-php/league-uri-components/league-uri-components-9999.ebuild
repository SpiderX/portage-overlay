# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/thephpleague/uri-components.git"

inherit git-r3

DESCRIPTION="League URI Components"
HOMEPAGE="https://github.com/thephpleague/uri-components"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/league-uri"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		Components/autoload.php || die "install failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/League/Uri
	doins -r Components ./*.php
}
