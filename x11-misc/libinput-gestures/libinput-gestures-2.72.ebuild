# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit python-single-r1 systemd xdg

DESCRIPTION="Actions gestures on your touchpad using libinput"
HOMEPAGE="https://github.com/bulletmark/libinput-gestures"
SRC_URI="https://github.com/bulletmark/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-libs/libinput
	x11-misc/wmctrl
	x11-misc/xdotool"
DEPEND="dev-libs/libinput
	dev-util/desktop-file-utils"

src_prepare() {
	default

	# Fix docdir installation path
	sed -i "/^DOCDIR/s@\$NAME@${PF}@" libinput-gestures-setup \
		|| die "sed failed for libinput-gestures-setup"
}

src_test() { :; }

src_install() {
	default

	systemd_dounit libinput-gestures.service
}

pkg_postinst() {
	xdg_icon_cache_update

	elog "You must be in the input group to read the touchpad device."

	if ! has_version x11-libs/gtk+:3 ; then
		elog "${PN}-setup script supports Gnome 3 via x11-libs/gtk+:3."
	fi
	if ! has_version kde-plasma/kde-cli-tools:5 ; then
		elog "${PN}-setup script supports Plasma 5 via kde-plasma/kde-cli-tools:5."
	fi
}
