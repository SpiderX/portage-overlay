# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit cmake flag-o-matic git-r3 python-r1

DESCRIPTION="SIP library supporting voice/video calls and text messaging"
HOMEPAGE="https://gitlab.linphone.org/BC/public/liblinphone"
EGIT_REPO_URI="https://gitlab.linphone.org/BC/public/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
IUSE="debug doc ldap lime qrcode test tools"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-cpp/belr
	dev-cpp/jsoncpp
	dev-cpp/xsd
	dev-db/sqlite:3
	<dev-db/soci-4.1
	dev-libs/belcard
	dev-libs/belle-sip[test?]
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
	ldap? ( net-nds/openldap:0= )
	qrcode? ( media-libs/zxing-cpp:0= )
	tools? ( ${PYTHON_DEPS}
		dev-python/pystache[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}"
BDEPEND="${PYTHON_DEPS}
	app-text/doxygen[dot]
	dev-python/pystache[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-vcs/git
	virtual/pkgconfig
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

src_prepare() {
	# fix incapability to detect jsoncpp
	sed -i '/json\/json.h/s|<|<jsoncpp/|' include/linphone/flexi-api-client.h \
		src/account_creator/flexi-api-client.cpp \
		src/account-manager-services/account-manager-services{,-request}.h \
		tester/{account_creator_flexiapi_,flexiapiclient-,remote-provisioning-}tester.cpp \
		|| die "sed failed for json"
	sed -i '/#include "json\/json.h"/s|"json/json.h"|<jsoncpp/json/json.h>|' src/http/http-client.h \
		src/core/core.cpp \
		|| die "sed failed for json"
	# rename target, name is used further in linking with linphone
	sed -i '/set(JsonCPP_TARGET/s|_lib||' cmake/FindJsonCPP.cmake \
		|| die "sed failed for FindJsonCPP.cmake"
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_CONSOLE_UI=YES
		-DENABLE_DEBUG_LOGS="$(usex debug)"
		-DENABLE_DOC="$(usex doc)"
		-DENABLE_LDAP="$(usex ldap)"
		-DENABLE_LIME_X3DH="$(usex lime)"
		-DENABLE_QRCODE="$(usex qrcode)"
		-DENABLE_STRICT=NO
		-DENABLE_TOOLS="$(usex tools)"
		-DENABLE_UNIT_TESTS="$(usex test)"
		-Wno-dev
	)
	append-flags -Wno-error=incompatible-pointer-types
	cmake_src_configure
}

src_test() {
	"${S}"_build/tester/liblinphone-tester \
		--resource-dir "${S}"/tester/ \
		|| die "tests failed"
	cmake_src_test
}

src_install() {
	cmake_src_install

	# path is needed for LibLinphoneConfig.cmake
	# portage doesn't install empty dirs
	keepdir /usr/"$(get_libdir)"/liblinphone/plugins
}
