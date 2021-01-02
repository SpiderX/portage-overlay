# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/aws-cloudformation/cloudformation-guard.git"

inherit cargo git-r3

DESCRIPTION="AWS CloudFormation Guard"
HOMEPAGE="https://github.com/aws-cloudformation/cloudformation-guard"
SRC_URI=""

LICENSE="Apache-2.0 BSL-1.1 MIT MPL-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="mirror"

S="${WORKDIR}/${P}/${PN}"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}
