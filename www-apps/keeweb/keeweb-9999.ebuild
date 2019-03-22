# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/keeweb/${PN}.git"
EGIT_BRANCH="gh-pages"

inherit git-r3 webapp

WEBAPP_MANUAL_SLOT="yes"

DESCRIPTION="Cross-platform password manager compatible with KeePass"
HOMEPAGE="https://github.com/keeweb/keeweb"
SRC_URI=""

LICENSE="MIT"
SLOT=0
KEYWORDS=""
IUSE="vhosts"

DEPEND="${WEBAPP_DEPEND}"
RDEPEND="${DEPEND}"

src_install() {
	webapp_src_preinst
	rm CNAME || die "rm failed"
	cp -R . "${ED%/}"/"${MY_HTDOCSDIR}" || die "cp failed"
	webapp_src_install
}
