# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit ecm git-r3 optfeature python-single-r1

DESCRIPTION="Plasmoid for a calendar and agenda with weather"
HOMEPAGE="https://github.com/ALikesToCode/plasma-applet-eventcalendar"
EGIT_REPO_URI="https://github.com/ALikesToCode/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	app-crypt/libsecret
	dev-qt/qt5compat:6
	dev-qt/qtdeclarative:6
	kde-frameworks/kcmutils:6
	kde-frameworks/kirigami:6
	kde-frameworks/kitemmodels:6
	kde-frameworks/kwallet-runtime:6
	kde-frameworks/kwindowsystem:6
	kde-plasma/plasma5support:6
	media-libs/libcanberra
	$(python_gen_cond_dep 'dev-python/pygobject:3[${PYTHON_USEDEP}]')"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/org.kde.plasma.eventcalendar
	doins package/metadata.json
	doins -r package/contents
}

pkg_postinst() {
	optfeature "support of volume control" kde-apps/kmix:6
	optfeature "support of CLI to KDE calendars" kde-apps/konsolekalendar:6
}
