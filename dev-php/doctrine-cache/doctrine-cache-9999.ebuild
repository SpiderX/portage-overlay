# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Doctrine Cache"
HOMEPAGE="https://github.com/doctrine/cache"
EGIT_REPO_URI="https://github.com/doctrine/cache.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # deprecated

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		lib/Doctrine/Common/Cache/autoload.php || die "install failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php
	doins -r lib/.
}
