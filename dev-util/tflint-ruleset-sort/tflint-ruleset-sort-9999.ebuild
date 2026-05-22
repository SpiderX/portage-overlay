# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module readme.gentoo-r1

DESCRIPTION="TFLint Ruleset Sort"
HOMEPAGE="https://github.com/thespags/tflint-ruleset-sort"
EGIT_REPO_URI="https://github.com/thespags/${PN}.git"

LICENSE="BSD"
SLOT="0"

BDEPEND=">=dev-lang/go-1.26.1:="

DOC_CONTENTS="You should create a symlink to tflint-ruleset-sort\\n
in ~/.tflint.d/plugins or define another path to plugins\\n"

src_compile() {
	ego build
}

src_test() {
	ego test ./...
}

src_install() {
	einstalldocs
	exeinto usr/share/tflint-ruleset/github.com/thespags/"${PN}"/"${PV}"
	doexe tflint-ruleset-sort
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
