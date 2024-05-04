# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils optfeature xdg

HTTP_COMMIT="e7689c1"
IDLE_COMMIT="8a8bbb7"
JS_COMMIT="0d7ea97"
MEDIA_COMMIT="b0310b8"
QWIDGET_COMMIT="197e874"
SCACHE_COMMIT="eec981a"
SINGLE_COMMIT="494772e"
UPDATER_COMMIT="081df10"

DESCRIPTION="A finely crafted music player"
HOMEPAGE="https://github.com/flaviotordini/musique"
SRC_URI="https://github.com/flaviotordini/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://api.github.com/repos/flaviotordini/http/tarball/${HTTP_COMMIT} -> ${P}-http.tar.gz
	https://api.github.com/repos/flaviotordini/idle/tarball/${IDLE_COMMIT} -> ${P}-idle.tar.gz
	https://api.github.com/repos/flaviotordini/js/tarball/${JS_COMMIT} -> ${P}-js.tar.gz
	https://api.github.com/repos/flaviotordini/media/tarball/${MEDIA_COMMIT} -> ${P}-media.tar.gz
	https://api.github.com/repos/flaviotordini/qt-reusable-widgets/tarball/${QWIDGET_COMMIT} -> ${P}-qwidget.tar.gz
	https://api.github.com/repos/flaviotordini/sharedcache/tarball/${SCACHE_COMMIT} -> ${P}-sharedcache.tar.gz
	https://api.github.com/repos/itay-grudev/SingleApplication/tarball/${SINGLE_COMMIT} -> ${P}-single.tar.gz
	https://api.github.com/repos/flaviotordini/updater/tarball/${UPDATER_COMMIT} -> ${P}-updater.tar.gz"

LICENSE="GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsql:5[sqlite]
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	media-libs/taglib
	media-video/mpv[libmpv]"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/linguist-tools:5"

src_prepare() {
	default

	rmdir lib/{http,idle,js,media,qt-reusable-widgets,singleapplication,sharedcache,updater} \
		|| die "rmdir failed for lib"
	ln -s ../../flaviotordini-http-"${HTTP_COMMIT}" lib/http \
		|| die "ln failed for http"
	ln -s ../../flaviotordini-idle-"${IDLE_COMMIT}" lib/idle \
		|| die "ln failed for idle"
	ln -s ../../flaviotordini-js-"${JS_COMMIT}" lib/js \
		|| die "ln failed for js"
	ln -s ../../flaviotordini-media-"${MEDIA_COMMIT}" lib/media \
		|| die "ln failed for media"
	ln -s ../../flaviotordini-qt-reusable-widgets-"${QWIDGET_COMMIT}" lib/qt-reusable-widgets \
		|| die "ln failed for qwidgets"
	ln -s ../../flaviotordini-sharedcache-"${SCACHE_COMMIT}" lib/sharedcache \
		|| die "ln failed for sharedcache"
	ln -s ../../itay-grudev-SingleApplication-"${SINGLE_COMMIT}" lib/singleapplication \
		|| die "ln failed for single"
	ln -s ../../flaviotordini-updater-"${UPDATER_COMMIT}" lib/updater \
		|| die "ln failed for updater"

	# don't use lrelease from path
	# https://github.com/flaviotordini/musique/commit/05bf89e143728a0e1c1be496d761d80d4a8469f8
	sed -i '/else:QMAKE_LRELEASE/s|= |= $$[QT_INSTALL_BINS]/|' locale/locale.pri \
		|| die "sed failed for locale.pri"
}

src_configure() {
	eqmake6 musique.pro PREFIX="/usr"
}

src_install() {
	einstalldocs
	emake INSTALL_ROOT="${D}" install
}

pkg_postinst() {
	optfeature "automatic music tagging via finetune" media-sound/finetune
	xdg_pkg_postinst
}
