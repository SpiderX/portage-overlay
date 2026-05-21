# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="A Pluggable Terraform Linter"
HOMEPAGE="https://github.com/terraform-linters/tflint"
EGIT_REPO_URI="https://github.com/terraform-linters/${PN}.git"

LICENSE="MPL-2.0"
SLOT="0"
RESTRICT="test"
PROPERTIES="test_network"

BDEPEND=">=dev-lang/go-1.26.3:="

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build -o dist/tflint
}

src_test() {
	mapfile -t pkgs < <( ego list ./... | grep -Ev '/(test-fixtures|stub-generator|integrationtest)' )
	ego test -timeout 5m -skip 'Test_Discovery|Test_FindPluginPath|TestLoadConfig' "${pkgs[@]}"
}

src_install() {
	einstalldocs
	dobin dist/tflint
}
