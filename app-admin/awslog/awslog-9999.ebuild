# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )
EGIT_REPO_URI="https://github.com/jaksi/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="History and changes of configuration versions of AWS resources"
HOMEPAGE="https://github.com/jaksi/awslog"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	>=dev-python/boto3-1.9[${PYTHON_USEDEP}]
	dev-python/crayons[${PYTHON_USEDEP}]
	dev-python/dateparser[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare() {
	default

	# Fix Non-ASCII character '\xc3', relax package depends
	sed -i \
		-e '/author=/s/ó/o/' \
		-e '/boto3/s/=/>/' \
		setup.py || die "sed failed for authon in setup.py"
}
