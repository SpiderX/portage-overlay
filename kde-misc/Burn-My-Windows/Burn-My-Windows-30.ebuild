# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm edo

DESCRIPTION="Disintegrate your windows with style"
HOMEPAGE="https://github.com/Schneegans/Burn-My-Windows"
SRC_URI="https://github.com/Schneegans/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="5"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=kde-plasma/kwin-5.25:5"
BDEPEND="dev-lang/perl:0="

src_prepare() {
	default

	# do not create tarball
	sed -i '/tar/d' kwin/build.sh || die "sed failed"
}

src_configure() { :; }

src_compile() {
	edo kwin/build.sh
}

src_install() {
	einstalldocs

	insinto /usr/share/kwin/effects
	doins -r kwin/_build/.
}
