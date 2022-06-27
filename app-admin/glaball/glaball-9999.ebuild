# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/flant/${PN}.git"

inherit bash-completion-r1 edo git-r3 go-module

DESCRIPTION="Gitlab bulk administration tool"
HOMEPAGE="https://github.com/flant/glaball"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
RESTRICT="test" # no tests

src_compile() {
	LDFLAGS="-X github.com/flant/glaball/pkg/util.Version=${PV}
		-X github.com/flant/glaball/pkg/util.Revision=${COMMIT}
		-X github.com/flant/glaball/pkg/util.Branch=main
		-X github.com/flant/glaball/pkg/util.BuildUser=portage
		-X github.com/flant/glaball/pkg/util.BuildDate=$(date +%Y%m%d%H%M)"
	ego build -ldflags "$LDFLAGS"

	local completion
	for completion in bash zsh ; do
		edo ./glaball completion ${completion} > globall.${completion} \
			|| die "completion for ${completion} failed"
	done
}

src_install() {
	einstalldocs
	dobin glaball

	newbashcomp globall.bash globall
	insinto /usr/share/zsh/site-functions
	newins globall.zsh _globall
}
