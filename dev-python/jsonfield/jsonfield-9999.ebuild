# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )
EGIT_REPO_URI="https://github.com/rpkilby/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="A reusable Django model field for storing ad-hoc JSON data"
HOMEPAGE="https://github.com/rpkilby/jsonfield"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( $(python_gen_impl_dep sqlite) )"

python_test() {
	"${PYTHON}" manage.py test -v2 || die "tests failed with ${EPYTHON}"
}
