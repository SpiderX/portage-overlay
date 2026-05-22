# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module readme.gentoo-r1

DESCRIPTION="TFLint Ruleset for Terraform Language"
HOMEPAGE="https://github.com/terraform-linters/tflint-ruleset-terraform"
EGIT_REPO_URI="https://github.com/terraform-linters/${PN}.git"

LICENSE="MPL-2.0"
SLOT="0"
RESTRICT="test"
PROPERTIES="test_network"

BDEPEND=">=dev-lang/go-1.25.5:="

DOC_CONTENTS="You should create a symlink to tflint-ruleset-terraform\\n
in ~/.tflint.d/plugins or define another path to plugins\\n"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build
}

src_test() {
	ego test ./...
}

src_install() {
	einstalldocs
	exeinto usr/share/tflint-ruleset/github.com/terraform-linters/"${PN}"/"${PV}"
	doexe tflint-ruleset-terraform
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
