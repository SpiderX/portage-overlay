# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PLOCALES="bg cs da de el en es et fi fr he hr hu is it ja ko nl no pl pt ro ru sk sv tr uk zh"
PLOCALE_BACKUP="en"

inherit ecm git-r3 plocale

DESCRIPTION="Chatbots as Plasmoid for KDE Plasma"
HOMEPAGE="https://github.com/DenysMb/ChatAI-Plasmoid"
EGIT_REPO_URI="https://github.com/DenysMb/ChatAI-Plasmoid.git"

LICENSE="BSD"
SLOT="6"

RDEPEND="dev-qt/qtwebengine:6
	kde-frameworks/kcmutils:6
	kde-frameworks/kdeclarative:6
	kde-frameworks/ki18n:6
	kde-frameworks/kirigami:6
	kde-plasma/plasma-workspace:6"

src_prepare() {
	default

	my_rm_loc() {
		rm -r contents/locale/"${1}" || die "rm failed for ${1}"
	}
	plocale_for_each_disabled_locale my_rm_loc
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/com.github.denysmb.chatai
	doins -r content/.
}
