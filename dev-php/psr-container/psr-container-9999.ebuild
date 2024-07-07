# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/php-fig/container.git"

inherit git-r3

DESCRIPTION="Common Container Interface (PHP FIG PSR-11)"
HOMEPAGE="https://github.com/php-fig/container"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="dev-php/theseer-Autoload"

src_prepare() {
	default

	phpab --quiet --output autoload.php \
		--template fedora2 --basedir src/ src \
		|| die "phpab failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/PSR/Container
	doins -r autoload.php src/.
}
