# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A command line client (shell) for AWS DynamoDB"
HOMEPAGE="https://github.com/awslabs/dynamodb-shell"
SRC_URI="https://github.com/awslabs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P}/ddbsh"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test" # fails

RDEPEND="dev-libs/aws-sdk-cpp:=[dynamodb,iam,sts]
	sys-libs/readline:=
	sys-libs/zlib:="
DEPEND="${RDEPEND}"
BDEPEND="sys-devel/bison
	sys-devel/flex"

src_prepare() {
	! use test && eapply "${FILESDIR}/${PN}"-0.8.1-tests.patch

	cmake_src_prepare
}
