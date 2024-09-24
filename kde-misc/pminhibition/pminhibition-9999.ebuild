# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PLOCALES="nl uk"
PLOCALE_BACKUP="en"
EGIT_REPO_URI="https://github.com/popov895/${PN}.git"

inherit ecm git-r3 plocale

DESCRIPTION="Plasma applet shows information about power management inhibition"
HOMEPAGE="https://github.com/popov895/pminhibition"

LICENSE="GPL-2+"
SLOT="0"

RDEPEND="kde-plasma/plasma-workspace:6"

src_prepare() {
	default

	my_rm_loc() {
		rm -rf po/"${1}".po || die "rm failed for po/${1}"
	}
	plocale_for_each_disabled_locale my_rm_loc
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/org.kde.plasma.pminhibition

	doins metadata.desktop
	doins -r contents po
}
