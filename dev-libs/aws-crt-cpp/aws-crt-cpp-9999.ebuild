# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="AWS SDK Core CRT package"
HOMEPAGE="https://github.com/awslabs/aws-crt-cpp"
EGIT_REPO_URI="https://github.com/awslabs/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-libs/aws-c-auth:=
	dev-libs/aws-c-cal:=
	dev-libs/aws-c-common:=
	dev-libs/aws-c-compression:=
	dev-libs/aws-c-event-stream:=
	dev-libs/aws-c-http:=
	dev-libs/aws-c-io:=
	dev-libs/aws-c-mqtt:=
	dev-libs/aws-c-sdkutils:=
	dev-libs/aws-checksums:=
	dev-libs/s2n-tls:="
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_DEPS=OFF
		-DBUILD_TESTING="$(usex test)"
	)
	cmake_src_configure
}
