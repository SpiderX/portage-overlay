# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo go-module shell-completion

DESCRIPTION="An MMDB file management CLI"
HOMEPAGE="https://github.com/ipinfo/mmdbctl"
SRC_URI="https://github.com/ipinfo/${PN}/archive/${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"
S="${WORKDIR}/${PN}-${P}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( {CHANGELOG,README}.md )

src_compile() {
	ego build

	local completion
	for completion in bash fish zsh ; do
		edo ./mmdbctl completion ${completion} > mmdbctl.${completion}
	done
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin mmdbctl

	newbashcomp mmdbctl.bash mmdbctl
	newfishcomp mmdbctl.fish mmdbctl
	newzshcomp mmdbctl.zsh _mmdbctl
}
