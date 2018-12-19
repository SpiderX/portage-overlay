# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )
EGIT_REPO_URI="https://github.com/JoshData/python-email-validator.git"

inherit distutils-r1 git-r3

DESCRIPTION="An email syntax and deliverability validation library"
HOMEPAGE="https://github.com/JoshData/python-email-validator"
SRC_URI=""

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-python/idna[${PYTHON_USEDEP}]
	virtual/python-dnspython[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	"${PYTHON}" email_validator/__init__.py --tests < test_pass.txt \
		|| die "tests failed with ${EPYTHON}"
}
