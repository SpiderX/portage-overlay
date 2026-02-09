# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 optfeature

DESCRIPTION="Human-readable HTML tracebacks for Python exceptions"
HOMEPAGE="https://github.com/sanic-org/tracerite"
SRC_URI="https://github.com/sanic-org/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#RESTRICT="test" # no tests

RDEPEND="dev-python/html5tagger[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? ( dev-python/numpy[${PYTHON_USEDEP}] )"
#		sci-ml/pytorch[${PYTHON_USEDEP}] )"

export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "integration with ipykernel" dev-python/ipykernel
	optfeature "integration with ipywidgets" dev-python/ipywidgets
	optfeature "integration with jupyter" dev-python/jupyter dev-python/jupyter-client \
		dev-python/jupyterlab dev-python/notebook
}
