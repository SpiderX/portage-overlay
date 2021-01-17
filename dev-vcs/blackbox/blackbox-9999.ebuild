# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/StackExchange/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Safely store secrets in Git/Mercurial/Subversion"
HOMEPAGE="https://github.com/StackExchange/blackbox"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="app-crypt/gnupg
	dev-vcs/git"

DOCS=( README-v2.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	go build ./cmd/blackbox || die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin blackbox
	dobin binv2/blackbox_{addadmin,cat,decrypt_all_files,decrypt_file,deregister_file,diff} \
		binv2/blackbox_{edit,edit_end,edit_start,initialize,list_admins,listadmins} \
		binv2/blackbox_{list_files,postdeploy,register_new_file,removeadmin,shred_all_files} \
		binv2/blackbox_{update_all_files,view,whatsnew}
}
