# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo go-module shell-completion

DESCRIPTION="A CLI to push and pull files from any OCI registry"
HOMEPAGE="https://github.com/oras-project/oras"
SRC_URI="https://github.com/oras-project/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND=">=dev-lang/go-1.26.2"

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
