# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop xdg

MY_E="CallEdition"

DESCRIPTION="A free VoIP and video softphone based on the SIP protocol"
HOMEPAGE="https://gitlab.linphone.org/BC/public/linphone-desktop"
SRC_URI="https://gitlab.linphone.org/BC/public/${PN}/-/archive/${PV}-${MY_E}/${P}-${MY_E}.tar.bz2"
S="${WORKDIR}/${P}-${MY_E}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ldap qrcode"
RESTRICT="test" # no tests

RDEPEND="dev-libs/belcard
	dev-libs/jsoncpp:0=
	dev-libs/liblinphone
	dev-libs/qtkeychain:=
	dev-qt/qtbase:6[concurrent,dbus,widgets]
	dev-qt/qtdeclarative:6[opengl]
	dev-qt/qtmultimedia:6
	dev-qt/qtnetworkauth:6
	dev-qt/qtsvg:6
	media-libs/mediastreamer2[zrtp,jpeg]
	net-libs/bctoolbox
	net-libs/ortp
	ldap? ( net-nds/openldap:0= )
	qrcode? ( media-libs/zxing-cpp:0= )"
DEPEND="${RDEPEND}"
BDEPEND="app-admin/chrpath
	dev-qt/qttools:6[linguist]
	virtual/pkgconfig"

PATCHES=( # change path to BCToolbox, include utils
	"${FILESDIR}"/"${PN}"-6.0.0-FindBCToolbox.patch
	# fix incorrect use of get_target_property
	"${FILESDIR}"/"${PN}"-6.0.0-FindMediastreamer2.patch
	# change path to LibLinphone, include config
	"${FILESDIR}"/"${PN}"-6.0.0-FindLibLinphone.patch
	# change path to BelCard
	"${FILESDIR}"/"${PN}"-6.0.0-FindBelcard.patch
)
DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	# remove git execution, variables are defined below
	sed -i -e "/execute_process/,+5d" Linphone/CMakeLists.txt \
		|| die "sed failed for CMakeLists.txt"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DLINPHONEAPP_VERSION="${PV}"
		-DLINPHONESDK_VERSION="${PV}"
		-DLINPHONEAPP_APPLICATION_NAME="linphone"
		-DLINPHONEAPP_EXECUTABLE_NAME="linphone"
		-DGIT_BRANCH_NAME="master"
		-DENABLE_APP_LICENSE=OFF
		-DLINPHONE_OUTPUT_DIR="/usr"
		-DENABLE_APP_PACKAGING=ON
		-DLINPHONE_QT_ONLY=YES
		-DENABLE_APP_EXPORT_PLUGIN=NO
		-DENABLE_BUILD_VERBOSE=ON
		-DENABLE_CONSOLE_UI=ON
		-DENABLE_DAEMON=ON
		-DENABLE_LDAP="$(usex ldap)"
		-DENABLE_QRCODE="$(usex qrcode)"
		-DENABLE_QT_KEYCHAIN=NO
		-DENABLE_STRICT=OFF
		-DENABLE_UPDATE_CHECK=OFF
		-DENABLE_BUILD_APP_PLUGINS=OFF
		-Wno-dev
	)
	cmake_src_configure
}

src_install() {
	chrpath -d "${S}"_build/bin/linphone || die "chrpath failed for linphone"

	einstalldocs
	dobin "${S}"_build/bin/linphone
	domenu "${S}"_build/cmake/install/linux/linphone.desktop

	newicon -s scalable Linphone/data/image/logo.svg linphone.svg
	newicon -s 512 Linphone/data/icon/hicolor/512x512/apps/icon.png linphone.png
	for size in 16 22 24 32 64 128 256 512 1024 ; do
		newicon -s "${size}" Linphone/data/icon/hicolor/"${size}x${size}"/apps/icon.png linphone.png
	done

	insinto /usr/share/linphone/assistant
	doins -r Linphone/data/assistant/.
	insinto /usr/share/linphone/
	doins Linphone/data/config/linphonerc-factory
}
