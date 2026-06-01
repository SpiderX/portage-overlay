# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module readme.gentoo-r1

DESCRIPTION="Terraform VMware vCloud Director provider"
HOMEPAGE="https://registry.terraform.io/providers/vmware/vcd/latest/docs"
SRC_URI="https://github.com/vmware/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="|| ( app-admin/terraform app-admin/opentofu )"

DOCS=( {CHANGELOG,README,TROUBLESHOOTING}.md )

DOC_CONTENTS="You should create a symlink to\\n
/usr/share/terraform-provider/terraform-provider-vcd\\n
in ~/.terraform.d/plugins or ~/.opentofu.d/plugins\\n"

src_compile() {
	LDFLAGS="-X github.com/vmware/terraform-provider-vcd/v3/vcd.BuildVersion=${PV}"
	ego build -ldflags "${LDFLAGS}"
}

src_test() {
	ego test -w ./vcd/...
}

src_install() {
	einstalldocs
	exeinto /usr/share/terraform-provider
	doexe terraform-provider-vcd
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
