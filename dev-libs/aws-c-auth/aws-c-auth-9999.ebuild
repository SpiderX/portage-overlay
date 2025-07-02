# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="AWS client-side authentication"
HOMEPAGE="https://github.com/awslabs/aws-c-auth"
EGIT_REPO_URI="https://github.com/awslabs/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-libs/aws-c-cal:=
	dev-libs/aws-c-common:=
	dev-libs/aws-c-compression:=
	dev-libs/aws-c-http:=
	dev-libs/aws-c-io:=
	dev-libs/aws-c-sdkutils:=
	dev-libs/s2n-tls:="
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING="$(usex test)"
	)
	cmake_src_configure
}
