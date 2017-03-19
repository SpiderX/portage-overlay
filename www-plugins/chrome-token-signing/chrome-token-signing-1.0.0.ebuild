# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit qmake-utils user eutils

SRC_URI="https://github.com/open-eid/${PN}/releases/download/v${PV}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="Estonian ID Card signing for Chrome"
HOMEPAGE="http://id.ee/"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="+chromium chrome debug extension"
REQUIRED_USE="|| ( chromium chrome )"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets
	dev-qt/qtnetwork
	dev-libs/openssl:0
	sys-apps/lsb-release
"
RDEPEND="
	${DEPEND}
	app-arch/bzip2
	sys-libs/zlib
	dev-libs/expat
	dev-libs/opensc
	app-misc/sk-certificates
"

S="${WORKDIR}/${PN}/host-linux"

src_prepare() {
	# Do not generate install for extension
	sed -i '$ d;/g.json/aINSTALLS += target hostconf' chrome-token-signing.pro

	if use chromium && use chrome ; then
		# Generate install section for chromium
		epatch "${FILESDIR}/${P}-add-chromium-support.patch"
	else
		if use chromium && use !chrome ; then
			# Replace chrome paths in install section by chromium paths
			sed -i 's/\/etc\/opt\/chrome\/native-messaging-hosts/\/etc\/chromium\/native-messaging-hosts/' \
				chrome-token-signing.pro
		fi
	fi

	# Insert public key into manifest (https://github.com/open-eid/chrome-token-signing/wiki/DeveloperTips)
	use extension && sed -i '/"manifest_version"/i "key": "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyt8re1RtbobElTNUxQIO9RnOV2JTtzCSMNSfTPAIOONRcOi9WET9NcwoVtplQYjbFiBXHMtI/A0agm/GHY70o4d8HxCSJOm1zuPc+PQ2hS9oxzuPfAUqXGpZQLdm1Lub7NGlFALyfaUzqg193TojMGF7cBPWoMAj7mnDq5LiHEI3vanAQQ3gG8CHO1oXMlpJCj8CpxLozYOA+iFw+B1qRSiBLGPaPwyF27DGVkgH+Ue30faRgO2EstePFC6crSzGALFRmftNUR1N+6imtMJzx7EbTsMbiqd7hCN+EzRVkvE3hHGaSvcC0tRe3jOgbqQEp4bCpxIHg1QsGmtWDyKWaQIDAQAB",' \
				"${WORKDIR}/${PN}"/extension/manifest.json

	epatch_user
}

src_install() {
	emake INSTALL_ROOT="${D}" install

	if use extension ; then
		if use chromium ; then
			dodir /usr/share/chromium-browser/extensions/ckjefchnfjhjfedoccjbhjpbncimppeg
			insinto /usr/share/chromium-browser/extensions/ckjefchnfjhjfedoccjbhjpbncimppeg
			doins -r "${WORKDIR}/${PN}"/extension/*
		fi
		if use chrome ; then
			dodir /opt/google/chrome/extensions/ckjefchnfjhjfedoccjbhjpbncimppeg
			insinto /opt/google/chrome/extensions/ckjefchnfjhjfedoccjbhjpbncimppeg
			doins -r "${WORKDIR}/${PN}"/extension/*
		fi
	fi
}

pkg_postinst() {
	if use extension ; then
		elog "To load the extension, open chrome://extensions,"
		elog "enable developer mode, press 'Load unpacked extension'"
		elog "and navigate to /usr/share/${PN}/extension"
	fi
	elog "You can look for 'Token signing' extension in Chrome Web Store"
}
