# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs unpacker

MY_P="anf_capd_0_06_public"

DESCRIPTION="Utilities for Assimetric NAT module for Linux xtables"
HOMEPAGE="https://forum.nag.ru/index.php?/topic/195398-anat-advanced-asymmetric-cg-nat-xt_anat-module-yadra-dlya-linux"
SRC_URI="${MY_P}.7z"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="app-arch/p7zip"

DOCS=( doc_anf_ru.txt )

pkg_nofetch() {
	einfo "Please download ${MY_P} from"
	einfo "${HOMEPAGE}"
	einfo "and place it into your DISTDIR directory"
}

src_prepare() {
	default

	# replace gcc add flags
	sed -i \
		-e '/CC=gcc/d' \
		-e '/CFLAGS/s|=|+=|' \
		-e '/LDFLAGS=/d'\
		Makefile || die "sed failed for Makefile"
}

src_compile() {
	tc-export CC
	emake
}

src_install() {
	einstalldocs
	dobin anf_{capd,prcf}
}
