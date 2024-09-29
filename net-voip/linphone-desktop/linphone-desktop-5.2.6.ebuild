# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="A free VoIP and video softphone based on the SIP protocol"
HOMEPAGE="https://gitlab.linphone.org/BC/public/linphone-desktop"
SRC_URI="https://gitlab.linphone.org/BC/public/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ldap qrcode"
RESTRICT="test" # needs sdk

RDEPEND="dev-libs/belcard
	dev-libs/jsoncpp:0=
	dev-libs/liblinphone
	dev-libs/qtkeychain:=
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtquickcontrols:5
	dev-qt/qtquickcontrols2:5[widgets]
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	media-libs/mediastreamer2[zrtp,jpeg]
	net-libs/bctoolbox
	net-libs/ortp
	ldap? ( net-nds/openldap:0= )
	qrcode? ( media-libs/zxing-cpp:0= )"
DEPEND="${RDEPEND}"
BDEPEND="dev-vcs/git
	dev-qt/linguist-tools:5
	virtual/pkgconfig"

PATCHES=( # change path to BCToolbox, include utils
	"${FILESDIR}"/"${PN}"-5.2.4-FindBCToolbox.patch
	# fix incorrect use of get_target_property
	"${FILESDIR}"/"${PN}"-5.2.4-FindMediastreamer2.patch
	# change path to BCToolbox, include config
	"${FILESDIR}"/"${PN}"-5.2.4-FindLibLinphone.patch
	# change path to BelCard
	"${FILESDIR}"/"${PN}"-5.2.4-FindBelcard.patch
	# remove spellchecker from UI
	"${FILESDIR}"/"${PN}"-5.2.4-spellchecker.patch )

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	# don't build ispell, don't build rpm, don't install qt.conf,
	# respect DESTDIR, correct include path, commend out spellchecker sources
	sed -i  -e '/if(NOT APPLE AND NOT WIN32)/s|APPLE|UNIX|' \
		-e '/add_subdirectory(build)/d' \
		-e '/deployqt_hack/d' \
		-e 's|${CMAKE_INSTALL_PREFIX}|\\$ENV{DESTDIR}\/${CMAKE_INSTALL_PREFIX}|g' \
		-e '/install(DIRECTORY/s|include"|include/"|' \
		-e '/spell-checker/s|^|#|' \
		linphone-app/CMakeLists.txt \
		|| die "sed for CMakeLists.txt failed"

	# don't install ispell dictionaries, don't build AppImage, don't install qt.conf
	sed -i -e '/ISpell_SOURCE_DIR/d' \
		-e '/{ENABLE_APP_PACKAGING}/s|}|_}|' \
		-e "/install(FILES.*qt.conf/d" \
		linphone-app/cmake_builder/linphone_package/CMakeLists.txt \
		|| die "sed failed for linphone_package/CMakeLists.txt"

	# remove SpellChecker component
	sed -i '/SpellChecker/d' linphone-app/src/app/App.cpp \
		|| die "sed failed for App.cpp"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DLINPHONEAPP_VERSION="${PV}"
		-DLINPHONE_OUTPUT_DIR="/usr"
		-DENABLE_APP_PACKAGING=YES
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
