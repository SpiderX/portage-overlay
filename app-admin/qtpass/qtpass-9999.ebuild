# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ar_MA
PLOCALES="de_DE es_ES gl_ES he_IL hu_HU nl_NL pl_PL ru_RU sv_SE zh_CN"

inherit qmake-utils l10n git-r3
DESCRIPTION="multi-platform GUI for pass, the standard unix password manager."
HOMEPAGE="https://qtpass.org/"
EGIT_REPO_URI="https://github.com/IJHack/${PN}.git"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="+qt5"
DOCS=( FAQ.md README.md CONTRIBUTING.md )

RDEPEND="qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5[xcb]
		dev-qt/qtwidgets:5
		dev-qt/qtnetwork:5
	)
	!qt5? (
		dev-qt/qtcore:4
		dev-qt/qtgui:4
	)
	app-admin/pass"

DEPEND="${RDEPEND}
	qt5? ( dev-qt/linguist-tools:5 )"

src_prepare() {
	# Modify install path
	sed -i "s/target.path = \$\$PREFIX/target.path = \$\$PREFIX\/bin/" \
		${PN}.pro \
		|| die "sed failed to modify install path for ${PN}.pro"

	locale() {
		sed -i \
			-e "/CODECFORSRC     = UTF-8/i TRANSLATIONS += localization\/localization_${1}.ts" \
			-e "/target.path = \$\$PREFIX\/bin/a translations.files += localization/localization_${1}.qm" \
		${PN}.pro || die "sed in locale() for ${PN}.pro failed"
		sed -i "/qresource>/i \\\t<file>localization\/localization_${1}.qm</file>" resources.qrc || die "sed in locale() for resources.qrc failed"
	}

	# Disabled due lack of support ar_MA locale in portage
	#l10n_find_plocales_changes "localization" "localization_" ".ts"
	# Remove all localizations by default
	sed -i "/localization\/localization_[a-z]\{2\}_[A-Z]\{2\}.ts/d" \
		${PN}.pro \
		|| die "sed failed to remove localization for ${PN}.pro"
	sed -i "/<file>localization\/localization_[a-z]\{2\}_[A-Z]\{2\}.qm<\/file>/d" \
		resources.qrc \
		|| die "sed failed to remove localization for resources.qrc"

	# For enabled locales add translations install target and path
	if [[ -n "$(l10n_get_locales)" ]]; then
		sed -i \
		-e "/INSTALLS += target/a INSTALLS += translations" ${PN}.pro \
		-e "/target.path = \$\$PREFIX\/bin/a translations.path = \$\$PREFIX/share/\$\${TARGET}/translations" \
		${PN}.pro \
		|| die "sed failed to append translation target and path for ${PN}.pro"
		l10n_for_each_locale_do locale
	fi

	epatch_user
}

src_configure() {
	if use qt5 ; then
		eqmake5 PREFIX="${D}"/usr
	else
		eqmake4 PREFIX="${D}"/usr
	fi
}

src_install() {
	default

	insinto /usr/share/applications
	doins "${PN}.desktop"

	newicon artwork/icon.svg "${PN}-icon.svg"
}
