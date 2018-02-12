# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit savedconfig

DESCRIPTION="A simple command line pastebin designed to be used together with ssh"
HOMEPAGE="https://github.com/vehk/keening"
SRC_URI="https://github.com/SpiderX/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="mirror"

DOCS=( README.md )

src_prepare() {
	default

	restore_config config.h
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install
	einstalldocs
	save_config config.h
}
