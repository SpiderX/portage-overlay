# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module readme.gentoo-r1

DESCRIPTION="Terraform Provider for Proxmox"
HOMEPAGE="https://github.com/bpg/terraform-provider-proxmox"
EGIT_REPO_URI="https://github.com/bpg/${PN}.git"

LICENSE="MPL-2.0"
SLOT="0"

RDEPEND="|| ( app-admin/terraform app-admin/opentofu )"

DOCS=( {CHANGELOG,README}.md )

DOC_CONTENTS="You should create a symlink to\\n
/usr/share/terraform-provider/terraform-provider-proxmox\\n
in ~/.terraform.d/plugins or ~/.opentofu.d/plugins\\n"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build
}

src_install() {
	einstalldocs
	exeinto /usr/share/terraform-provider
	doexe terraform-provider-proxmox
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
