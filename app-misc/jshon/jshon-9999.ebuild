# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 toolchain-funcs

DESCRIPTION="JSON parser designed for maximum convenience within the shell"
HOMEPAGE="http://kmkeen.com/jshon https://github.com/keenerd/jshon"
SRC_URI=""
EGIT_REPO_URI="https://github.com/keenerd/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="zsh-completion"

DEPEND="dev-libs/jansson"
RDEPEND="${DEPEND}
	zsh-completion? ( app-shells/zsh-completions )"

src_prepare() {
	default

	if ! use zsh-completion ; then
		sed -i '/$(INSTALL) -D $(ZSHSRC) $(ZSHCOMP)/d' \
			Makefile || die "sed failed for Makefile"
	fi
}

src_compile() {
	emake CC="$(tc-getCC)"
}
