# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/terraform-providers/${PN}.git"

inherit git-r3 go-module readme.gentoo-r1

DESCRIPTION="Terraform VMware vCloud Director provider"
HOMEPAGE="https://www.terraform.io/docs/providers/vcd"
SRC_URI=""

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="mirror test"

RDEPEND="app-admin/terraform"

DOCS=( {CHANGELOG,README,TROUBLESHOOTING}.md )

DOC_CONTENTS="You should create a symlink to\\n
/usr/share/terraform-provider-vcd/terraform-provider-vcd\\n
in ~/.terraform.d/plugins\\n"

src_unpack() {
	git-r3_src_unpack
	rm -rf "${S}"/vendor || die "rm failed"
	go-module_live_vendor
}

src_compile() {
	go build || die "build failed"
}

src_install() {
	einstalldocs
	exeinto usr/share/terraform-provider-vcd
	doexe terraform-provider-vcd
	readme.gentoo_create_doc
}

pkg_postinst() {
	go-module_pkg_postinst
	readme.gentoo_print_elog
}
