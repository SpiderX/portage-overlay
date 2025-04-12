# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="e91c1ae55389f2b34480ea23df77682bdd51d735"

DESCRIPTION="Use fzf to manage your tmux work environment"
HOMEPAGE="https://github.com/sainnhe/tmux-fzf"
SRC_URI="https://github.com/sainnhe/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-shells/fzf
	app-misc/tmux
	sys-process/procps"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-fzf
	doins -r scripts main.{sh,tmux}
	fperms -R +x /usr/share/tmux-plugins/tmux-fzf/scripts
		/usr/share/tmux-plugins/tmux-fzf/main.{sh,tmux}
}
