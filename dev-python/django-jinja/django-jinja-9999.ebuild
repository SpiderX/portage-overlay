# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )
EGIT_REPO_URI="https://github.com/niwinz/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Jinja2 templating language integrated in Django"
HOMEPAGE="https://github.com/niwinz/django-jinja"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"

# tests require <dev-python/django-pipeline-1.6, which requires old Django
PATCHES=( "${FILESDIR}"/"${PN}"-2.4.1-test.patch )

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/django-pipeline[${PYTHON_USEDEP}]
		virtual/python-unittest-mock[${PYTHON_USEDEP}]
		$(python_gen_impl_dep sqlite) )"

python_test() {
	"${PYTHON}" testing/runtests.py || die "tests failed with ${EPYTHON}"
}
