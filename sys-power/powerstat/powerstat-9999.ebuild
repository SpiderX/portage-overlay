# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 toolchain-funcs

DESCRIPTION="Laptop power measuring tool"
HOMEPAGE="https://launchpad.net/ubuntu/+source/powerstat https://github.com/ColinIanKing/powerstat"
SRC_URI=""
EGIT_REPO_URI=(
	"git://kernel.ubuntu.com/cking/${PN}.git"
	"https://github.com/ColinIanKing/${PN}.git"
	)

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE=""

src_compile() {
	emake CC="$(tc-getCC)"
}
