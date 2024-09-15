# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/bpg/${PN}.git"

inherit git-r3 go-module readme.gentoo-r1

DESCRIPTION="Terraform Provider for Proxmox"
HOMEPAGE="https://registry.terraform.io/providers/bpg/proxmox/latest/docs"

LICENSE="MPL-2.0"
SLOT="0"
RESTRICT="mirror test"

RDEPEND="app-admin/terraform"

DOCS=( {CHANGELOG,README}.md )

DOC_CONTENTS="You should create a symlink to\\n
/usr/share/terraform-provider-proxmox/terraform-provider-proxmox\\n
in ~/.terraform.d/plugins\\n"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build
}

src_install() {
	einstalldocs
	exeinto usr/share/terraform-provider-proxmox
	doexe terraform-provider-proxmox
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
