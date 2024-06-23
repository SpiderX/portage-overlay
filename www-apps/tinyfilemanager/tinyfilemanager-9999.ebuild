# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/prasathmani/${PN}.git"

inherit git-r3 webapp

DESCRIPTION="Single-file PHP file manager"
HOMEPAGE="https://github.com/prasathmani/tinyfilemanager"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="dev-lang/php[fileinfo,iconv,session,unicode,zip]"

DOCS=( {README,SECURITY}.md )

src_install() {
	einstalldocs
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins tinyfilemanager.php translation.json
	doins -r assets
	webapp_src_install
}
