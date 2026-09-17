# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo go-module shell-completion

DESCRIPTION="Multi pod and container log tailing for Kubernetes"
HOMEPAGE="https://github.com/stern/stern"
SRC_URI="https://github.com/stern/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND=">=dev-lang/go-1.26.2"

DOCS=( {CHANGELOG,README}.md )

src_compile() {
	ego build -ldflags="-X github.com/stern/stern/cmd.version=${PV}" -o dist/stern

	local completion
	for completion in bash zsh fish ; do
		edo dist/stern --completion "${completion}" > stern."${completion}"
	done
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin dist/stern

	newbashcomp stern.bash stern
	newfishcomp stern.fish stern
	newzshcomp stern.zsh _stern
}
