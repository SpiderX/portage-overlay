# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

inherit xdg

MY_PV="${PV//./-}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="comes in both light and dark variants"
HOMEPAGE="https://github.com/vinceliuice/WhiteSur-icon-theme"
SRC_URI="https://github.com/vinceliuice/${PN}/archive/${MY_PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
IUSE="all alternative black bold +default green grey nord orange pink purple red yellow"
KEYWORDS="~amd64 ~x86"
REQUIRED_USE="^^ ( all default green grey nord orange pink purple red yellow )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default

	# Don't call it from install
	sed -i '/gtk-update-icon-cache/d' install.sh || die "sed failed"
}

src_install() {
	local TV OPTIONS
	OPTIONS="WhiteSur"
	for color in all default green grey nord orange pink red yellow ; do
		use "$color" && TV="$color"
	done
	for option in alternative black bold ; do
		use "$option" && OPTIONS="${OPTIONS} --$option"
	done

	# OPTIONS should not be quoted, params must be splitted
	./install.sh -d "${ED}/usr/share/icons" -n $OPTIONS -t "${TV}" \
		|| die "install failed"

	# Fix, remove broken links, add missed files
	dosym low-brightness.svg usr/share/icons/WhiteSur/actions/24/brightness-low.svg
	dosym low-brightness.svg usr/share/icons/WhiteSur-dark/actions/24/brightness-low.svg
	cp "${ED}"/usr/share/icons/WhiteSur/status/24/system-{log-out,reboot,shutdown,suspend}.svg \
		"${ED}"/usr/share/icons/WhiteSur/apps/scalable || die "cp system failed"
	cp "${ED}"/usr/share/icons/WhiteSur/status/24/system-suspend-hibernate.svg \
		"${ED}"/usr/share/icons/WhiteSur/apps/scalable/system-hibernate.svg \
		|| die "cp system-hibernate failed"
	rm "${ED}"/usr/share/icons/WhiteSur/apps/scalable/chrome-ciniambnphakdoflgeamacamhfllbkmo-Default.svg \
		"${ED}"/usr/share/icons/WhiteSur/apps/scalable/org.o20.word.svg \
		"${ED}"/usr/share/icons/WhiteSur/apps/scalable/onenote.svg \
		"${ED}"/usr/share/icons/WhiteSur/apps/scalable/microsoft-office-online.svg \
		"${ED}"/usr/share/icons/WhiteSur/apps/scalable/web-onenote.svg \
		"${ED}"/usr/share/icons/WhiteSur/apps/scalable/electron-outlook.svg \
		"${ED}"/usr/share/icons/WhiteSur/apps/scalable/brave-faolnafnngnfdaknnbpnkhgohbobgegn-Default.svg \
		"${ED}"/usr/share/icons/WhiteSur/apps/scalable/org.o20.svg \
		"${ED}"/usr/share/icons/WhiteSur/apps/scalable/io.gitlab.o20.onenote.svg \
		"${ED}"/usr/share/icons/WhiteSur/apps/scalable/com.corifeus.onenote.svg \
		"${ED}"/usr/share/icons/WhiteSur/apps/scalable/org.20.notes.svg \
		"${ED}"/usr/share/icons/WhiteSur/apps/scalable/p3x-onenote.svg \
		"${ED}"/usr/share/icons/WhiteSur/apps/scalable/io.gitlab.o20.word.svg \
		"${ED}"/usr/share/icons/WhiteSur/apps/scalable/chrome-faolnafnngnfdaknnbpnkhgohbobgegn-Default.svg \
		"${ED}"/usr/share/icons/WhiteSur/apps/scalable/org.o20.openpoint.svg \
		|| die "rm failed"
}
