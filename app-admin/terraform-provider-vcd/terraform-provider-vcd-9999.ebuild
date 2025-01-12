# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/vmware/${PN}.git"

inherit git-r3 go-module readme.gentoo-r1

DESCRIPTION="Terraform VMware vCloud Director provider"
HOMEPAGE="https://registry.terraform.io/providers/vmware/vcd/latest/docs"

LICENSE="MPL-2.0"
SLOT="0"
RESTRICT="mirror test"

RDEPEND="app-admin/terraform"

DOCS=( {CHANGELOG,README,TROUBLESHOOTING}.md )

DOC_CONTENTS="You should create a symlink to\\n
/usr/share/terraform-provider-vcd/terraform-provider-vcd\\n
in ~/.terraform.d/plugins\\n"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-X github.com/vmware/terraform-provider-vcd/v3/vcd.BuildVersion=${PV}"

	ego build -ldflags "${LDFLAGS}"
}

src_install() {
	einstalldocs
	exeinto usr/share/terraform-provider-vcd
	doexe terraform-provider-vcd
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
