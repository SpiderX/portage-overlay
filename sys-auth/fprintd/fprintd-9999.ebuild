# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://gitlab.freedesktop.org/libfprint/fprintd.git"
PLOCALES="af ar as ast az be bg bn_IN ca ca@valencia cs cy da de el en_GB eo es et eu fa fi fo fr fur ga gl gu he hi hr hu ia id it ja ka kk kn ko ky lt lv ml mr ms nb nl nn oc or pa pl pt_BR pt ro ru sk sl sq sr@latin sr sv ta te th tr uk vi wa zh_CN zh_HK zh_TW"
PLOCALE_BACKUP="en"
PYTHON_COMPAT=( python3_{11..13} )

inherit git-r3 meson pam plocale python-any-r1 systemd

DESCRIPTION="D-Bus service to access fingerprint readers"
HOMEPAGE="https://gitlab.freedesktop.org/libfprint/fprintd"

LICENSE="GPL-2+"
SLOT="0"
IUSE="doc pam selinux systemd test"
RESTRICT="!test? ( test )"

RDEPEND="dev-libs/glib:2
	|| ( sys-auth/libfprint:2 sys-auth/libfprint-tod:2 )
	sys-auth/polkit
	pam? ( sys-libs/pam
		systemd? ( sys-apps/systemd:= )
		!systemd? ( sys-auth/elogind:= ) )"
DEPEND="${RDEPEND}
	test? ( $(python_gen_any_dep '
			dev-python/python-dbusmock[${PYTHON_USEDEP}]
			dev-python/dbus-python[${PYTHON_USEDEP}]
			dev-python/pycairo[${PYTHON_USEDEP}]
			pam? ( sys-libs/pam_wrapper[${PYTHON_USEDEP}] )
		') )"
BDEPEND="dev-lang/perl
	dev-util/gdbus-codegen
	virtual/pkgconfig
	doc? ( 	dev-libs/libxml2
		dev-libs/libxslt
		dev-util/gtk-doc )"
RDEPEND+=" selinux? ( sec-policy/selinux-fprintd )"

PATCHES=( "${FILESDIR}/${PN}"-1.94.3-test-optional.patch )

python_check_deps() {
	use test && python_has_version -d "sys-libs/pam_wrapper[${PYTHON_USEDEP}]"
	python_has_version -d "dev-python/python-dbusmock[${PYTHON_USEDEP}]" &&
	python_has_version -d "dev-python/dbus-python[${PYTHON_USEDEP}]" &&
	python_has_version -d "dev-python/pycairo[${PYTHON_USEDEP}]"
}

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_prepare() {
	default

	my_rm_loc() {
		sed -i "/${1}/d" po/LINGUAS || die "sed failed for ${1}"
		rm po/"${1}".po || die "rm failed for po/${1}.po"
	}
	plocale_for_each_disabled_locale my_rm_loc
}

src_configure() {
	local emesonargs=(
		"$(meson_use test tests)"
		"$(meson_use pam)"
		-Dgtk_doc="$(usex doc true false)"
		-Dman=true
		-Dsystemd_system_unit_dir="$(systemd_get_systemunitdir)"
		-Dpam_modules_dir="$(getpam_mod_dir)"
		-Dlibsystemd="$(usex systemd libsystemd libelogind)"
	)
	meson_src_configure
}

src_install() {
	meson_src_install

	dodoc AUTHORS NEWS README TODO
	newdoc pam/README README.pam_fprintd
}

pkg_postinst() {
	elog "Please take a look at README.pam_fprintd for integration docs."
}
