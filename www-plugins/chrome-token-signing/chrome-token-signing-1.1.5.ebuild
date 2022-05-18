# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils

DESCRIPTION="Native client and extension for signing with your eID on the web"
HOMEPAGE="https://github.com/open-eid/chrome-token-signing http://id.ee/"
SRC_URI="https://github.com/open-eid/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64"
SLOT="0"
IUSE="chromium firefox vivaldi"

BDEPEND="virtual/pkgconfig"
DEPEND="dev-libs/openssl:0=
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	sys-apps/pcsc-lite"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/host-linux"

src_prepare() {
	default

	# Don't install everything without need
	sed -i '/INSTALLS += /s|target hostconf ffconf extension ffextension|target hostconf extension|' \
		chrome-token-signing.pro \
		|| die "sed failed for chrome-token-signing.pro"
}

src_configure() {
	usex firefox "INSTALLS += ffconf ffextension" "" \
		>> chrome-token-signing.pro

	# remove upstream's GNUmakefile
	eqmake5 VERSION="${PV}" -o GNUmakefile chrome-token-signing.pro
}

src_install() {
	emake INSTALL_ROOT="${ED}" install

	if use chromium ; then
		dosym ../../opt/chrome/native-messaging-hosts/ee.ria.esteid.json \
			/etc/chromium/native-messaging-hosts/ee.ria.esteid.json
		dosym ../../../../opt/google/chrome/extensions/ckjefchnfjhjfedoccjbhjpbncimppeg.json \
			/usr/share/chromium/extensions/ckjefchnfjhjfedoccjbhjpbncimppeg.json
	fi
	if use vivaldi ; then
		dosym ../../opt/chrome/native-messaging-hosts/ee.ria.esteid.json \
			/etc/vivaldi/native-messaging-hosts/ee.ria.esteid.json
		dosym ../../../../opt/google/chrome/extensions/ckjefchnfjhjfedoccjbhjpbncimppeg.json \
			/usr/share/vivaldi/extensions/ckjefchnfjhjfedoccjbhjpbncimppeg.json
	fi
}
