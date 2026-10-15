# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3 go-module shell-completion

DESCRIPTION="Tool for synchronizing Helm Chart repositories"
HOMEPAGE="https://github.com/bitnami/charts-syncer"
EGIT_REPO_URI="https://github.com/bitnami/${PN}.git"

LICENSE="Broadcom"
SLOT="0"
RESTRICT="test"
PROPERTIES="test_network"

BDEPEND=">=dev-lang/go-1.26"

DOCS=( {docs/airgap,README}.md )

src_compile() {
	ego build -ldflags="-w -X main.version=${PV}" -o charts-syncer ./cmd
	local completion
	for completion in bash fish zsh ; do
		edo ./charts-syncer completion "${completion}" > charts-syncer."${completion}"
	done
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin charts-syncer
	newbashcomp charts-syncer.bash charts-syncer
	dofishcomp charts-syncer.fish charts-syncer
	newzshcomp charts-syncer.zsh _charts-syncer
}
