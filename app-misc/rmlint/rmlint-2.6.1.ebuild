# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PLOCALES="de es fr"
PYTHON_COMPAT=( python2_7 )

inherit eutils distutils-r1 gnome2-utils l10n python-r1 scons-utils

DESCRIPTION="Removes duplicates and other lint from your filesystem"
HOMEPAGE="https://rmlint.rtfd.org https://github.com/sahib/rmlint"
SRC_URI="https://github.com/sahib/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cpu_flags_x86_sse doc nls test X"
RESTRICT="!test? ( test )"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="dev-libs/glib:2
	dev-libs/json-glib
	sys-apps/util-linux
	virtual/libelf
	X? (
		x11-libs/gtksourceview:3.0
		dev-python/colorlog[${PYTHON_USEDEP}]
		dev-python/pygobject:3[${PYTHON_USEDEP}]
	)"
DEPEND="${RDEPEND}
	dev-python/sphinx[${PYTHON_USEDEP}]
	sys-kernel/linux-headers
	virtual/pkgconfig
	doc? ( dev-python/sphinx-bootstrap-theme[${PYTHON_USEDEP}] )
	nls? ( sys-devel/gettext )
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/nose-parameterized[${PYTHON_USEDEP}]
	)"

DOCS=( CHANGELOG.md README.rst gui/TODO )
#TODO: install shredder, calling directly distutils?

src_prepare() {
	default

	# DEBUG=1 - don't strip binary
	scons_opts="DEBUG=1 --libdir=/usr/$(get_libdir) --prefix=${ED%/}/usr --actual-prefix=/usr \
		$(usex cpu_flags_x86_sse --with-sse --without-sse) \
		$(usex nls --with-gettext --without-gettext) \
		$(usex X --with-gui --without-gui)"

	l10n_prepare() {
		rm po/"${1}".po || die "removing of ${1}.po failed"
	}
	l10n_find_plocales_changes po "" .po
	l10n_for_each_disabled_locale_do l10n_prepare
}

src_configure() {
	escons config "${scons_opts}"
}

src_compile(){
	escons CC="$(tc-getCC)" "${scons_opts}"
}

src_install(){
	default

	escons "${scons_opts}" install

	rm -f "${ED%/}"/usr/share/glib-2.0/schemas/gschemas.compiled
	if ! use X; then
		rm -rf "${ED%/}"/usr/share/{glib-2.0,icons,applications}
		rm -rf "${ED%/}"/usr/lib
	fi
}

pkg_preinst() {
	use X && gnome2_schemas_savelist
}

pkg_postinst() {
	if use X ; then
		gnome2_schemas_update
		gnome2_icon_cache_update
	fi
}

pkg_postrm() {
	if use X ; then
		gnome2_schemas_update
		gnome2_icon_cache_update
	fi
}
