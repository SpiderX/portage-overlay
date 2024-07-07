# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/symfony/${PN}.git"

DESCRIPTION="Utilities to scan PHP code and generate class maps"
HOMEPAGE="https://github.com/composer/class-map-generator"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no phpunit

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-finder
	dev-php/pcre"
BDEPEND="dev-php/theseer-Autoload"

src_prepare() {
	default

	phpab --quiet --output src/autoload.php \
		--template fedora2 --basedir src/ src \
		|| die "phpab failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Composer/ClassMapGenerator
	doins -r src/.
}
