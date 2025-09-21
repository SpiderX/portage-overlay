# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="League URI Interfaces"
HOMEPAGE="https://github.com/thephpleague/uri-interfaces"
EGIT_REPO_URI="https://github.com/thephpleague/uri-interfaces.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*[filter]
	dev-php/fedora-autoloader
	dev-php/psr-http-factory
	dev-php/psr-http-message"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		Interfaces/autoload.php || die "install failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/League/Uri
	doins -r Contracts Exceptions Interfaces IPv4 IPv6 Idna KeyValuePair ./*.php
}
