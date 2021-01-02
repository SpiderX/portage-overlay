# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

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
	einstalldocs
	emake PREFIX=/usr DESTDIR="${D}" install
	save_config config.h
}
