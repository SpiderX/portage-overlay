# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg

DESCRIPTION="A free VoIP and video softphone based on the SIP protocol"
HOMEPAGE="https://gitlab.linphone.org/BC/public/linphone-desktop"
SRC_URI="https://github.com/BelledonneCommunications/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""
RESTRICT="test" # needs sdk

RDEPEND="dev-libs/belcard
	dev-libs/liblinphone
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
	net-libs/ortp"
DEPEND="${RDEPEND}"
BDEPEND="dev-vcs/git
	dev-qt/linguist-tools:5
	virtual/pkgconfig"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	# bc_git_version needs git repository
	pushd linphone-app || die "pushd failed"
	git init > /dev/null || die "git init failed"
	git config user.email "${PN}@gentoo.org" || die "git config failed"
	git config user.name "${PN}" || die "git config failed"
	git add --all > /dev/null || die "git add failed"
	git commit -m "${PV}" > /dev/null || die "git commit failed"
	git tag -m "${PV}" "${PV}" || die "git tag failed"
	popd || die "popd failed"

	# Don't build SDK and app-library targets, remove non-existed directory,
	# reuse OUTPUT for bin directory, and create share directory
	sed  -i -e "/ExternalProject_Add(sdk/,+17d" \
		-e "/app-library/d" \
		-e "/set(LINPHONE_OUTPUT_DIR/s|/linphone-sdk/desktop||" \
		-e "/set(APPLICATION_OUTPUT_DIR/s|/OUTPUT|/bin|" \
		-e "\$aadd_custom_target(make-share ALL COMMAND \${CMAKE_COMMAND} -E make_directory \"\${CMAKE_BINARY_DIR}/share\")" \
		CMakeLists.txt || die "sed failed for CMakeLists.txt"
	# Don't install qt.conf
	sed -i "/install(FILES \"\${CMAKE_CURRENT_BINARY_DIR}\/..\/..\/qt.conf/d" \
		linphone-app/cmake_builder/linphone_package/CMakeLists.txt \
		|| die "sed failed for linphone_package/CMakeLists.txt"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_APP_PACKAGING=NO
		-DENABLE_BUILD_VERBOSE=YES
		-DENABLE_UPDATE_CHECK=NO
	)
	cmake_src_configure
}
