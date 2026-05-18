# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_BRANCH="plasma6"
KFMIN=6.25.0

inherit ecm git-r3

DESCRIPTION="Plasma applet that acts as a separator between applets"
HOMEPAGE="https://github.com/doncsugar/applet-latte-separator"
EGIT_REPO_URI="https://github.com/doncsugar/${PN}.git"

LICENSE="GPL-2"
SLOT="6"

RDEPEND="kde-plasma/plasma-workspace:6"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/org.kde.latte.separator
	doins metadata.json
	doins -r contents
}
