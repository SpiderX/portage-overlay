# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg

COMMIT="a45ad15680dd44a1dfd2ebae336d6f085d5f2651"

DESCRIPTION="Radio tray for linux on QT"
HOMEPAGE="https://github.com/alexyalinc/krudio"
SRC_URI="https://github.com/alexyalinc/${PN}/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtmultimedia:5[gstreamer]
	dev-qt/qtsql:5
	dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}
	media-plugins/gst-plugins-meta:1.0[aac,http,mp3,mpeg,ogg,vorbis]"

S="${WORKDIR}/${PN}-${COMMIT}"

DOCS=( README.md )

src_prepare() {
	default

	# Remove qmake and create paths for symlinks
	sed -i \
		-e '/qmake/d' \
		-e '/mkdir/a\\tmkdir -p $(datadir)/icons/hicolor/16x16/status' \
		-e '/mkdir/a\\tmkdir -p $(datadir)/icons/hicolor/22x22/status' \
		-e '/mkdir/a\\tmkdir -p $(datadir)/icons/hicolor/24x24/status' \
		-e '/mkdir/a\\tmkdir -p $(datadir)/icons/hicolor/48x48/apps/'  \
		Makefile || die "sed for Makefile"

	# Fix desktop file
	sed -i \
		-e '/Terminal/s/.$//' \
		-e '/Name/s/.$//' \
		src/data/"${PN}".desktop || die "sed for krudio.desktop"
}

src_configure() {
	cd src || die "cd to src failed"
	eqmake5 PREFIX=/usr
}

src_install() {
	einstalldocs
	emake prefix="${D}"/usr DESTDIR="${D}" install
}
