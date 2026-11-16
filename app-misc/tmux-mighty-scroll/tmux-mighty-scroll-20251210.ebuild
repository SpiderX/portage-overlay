# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit toolchain-funcs

COMMIT="fa5db0718e9e9f7278520ecf63b96b84b0cc57d6"

DESCRIPTION="Seamless mouse scroll in tmux"
HOMEPAGE="https://github.com/noscript/tmux-mighty-scroll"
SRC_URI="https://github.com/noscript/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-misc/tmux"

PATCHES=( "${FILESDIR}/${PN}"-20241109-prefetch-build.patch )

src_compile() {
	edo "$(tc-getCC)" ${CFLAGS} ${LDFLAGS} -o pscheck pscheck.c
}

src_test() {
	edo ./test.sh
}

src_install() {
	einstalldocs
	dobin pscheck
	insinto /usr/share/tmux-plugins/tmux-mighty-scroll
	doins -r scripts tmux.conf mighty-scroll.tmux
	fperms +x /usr/share/tmux-plugins/tmux-mighty-scroll/mighty-scroll.tmux
}
