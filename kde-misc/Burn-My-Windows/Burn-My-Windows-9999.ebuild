# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PLOCALES="ar az cs da de el eo es et fa fi fr he hi hu id it ja kab ko lt nb_NO nl ota pl pt_BR pt ro ru sk sv ta tr uk zh_Hans zh_Hant"
PLOCALE_BACKUP="uk"

inherit ecm edo git-r3 plocale

DESCRIPTION="Disintegrate your windows with style"
HOMEPAGE="https://github.com/Schneegans/Burn-My-Windows"
EGIT_REPO_URI="https://github.com/Schneegans/${PN}.git"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="kde-plasma/kwin:6"
BDEPEND="dev-lang/perl:0="

src_prepare() {
	default

	# do not create tarball
	sed -i '/tar/d' kwin/build.sh || die "sed failed"

	my_rm_loc() {
		rm po/"${1}".po || die "rm failed for po/${1}.po"
	}
	plocale_for_each_disabled_locale my_rm_loc
}

src_configure() { :; }

src_compile() {
	edo kwin/build.sh
}

src_install() {
	einstalldocs

	insinto /usr/share/kwin/effects
	doins -r kwin/_build/.
}
