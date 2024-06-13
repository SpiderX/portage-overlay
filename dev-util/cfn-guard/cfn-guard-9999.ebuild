# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/aws-cloudformation/cloudformation-guard.git"

inherit cargo git-r3

DESCRIPTION="AWS CloudFormation Guard"
HOMEPAGE="https://github.com/aws-cloudformation/cloudformation-guard"
S="${WORKDIR}/${P}/guard"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 Boost-1.0 MIT MPL-2.0 Unicode-DFS-2016 Unlicense"
SLOT="0"
RESTRICT="mirror"

QA_FLAGS_IGNORED="usr/bin/cfn-guard"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}
