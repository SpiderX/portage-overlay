# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/sebastianbergmann/version.git"

inherit git-r3

DESCRIPTION="Library that helps with managing the version number"
HOMEPAGE="https://github.com/sebastianbergmann/version"

LICENSE="BSD"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="dev-php/theseer-Autoload"

DOCS=( {ChangeLog,README}.md )

src_prepare() {
	default

	phpab -q -o src/autoload.php -t fedora2 src || die "phpab failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/SebastianBergmann/Version
	doins -r src/.
}
