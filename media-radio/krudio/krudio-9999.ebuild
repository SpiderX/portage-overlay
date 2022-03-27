# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/loast/${PN}.git"

inherit git-r3

DESCRIPTION="Radio tray for linux on QT"
HOMEPAGE="https://github.com/loast/krudio"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

DEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtmultimedia:5[gstreamer]
	dev-qt/qtsql:5
	dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}
	media-plugins/gst-plugins-meta:1.0[aac,http,mp3,mpeg,ogg,vorbis]"

DOCS=( README.md )

src_prepare() {
	default

	# Specify qmake version by using full path and create paths for symlinks
	sed -i \
		-e 's:qmake:/usr/lib/qt5/bin/qmake:' \
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

src_install() {
	einstalldocs
	emake prefix="${D}"/usr DESTDIR="${D}" install
}
