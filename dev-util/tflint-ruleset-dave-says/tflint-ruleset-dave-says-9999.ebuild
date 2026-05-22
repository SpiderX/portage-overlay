# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module readme.gentoo-r1

DESCRIPTION="TFLint plugin to make sure you follow the rules"
HOMEPAGE="https://github.com/skwashd/tflint-ruleset-dave-says"
EGIT_REPO_URI="https://github.com/skwashd/${PN}.git"

LICENSE="MIT"
SLOT="0"

BDEPEND=">=dev-lang/go-1.26.0:="

DOC_CONTENTS="You should create a symlink to tflint-ruleset-dave-says\\n
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
	exeinto usr/share/tflint-ruleset/github.com/skwashd/"${PN}"/"${PV}"
	doexe tflint-ruleset-dave-says
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
