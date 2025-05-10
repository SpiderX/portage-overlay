# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info

MY_PN="${PN//-bin/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="GPT partition table manipulator for Linux (EFI version)"
HOMEPAGE="https://sourceforge.net/projects/gptfdisk/"
SRC_URI="https://downloads.sourceforge.net/project/gptfdisk/gptfdisk/${PV}/gdisk-binaries/${MY_P}.zip"
S="${WORKDIR}/${MY_PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="bindist mirror"

BDEPEND="app-arch/unzip"

DOCS=( README-efi.txt )

CONFIG_CHECK="EFI EFI_PARTITION"

src_install() {
	einstalldocs
	insinto /boot
	doins gdisk_x64.efi
}
