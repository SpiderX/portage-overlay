# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit go-module shell-completion

DESCRIPTION="Make JSON greppable"
HOMEPAGE="https://github.com/tomnomnom/gron"
SRC_URI="https://github.com/tomnomnom/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( {ADVANCED,CHANGELOG,README}.mkd )

src_compile() {
	LDFLAGS="-X main.gronVersion=${PV}"
	ego build -ldflags "${LDFLAGS}"
}

src_test() {
	ego test ./...
}

src_install() {
	einstalldocs
	dobin gron
	newfishcomp completions/gron.fish gron
}
