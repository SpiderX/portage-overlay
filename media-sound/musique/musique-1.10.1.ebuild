# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg

HTTP_COMMIT="68b9cf0f16e605ad74110a2cdec9594091800c56"
IDLE_COMMIT="6aa092da64a011e445bf31cf31c0cd8dda4c64ff"
JS_COMMIT="deed5303b0b6a587c62be73a9bc198058964111c"
MEDIA_COMMIT="5443f81c52ac008a6de6593124d03ee41f772633"
SCACHE_COMMIT="eec981a4285c7b371aa9dc7f0074f03794e86a26"
UPDATER_COMMIT="1a37eedf539179a9a61304a1c9aea22fbdbf6a38"

DESCRIPTION="A finely crafted music player"
HOMEPAGE="https://github.com/flaviotordini/musique"
SRC_URI="https://github.com/flaviotordini/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://api.github.com/repos/flaviotordini/http/tarball/${HTTP_COMMIT} -> ${P}-http.tar.gz
	https://api.github.com/repos/flaviotordini/idle/tarball/${IDLE_COMMIT} -> ${P}-idle.tar.gz
	https://api.github.com/repos/flaviotordini/js/tarball/${JS_COMMIT} -> ${P}-js.tar.gz
	https://api.github.com/repos/flaviotordini/media/tarball/${MEDIA_COMMIT} -> ${P}-media.tar.gz
	https://api.github.com/repos/flaviotordini/sharedcache/tarball/${SCACHE_COMMIT} -> ${P}-sharedcache.tar.gz
	https://api.github.com/repos/flaviotordini/updater/tarball/${UPDATER_COMMIT} -> ${P}-updater.tar.gz"

LICENSE="GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsingleapplication[qt5(+),X]
	dev-qt/qtsql:5[sqlite]
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	media-libs/taglib
	media-video/mpv[libmpv]"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/linguist-tools:5"

src_prepare() {
	default

	rmdir lib/{http,idle,js,media,sharedcache,updater} \
		|| die "rmdir failed for lib"
	ln -s ../../flaviotordini-http-"${HTTP_COMMIT}" lib/http \
		|| die "ln failed for http"
	ln -s ../../flaviotordini-idle-"${IDLE_COMMIT}" lib/idle \
		|| die "ln failed for idle"
	ln -s ../../flaviotordini-js-"${JS_COMMIT}" lib/js \
		|| die "ln failed for js"
	ln -s ../../flaviotordini-media-"${MEDIA_COMMIT}" lib/media \
		|| die "ln failed for media"
	ln -s ../../flaviotordini-sharedcache-"${SCACHE_COMMIT}" lib/sharedcache \
		|| die "ln failed for sharedcache"
	ln -s ../../flaviotordini-updater-"${UPDATER_COMMIT}" lib/updater \
		|| die "ln failed for updater"

	# use system qtsingleapplication
	sed -i  -e '/CONFIG += /s/rtti_off/rtti_off qtsingleapplication/' \
		-e '/qtsingleapplication.pri/d' \
		musique.pro || die "sed failed for musique.pro"
}

src_configure() {
	eqmake5 musique.pro PREFIX="/usr"
}

src_install() {
	einstalldocs
	emake INSTALL_ROOT="${D}" install
}
