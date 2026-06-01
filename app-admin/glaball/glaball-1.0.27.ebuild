# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo go-module shell-completion

COMMIT="97da624"

DESCRIPTION="Gitlab bulk administration tool"
HOMEPAGE="https://github.com/flant/glaball"
SRC_URI="https://github.com/flant/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

src_compile() {
	LDFLAGS="-X github.com/flant/glaball/pkg/util.Version=${PV}
		-X github.com/flant/glaball/pkg/util.Revision=${COMMIT}
		-X github.com/flant/glaball/pkg/util.Branch=main
		-X github.com/flant/glaball/pkg/util.BuildUser=portage
		-X github.com/flant/glaball/pkg/util.BuildDate=$(date +%Y%m%d%H%M)"
	ego build -ldflags "$LDFLAGS"

	local completion
	for completion in bash fish zsh ; do
		edo ./glaball completion ${completion} > globall.${completion}
	done
}

src_install() {
	einstalldocs
	dobin glaball

	newbashcomp globall.bash globall
	newfishcomp globall.fish globall
	newzshcomp globall.zsh _globall
}
