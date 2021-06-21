# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Pure-python selinux shim module for use in virtualenvs"
HOMEPAGE="https://github.com/pycontribs/selinux"
SRC_URI="https://github.com/pycontribs/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/distro[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]
	dev-python/setuptools_scm_git_archive[${PYTHON_USEDEP}]"

python_prepare_all() {
	# setuptools is unable to detect version
	sed -i  -e "/setup(/a\\    version='${PV}'," \
		-e "/use_scm_version/s/True/False/" \
		setup.py || die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}
