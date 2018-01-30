# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

DESCRIPTION="Native client and extension for signing with your eID on the web"
HOMEPAGE="https://github.com/open-eid/chrome-token-signing http://id.ee/"
SRC_URI="https://github.com/open-eid/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="libressl mozilla"

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	sys-apps/pcsc-lite
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )
	mozilla? ( || (
			www-client/firefox
			www-client/firefox-bin )
	)"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS {README,RELEASE-NOTES}.md )

src_prepare() {
	default

	# Don't run qmake from makefile
	sed -i '/qmake VERSION=$(VERSIONEX)/d' host-linux/GNUmakefile \
		|| die "sed failed for GNUmakefile"
	# Don't install all
	sed -i '/INSTALLS += /s|target hostconf ffconf extension ffextension|target hostconf extension|' \
		host-linux/chrome-token-signing.pro \
		|| die "sed failed for chrome-token-signing.pro"
}

src_configure() {
	cd host-linux || die "sed failed for cd"
	if use mozilla ; then
		echo "INSTALLS += ffconf ffextension" >> \
			host-linux/chrome-token-signing.pro || die "echo failed"
	fi

	eqmake5
}

src_install() {
	einstalldocs

	emake INSTALL_ROOT="${ED}" -C host-linux install

	dosym ../../opt/chrome/native-messaging-hosts/ee.ria.esteid.json \
		/etc/chromium/native-messaging-hosts/ee.ria.esteid.json
	dosym ../../../../opt/google/chrome/extensions/ckjefchnfjhjfedoccjbhjpbncimppeg.json \
		/usr/share/chromium/extensions/ckjefchnfjhjfedoccjbhjpbncimppeg.json
}
