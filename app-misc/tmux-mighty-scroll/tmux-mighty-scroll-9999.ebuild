# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/noscript/${PN}.git"

inherit edo git-r3 toolchain-funcs

DESCRIPTION="Seamless mouse scroll in tmux"
HOMEPAGE="https://github.com/noscript/tmux-mighty-scroll"

LICENSE="MIT"
SLOT="0"

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
