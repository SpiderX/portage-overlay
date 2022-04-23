# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info systemd toolchain-funcs

DESCRIPTION="Minimalistic PSI notifier using libnotify"
HOMEPAGE="https://github.com/cdown/psi-notify"
SRC_URI="https://github.com/cdown/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="x11-libs/libnotify"
BDEPEND="virtual/pkgconfig"

CONFIG_CHECK="~PSI"

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	einstalldocs
	dobin psi-notify

	newinitd "${FILESDIR}"/psi-notify.initd psi-notify
	systemd_dounit psi-notify.service
}
