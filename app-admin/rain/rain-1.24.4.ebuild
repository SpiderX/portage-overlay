# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo go-module shell-completion

DESCRIPTION="A development workflow tool for working with AWS CloudFormation"
HOMEPAGE="https://github.com/aws-cloudformation/rain"
SRC_URI="https://github.com/aws-cloudformation/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND=">=dev-lang/go-1.26.2"

src_compile() {
	ego build ./cmd/rain
	local completion
	for completion in bash fish zsh ; do
		edo ./rain completion ${completion} > rain.${completion}
	done
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin rain

	newbashcomp rain.bash rain
	newfishcomp rain.fish rain
	newzshcomp rain.zsh _rain
}
