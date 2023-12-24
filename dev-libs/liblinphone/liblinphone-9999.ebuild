# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..12} )
EGIT_REPO_URI="https://gitlab.linphone.org/BC/public/${PN}.git"

inherit cmake git-r3 python-r1

DESCRIPTION="SIP library supporting voice/video calls and text messaging"
HOMEPAGE="https://gitlab.linphone.org/BC/public/liblinphone"

LICENSE="GPL-3"
SLOT="0"
IUSE="debug doc ldap libnotify qrcode static-libs test tools"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-cpp/belr
	dev-cpp/xsd
	dev-db/sqlite:3
	dev-db/soci
	dev-libs/belcard
	dev-libs/belle-sip
	dev-libs/jsoncpp:0=
	dev-libs/libxml2:2
	dev-libs/lime
	dev-libs/xerces-c
	net-libs/bctoolbox[test?]
	net-libs/ortp
	media-libs/mediastreamer2[zrtp,srtp,jpeg]
	sys-libs/zlib:0
	virtual/libiconv
	virtual/libintl
	virtual/libudev
	qrcode? ( media-libs/zxing-cpp:0= )
	tools? ( ${PYTHON_DEPS}
		dev-python/pystache[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}"
BDEPEND="${PYTHON_DEPS}
	app-doc/doxygen[dot]
	dev-python/pystache[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-vcs/git
	virtual/pkgconfig
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}"/"${PN}"-5.1.3-jsoncpp-cmake.patch )

src_prepare() {
	sed -i 's/Werror=return-type/Wno-error=return-type/' CMakeLists.txt \
		|| die "sed failed for CMakeLists.txt"

	# fix incapability to detect jsoncpp
	sed -i '/json\/json.h/s|<|<jsoncpp/|' src/FlexiAPIClient.cc \
		include/linphone/FlexiAPIClient.hh \
		tester/{account_creator_flexiapi_tester,flexiapiclient-tester,remote-provisioning-tester}.cpp \
		|| die "sed failed for FlexiAPIClient"
	sed -i '/target_link_libraries/s/jsoncpp_lib/jsoncpp/' src/CMakeLists.txt \
		|| die "sed failed for src/CMakeLists.txt"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_ASSISTANT=YES
		-DENABLE_DEBUG_LOGS="$(usex debug)"
		-DENABLE_DOC="$(usex doc)"
		-DENABLE_FLEXIAPI=YES
		-DENABLE_LDAP="$(usex ldap)"
		-DENABLE_LIME=NO
		-DENABLE_NOTIFY="$(usex libnotify)"
		-DENABLE_QRCODE="$(usex qrcode)"
		-DENABLE_STATIC="$(usex static-libs)"
		-DENABLE_STRICT=NO
		-DENABLE_TOOLS="$(usex tools)"
		-DENABLE_UNIT_TESTS="$(usex test)"
		-Wno-dev
	)

	cmake_src_configure
}

src_test() {
	"${S}"_build/tester/liblinphone_tester \
		--resource-dir "${S}"/tester/ \
		|| die "tests failed"

	cmake_src_test
}
