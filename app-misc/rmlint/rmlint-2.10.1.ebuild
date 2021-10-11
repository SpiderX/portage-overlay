# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )

inherit gnome2-utils python-single-r1 scons-utils

DESCRIPTION="Removes duplicates and other lint from your filesystem"
HOMEPAGE="https://rmlint.rtfd.org https://github.com/sahib/rmlint"
SRC_URI="https://github.com/sahib/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc nls test X"
RESTRICT="!test? ( test )"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="dev-libs/glib:2
	dev-libs/json-glib
	sys-apps/util-linux
	virtual/libelf:0=
	X? ( ${PYTHON_DEPS}
		x11-libs/gtksourceview:3.0
		$(python_gen_cond_dep '
			dev-python/colorlog[${PYTHON_MULTI_USEDEP}]
			dev-python/pygobject:3[${PYTHON_MULTI_USEDEP}]
		') )"
DEPEND="${RDEPEND}
	doc? ( $(python_gen_cond_dep '
			dev-python/sphinx[${PYTHON_MULTI_USEDEP}]
			dev-python/sphinx-bootstrap-theme[${PYTHON_MULTI_USEDEP}]
		') )"
BDEPEND="sys-kernel/linux-headers
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
	test? (
		$(python_gen_cond_dep '
			dev-python/nose[${PYTHON_MULTI_USEDEP}]
			dev-python/parameterized[${PYTHON_MULTI_USEDEP}]
		') )"

DOCS=( CHANGELOG.md README.rst )

src_configure() {
	scons_opts="DEBUG=0 --libdir=/usr/$(get_libdir) \
		$(usex nls --with-gettext --without-gettext) \
		$(usex X --with-gui --without-gui)"
	escons config "${scons_opts}"
}

src_compile(){
	escons CC="$(tc-getCC)" "${scons_opts}"
}

src_install(){
	einstalldocs
	escons "${scons_opts}" --prefix="${ED}"/usr --actual-prefix=/usr install

	rm -f "${ED}"/usr/share/glib-2.0/schemas/gschemas.compiled
	if ! use X; then
		rm -rf "${ED}"/usr/share/{glib-2.0,icons,applications}
		rm -rf "${ED}"/usr/lib
	fi
}

pkg_postinst() {
	use X && gnome2_schemas_update
	xdg_icon_cache_update
}

pkg_postrm() {
	use X && gnome2_schemas_update
	xdg_icon_cache_update
}
