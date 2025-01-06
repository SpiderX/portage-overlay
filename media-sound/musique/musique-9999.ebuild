# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PLOCALES="ast be bg br ca_ES ca cs_CZ da de el en_GB en es_ES es_MX es fa_IR fi_FI fr gl hu_HU ia it ko ky lt_LT ms_MY nb nl pl pt_BR pt ro ru sk sr tr uk vi zh_CN zh_TW"
PLOCALE_BACKUP="en"
EGIT_REPO_URI="https://gitlab.com/flaviotordini/${PN}.git"

inherit git-r3 qmake-utils optfeature plocale xdg

DESCRIPTION="A finely crafted music player"
HOMEPAGE="https://github.com/flaviotordini/musique"

LICENSE="GPL-3 MIT"
SLOT="0"

RDEPEND="dev-qt/qtbase:6[dbus,gui,network,sqlite,widgets]
	dev-qt/qtdeclarative:6
	media-libs/taglib
	media-video/mpv:=[libmpv]"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/qttools:6[linguist]"

src_prepare() {
	default

	# don't use lrelease from path
	# https://github.com/flaviotordini/musique/commit/05bf89e143728a0e1c1be496d761d80d4a8469f8
	sed -i '/else:QMAKE_LRELEASE/s|= |= $$[QT_INSTALL_BINS]/|' locale/locale.pri \
		|| die "sed failed for locale.pri"

	# don't use default credentials
	sed -i '/LASTFM/s|".*"|""|' src/constants.cpp \
		|| die "sed failed for constants.cpp"

	my_rm_loc() {
		rm locale/"${1}".ts || die "rm failed for locale/${1}.ts"
		sed -i "s/ ${1}.ts//" locale/locale.pri || die "sed failed for locale/locale.pri"
	}
	plocale_for_each_disabled_locale my_rm_loc
}

src_configure() {
	eqmake6 musique.pro PREFIX="/usr"
}

src_install() {
	einstalldocs
	emake INSTALL_ROOT="${D}" install
}

pkg_postinst() {
	optfeature "automatic music tagging via finetune" media-sound/finetune
	xdg_pkg_postinst
}
