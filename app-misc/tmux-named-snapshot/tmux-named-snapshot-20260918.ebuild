# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMMIT="47615c4984ed79daab947e6d85a192c8d3b113e7"

DESCRIPTION="A tmux-resurrect extension for named snapshot support"
HOMEPAGE="https://github.com/spywhere/tmux-named-snapshot"
SRC_URI="https://github.com/spywhere/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-named-snapshot
	doins -r scripts named-snapshot.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-named-snapshot/scripts/{restore,save}-snapshot.sh \
		/usr/share/tmux-plugins/tmux-named-snapshot/named-snapshot.tmux
}
