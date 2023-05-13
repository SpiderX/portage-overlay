# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,10} )
EGIT_REPO_URI="https://github.com/vmware/${PN}.git"

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="VMware vSphere API Python Bindings"
HOMEPAGE="https://github.com/vmware/pyvmomi"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/vcrpy[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest

python_test() {
	"${PYTHON}" -m unittest discover -v tests || die "tests failed with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "single sign-on" dev-python/pyopenssl dev-python/lxml
}
