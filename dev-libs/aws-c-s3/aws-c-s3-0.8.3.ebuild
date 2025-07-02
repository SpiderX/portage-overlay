# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="AWS SDK S3 implementation"
HOMEPAGE="https://github.com/awslabs/aws-c-s3"
SRC_URI="https://github.com/awslabs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test" # needs S3 bucket

RDEPEND="dev-libs/aws-c-auth:=
	dev-libs/aws-c-cal:=
	dev-libs/aws-c-common:=
	dev-libs/aws-c-compression:=
	dev-libs/aws-c-http:=
	dev-libs/aws-c-io:=
	dev-libs/aws-c-sdkutils:=
	dev-libs/aws-checksums
	dev-libs/s2n-tls:="
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING="$(usex test)"
	)
	cmake_src_configure
}
