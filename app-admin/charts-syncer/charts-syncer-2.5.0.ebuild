# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit go-module shell-completion

DESCRIPTION="Tool for synchronizing Helm Chart repositories"
HOMEPAGE="https://github.com/bitnami/charts-syncer"
SRC_URI="https://github.com/bitnami/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="Broadcom"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
	newfishcomp charts-syncer.fish charts-syncer
	newzshcomp charts-syncer.zsh _charts-syncer
}
