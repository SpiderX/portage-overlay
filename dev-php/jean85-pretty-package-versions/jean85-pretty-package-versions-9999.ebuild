# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Independent wrapper to get pretty versions strings"
HOMEPAGE="https://github.com/Jean85/pretty-package-versions"
EGIT_REPO_URI="https://github.com/Jean85/pretty-package-versions.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # tests require useless packages

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"

src_install() {
	einstalldocs
	insinto /usr/share/php/Jean85
	doins -r "${FILESDIR}"/autoload.php src/.
}
