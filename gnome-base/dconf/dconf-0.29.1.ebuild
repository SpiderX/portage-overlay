# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1 gnome.org gnome2-utils meson vala virtualx xdg

DESCRIPTION="Simple low-level configuration system"
HOMEPAGE="https://wiki.gnome.org/Projects/dconf"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~x86-linux"
IUSE="gtk-doc"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-libs/glib-2.44.0:2
	sys-apps/dbus"
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.2
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	dev-util/gdbus-codegen"
BDEPEND="sys-devel/gettext
	virtual/pkgconfig
	$(vala_depend)
	gtk-doc? ( dev-util/gtk-doc )"

PATCHES=( "${FILESDIR}"/0.30.1-bash-completion-dir.patch
	"${FILESDIR}"/0.32.0-meson-0.52-compat.patch )

src_prepare() {
	xdg_src_prepare
	vala_src_prepare
}

src_configure() {
	local emesonargs=(
		-Dbash_completion_dir="$(get_bashcompdir)"
		-Dman=true
		"$(meson_use gtk-doc gtk_doc)"
	)
	meson_src_configure
}

src_test() {
	virtx meson_src_test
}

src_install() {
	meson_src_install

	echo 'CONFIG_PROTECT_MASK="/etc/dconf"' >> 51dconf
	echo 'GSETTINGS_BACKEND="dconf"' >> 51dconf
	doenvd 51dconf
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_giomodule_cache_update

	# Kill existing dconf-service processes as recommended by upstream due to
	# possible changes in the dconf private dbus API.
	# dconf-service will be dbus-activated on next use.
	local pids
	pids="$(pgrep -x dconf-service)"
	if [ "${pids}" ] ; then
		ebegin "Stopping dconf-service; it will automatically restart on demand"
		kill "${pids}" || die "kill failed"
		eend $?
	fi
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_giomodule_cache_update
}
