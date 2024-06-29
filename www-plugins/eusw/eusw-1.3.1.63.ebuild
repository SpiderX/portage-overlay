# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit pax-utils udev unpacker

DESCRIPTION="IIT End User CA-1 browser extension"
HOMEPAGE="https://iit.com.ua"
SRC_URI="amd64? ( https://iit.com.ua/download/productfiles/${PN}i.64.deb -> ${P}-amd64.deb )
	x86? ( https://iit.com.ua/download/productfiles/euswi.deb -> ${P}-x86.deb )"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-accessibility/at-spi2-core:2
	sys-apps/pcsc-lite
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/pango"

QA_PREBUILT="opt/iit/eu/sw/cac.so
	opt/iit/eu/sw/cagui.so
	opt/iit/eu/sw/cspb.so
	opt/iit/eu/sw/cspe.so
	opt/iit/eu/sw/cspib.so
	opt/iit/eu/sw/ekc1ccid.so
	opt/iit/eu/sw/ekc1.so
	opt/iit/eu/sw/euscpnmh
	opt/iit/eu/sw/euscprpc.so
	opt/iit/eu/sw/euscp.so
	opt/iit/eu/sw/km.eka1c.so
	opt/iit/eu/sw/km.ekc1.so
	opt/iit/eu/sw/km.fs.so
	opt/iit/eu/sw/km.ncmg301.so
	opt/iit/eu/sw/km.pkcs11.so
	opt/iit/eu/sw/km.so
	opt/iit/eu/sw/km.tctesc.so
	opt/iit/eu/sw/ldapc.so
	opt/iit/eu/sw/libav337p11d.so
	opt/iit/eu/sw/libefitkeynxt.so
	opt/iit/eu/sw/libosi.so
	opt/iit/eu/sw/nchcp.so
	opt/iit/eu/sw/ncmg301.so
	opt/iit/eu/sw/npeuscp.so
	opt/iit/eu/sw/pdfs.so
	opt/iit/eu/sw/pkcs11.eka1c.so
	opt/iit/eu/sw/pkcs11.ekc1.so
	opt/iit/eu/sw/pkcs11.ncmg301.so
	opt/iit/eu/sw/pkif.so
	opt/iit/eu/sw/xmls.so"

src_prepare() {
	default

	cat > chrome.ua.com.iit.eusign.nmh.json <<EOF
{
	"name": "ua.com.iit.eusign.nmh",
	"description": "IIT End User CA-1. Sign (native messaging host)",
	"path": "/opt/iit/eu/sw/euscpnmh",
	"type": "stdio",
	"allowed_origins": ["chrome-extension://jffafkigfgmjafhpkoibhfefeaebmccg/"]
}
EOF
	cat > mozilla.ua.com.iit.eusign.nmh.json <<EOF
{
	"name": "ua.com.iit.eusign.nmh",
	"description": "IIT End User CA-1. Sign (native messaging host)",
	"path": "/opt/iit/eu/sw/euscpnmh",
	"type": "stdio",
	"allowed_extensions": [ "eusw@iit.com.ua" ]
}
EOF
}

src_install() {
	insinto /etc/chromium/native-messaging-hosts
	newins chrome.ua.com.iit.eusign.nmh.json ua.com.iit.eusign.nmh.json
	insinto /etc/opt/chrome/native-messaging-hosts
	newins chrome.ua.com.iit.eusign.nmh.json ua.com.iit.eusign.nmh.json
	insinto /usr/lib/mozilla/native-messaging-hosts
	newins mozilla.ua.com.iit.eusign.nmh.json ua.com.iit.eusign.nmh.json

	insinto /opt
	doins -r opt/.
	fperms +x /opt/iit/eu/sw/euscpnmh

	udev_dorules etc/udev/rules.d/60-iit-e-keys.rules

	dosym ../../../../opt/iit/eu/sw/npeuscp.so /usr/lib/mozilla/plugins/npeuscp.so

	pax-mark -m "${ED}"/opt/iit/eu/sw/euscpnmh
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
