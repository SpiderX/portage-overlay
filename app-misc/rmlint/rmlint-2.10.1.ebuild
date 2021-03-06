# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PLOCALES="de es fr"
PYTHON_COMPAT=( python3_{7..9} )

inherit eutils gnome2-utils l10n python-single-r1 scons-utils

DESCRIPTION="Removes duplicates and other lint from your filesystem"
HOMEPAGE="https://rmlint.rtfd.org https://github.com/sahib/rmlint"
SRC_URI="https://github.com/sahib/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+blkid cpu_flags_x86_sse4_2 debug doc +elf gui +json kernel_linux nls test"
RESTRICT="!test? ( test ) json? ( test )"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/sphinx[${PYTHON_USEDEP}]
		doc? ( dev-python/sphinx-bootstrap-theme[${PYTHON_USEDEP}] )
		test? (
			dev-python/nose[${PYTHON_USEDEP}]
			dev-python/parameterized[${PYTHON_USEDEP}]
			dev-python/psutil[${PYTHON_USEDEP}]
			dev-python/xattr[${PYTHON_USEDEP}]
		)
	')
"
COMMON_DEPEND="
	dev-libs/glib:2
	blkid? ( sys-apps/util-linux )
	json? ( dev-libs/json-glib )
	elf? ( virtual/libelf )
"
RDEPEND="${COMMON_DEPEND}
	gui? (
		${PYTHON_DEPS}
		x11-libs/gtksourceview:3.0
		$(python_gen_cond_dep '
			dev-python/colorlog[${PYTHON_USEDEP}]
			dev-python/pygobject:3[${PYTHON_USEDEP}]
		')
	)
"
DEPEND="${COMMON_DEPEND}
	kernel_linux? ( sys-kernel/linux-headers )
	nls? ( sys-devel/gettext )
"

PATCHES=(
	"${FILESDIR}/${PN}-2.8.0-avoid-stripping.patch"
	"${FILESDIR}/${P}-prevent-python2-testing.patch"
)
DOCS=( CHANGELOG.md README.rst gui/TODO )
#TODO: install shredder, calling directly distutils?

pkg_setup() {
	python_setup
}

src_prepare() {
	default

	scons_opts=(
		VERBOSE=1
		DEBUG=$(usex debug 1 0)
		SYMBOLS=$(usex debug 1 0)
		"--libdir=/usr/$(get_libdir)"
		"--prefix=${ED%/}/usr"
		--actual-prefix=/usr
		HAVE_MM_CRC32_U64=$(usex cpu_flags_x86_sse4_2 1 0)
		$(usex kernel_linux --with-fiemap --without-fiemap)
		$(usex elf --with-libelf --without-libelf)
		$(usex json --with-json-glib --without-json-glib)
		$(usex nls --with-gettext --without-gettext)
		$(usex gui --with-gui --without-gui)
	)

	l10n_prepare() {
		rm po/"${1}".po || die "removing of ${1}.po failed"
	}
	l10n_find_plocales_changes po "" .po
	l10n_for_each_disabled_locale_do l10n_prepare
}

src_configure() {
	escons config "${scons_opts[@]}"
}

src_compile(){
	escons CC="$(tc-getCC)" "${scons_opts[@]}"
	use doc && escons "${scons_opts[@]}" "$(usex doc docs)"
}

src_test() {
	escons "${scons_opts[@]}" test
}

src_install(){
	default

	escons "${scons_opts[@]}" install

	rm -f "${ED%/}"/usr/share/glib-2.0/schemas/gschemas.compiled
	gunzip "${ED%/}"/usr/share/man/man1/*.gz || die
	if use gui; then
		python_optimize
	else
		rm -rf "${ED%/}"/usr/share/{glib-2.0,icons,applications}
		rm -rf "${ED%/}"/usr/lib
	fi

	use doc && dodoc -r "$S/docs/_build/html"
}

pkg_preinst() {
	use gui && gnome2_schemas_savelist
}

pkg_postinst() {
	if use gui ; then
		gnome2_schemas_update
		gnome2_icon_cache_update
	fi
}

pkg_postrm() {
	if use gui ; then
		gnome2_schemas_update
		gnome2_icon_cache_update
	fi
}
