# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..7}} )

inherit distutils-r1

DESCRIPTION="Simple Python interface for Graphviz"
HOMEPAGE="https://github.com/xflr6/graphviz"
SRC_URI="https://github.com/xflr6/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="media-gfx/graphviz"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Remove coverage from tests, fix usage of addopts by pytest
	sed -i -e '/--cov --cov-report=term --cov-report=html/d' \
		-e ':begin;$!N;s/\(addopts =\)\n/\1/;tbegin;P;D' \
		setup.cfg || die "sed failed for setup.cfg"

	# Mark test that should faild
	sed -i '/test_pipe_pipe/i @pytest.mark.xfail' \
		tests/test_backend.py || die "sed failed for test_backend.py"

	distutils-r1_python_prepare_all
}

python_test() {
	py.test -v || die "tests failed with ${EPYTHON}"
}
