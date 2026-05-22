# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module readme.gentoo-r1

DESCRIPTION="TFLint Ruleset: Elements of Style"
HOMEPAGE="https://github.com/tfctl/tflint-ruleset-elements-of-style"
EGIT_REPO_URI="https://github.com/tfctl/${PN}.git"

LICENSE="BSD"
SLOT="0"

BDEPEND=">=dev-lang/go-1.25.3:="

DOC_CONTENTS="You should create a symlink to tflint-ruleset-elements-of-style\\n
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
	exeinto usr/share/tflint-ruleset/github.com/tfctl/"${PN}"/"${PV}"
	doexe tflint-ruleset-elements-of-style
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
