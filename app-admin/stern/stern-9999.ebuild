# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo git-r3 go-module shell-completion

DESCRIPTION="Multi pod and container log tailing for Kubernetes"
HOMEPAGE="https://github.com/stern/stern"
EGIT_REPO_URI="https://github.com/stern/stern.git"

LICENSE="Apache-2.0"
SLOT="0"

BDEPEND=">=dev-lang/go-1.26.2"

DOCS=( {CHANGELOG,README}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

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
