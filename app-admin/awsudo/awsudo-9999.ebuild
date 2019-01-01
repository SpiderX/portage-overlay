# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )
EGIT_REPO_URI="https://github.com/makethunder/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="A temporary credentials for AWS roles via sudo-like utility"
HOMEPAGE="https://github.com/makethunder/awsudo"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/awscli[${PYTHON_USEDEP}]
	dev-python/boto[${PYTHON_USEDEP}]
	dev-python/retrying[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_test() {
	py.test -v || die "tests failed with ${EPYTHON}"
}
