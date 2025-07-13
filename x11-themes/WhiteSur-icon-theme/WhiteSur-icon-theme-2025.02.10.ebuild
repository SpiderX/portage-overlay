# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

inherit xdg

MY_PV="${PV//./-}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="comes in both light and dark variants"
HOMEPAGE="https://github.com/vinceliuice/WhiteSur-icon-theme"
SRC_URI="https://github.com/vinceliuice/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="all alternative black bold +default green grey nord orange pink purple red yellow"
REQUIRED_USE="^^ ( all default green grey nord orange pink purple red yellow )"

PATCHES=( "${FILESDIR}/${PN}"-2025.02.10-install.patch )

src_install() {
	local TV OPTIONS
	OPTIONS="WhiteSur"
	for color in all default green grey nord orange pink purple red yellow ; do
		use "$color" && TV="$color"
	done
	for option in alternative black bold ; do
		use "$option" && OPTIONS="${OPTIONS} --$option"
	done

	# OPTIONS should not be quoted, params must be splitted
	./install.sh -d "${ED}/usr/share/icons" -n $OPTIONS -t "${TV}" \
		|| die "install failed"
}
