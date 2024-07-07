# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/symfony/polyfill-php80.git"

inherit git-r3

DESCRIPTION="Backport of some PHP 8.0+ features to lower PHP versions"
HOMEPAGE="https://github.com/symfony/polyfill-php80"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no phpunit

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="dev-php/theseer-Autoload"

src_prepare() {
	default

	phpab --quiet --output autoload.php \
		--template fedora2 --basedir . . \
		|| die "phpab failed"

	echo "\Fedora\Autoloader\Dependencies::required([__DIR__ . '/bootstrap.php']);" >> autoload.php
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Polyfill-php80
	doins -r Resources *.php
}
