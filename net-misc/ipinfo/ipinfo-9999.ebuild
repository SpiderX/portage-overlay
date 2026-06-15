# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo git-r3 go-module shell-completion

DESCRIPTION="Look up IP details in bulk or one-by-one"
HOMEPAGE="https://github.com/ipinfo/cli"
EGIT_REPO_URI="https://github.com/ipinfo/cli.git"

LICENSE="Apache-2.0"
SLOT="0"

DOCS=( {ipinfo/CHANGELOG,README}.md )

src_unpack() {
	git-r3_src_unpack
}

src_compile() {
	GOFLAGS="-v -x -mod=vendor" ego build -o build/ipinfo ./ipinfo/...

	local completion
	for completion in bash fish zsh ; do
		edo build/ipinfo completion ${completion} > ipinfo.${completion}
	done
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" ego test -work ./ipinfo/...
}

src_install() {
	einstalldocs
	dobin build/ipinfo

	newbashcomp ipinfo.bash ipinfo
	newfishcomp ipinfo.fish ipinfo
	newzshcomp ipinfo.zsh _ipinfo
}
