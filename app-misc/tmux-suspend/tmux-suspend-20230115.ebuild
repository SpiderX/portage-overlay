# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="1a2f806666e0bfed37535372279fa00d27d50d14"

DESCRIPTION="Suspend local tmux session"
HOMEPAGE="https://github.com/MunifTanjim/tmux-suspend"
SRC_URI="https://github.com/MunifTanjim/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-suspend
	doins -r scripts suspend.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-suspend/scripts \
		/usr/share/tmux-plugins/tmux-suspend/suspend.tmux
}
