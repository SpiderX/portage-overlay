# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/awslabs/aws-cloudformation-template-formatter.git"

inherit git-r3 go-module

DESCRIPTION="AWS CloudFormation Template Formatter"
HOMEPAGE="https://github.com/awslabs/aws-cloudformation-template-formatter"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	go build ./cmd/cfn-format || die "build failed"
}

src_install() {
	einstalldocs
	dobin cfn-format
}
