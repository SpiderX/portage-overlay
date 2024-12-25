# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="f1887ed0eb3f95e138394f401dd673144f9aa94c"

DESCRIPTION="Automatically fetches current opened git repositories"
HOMEPAGE="https://github.com/thepante/tmux-git-autofetch"
SRC_URI="https://github.com/thepante/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-misc/tmux
	dev-vcs/git"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-git-autofetch
	doins git-autofetch.tmux
	fperms +x /usr/share/tmux-plugins/tmux-git-autofetch/git-autofetch.tmux
}
