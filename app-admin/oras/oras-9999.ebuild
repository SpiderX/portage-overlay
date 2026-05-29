# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo git-r3 go-module shell-completion

DESCRIPTION="A CLI to push and pull files from any OCI registry"
HOMEPAGE="https://github.com/oras-project/oras"
EGIT_REPO_URI="https://github.com/oras-project/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

BDEPEND=">=dev-lang/go-1.26.2"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build -o oras ./cmd/oras
	local completion
	for completion in bash fish zsh ; do
		edo ./oras completion ${completion} > oras.${completion}
	done
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin oras

	newbashcomp oras.bash oras
	newfishcomp oras.fish oras
	newzshcomp oras.zsh _oras
}
