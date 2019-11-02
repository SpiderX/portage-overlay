# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PLOCALES="ar_MA ca cs_CZ de_DE de_LU el_GR en_GB en_US es_ES fr_BE fr_FR fr_LU
gl_ES he_IL hu_HU it_IT lb_LU nl_BE nl_NL pl_PL pt_PT ru_RU sv_SE zh_CN"

inherit desktop l10n qmake-utils virtualx

DESCRIPTION="multi-platform GUI for pass, the standard unix password manager"
HOMEPAGE="https://qtpass.org"
SRC_URI="https://github.com/IJHack/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="app-admin/pass
	dev-qt/qtcore:5
	dev-qt/qtgui:5[xcb]
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	net-misc/x11-ssh-askpass"
DEPEND="${RDEPEND}
	dev-qt/qtsvg:5
	test? ( dev-qt/qttest:5 )"
BDEPEND="dev-qt/linguist-tools:5"

S="${WORKDIR}/QtPass-${PV}"

DOCS=( {CHANGELOG,CONTRIBUTING,FAQ,README}.md )

src_prepare() {
	default

	if ! use test ; then
		sed -i '/SUBDIRS += src /s/tests //' \
			qtpass.pro || die "sed for qtpass.pro failed"
	fi

	l10n_find_plocales_changes localization localization_ .ts
}

src_configure() {
	eqmake5 PREFIX="${D}"/usr
}

src_test() {
	virtx default
}

src_install() {
	default

	l10n_install() {
		doins localization/localization_"${1}".qm
	}

	insinto /usr/share/qtpass/translations
	l10n_for_each_locale_do l10n_install

	doman qtpass.1
	domenu qtpass.desktop
	newicon artwork/icon.png qtpass-icon.png
	insinto /usr/share/appdata
	doins qtpass.appdata.xml
}
