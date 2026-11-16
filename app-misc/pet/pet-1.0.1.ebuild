# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit go-module shell-completion

DESCRIPTION="Simple command-line snippet manager"
HOMEPAGE="https://github.com/knqyf263/pet"
SRC_URI="https://github.com/knqyf263/pet/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="Apache-2.0 BSD BSD-2 MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	emake build
}

src_install() {
	dobin pet
	dozshcomp misc/completions/zsh/_pet
}

pkg_postinst() {
	if ! has_version app-shells/peco && ! has_version app-shells/fzf ; then
		einfo "You should consider to install app-shells/peco or"
		einfo "app-shells/fzf to be able to use selector command"
	fi
}
