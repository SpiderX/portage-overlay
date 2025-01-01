# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="11acbea4adffaff575d772d16d7dcb3c3ad3c89d"

DESCRIPTION="Filter logs by some text or pattern"
HOMEPAGE="https://github.com/MaximilianGaedig/tmux-filter"
SRC_URI="https://github.com/MaximilianGaedig/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-filter
	doins -r scripts filter.tmux
	fperms +x /usr/share/tmux-plugins/tmux-filter/scripts/live-filter.bash \
		/usr/share/tmux-plugins/tmux-filter/filter.tmux
}
