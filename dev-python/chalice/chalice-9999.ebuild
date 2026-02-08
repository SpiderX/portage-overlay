# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Python Serverless Microframework for AWS"
HOMEPAGE="https://github.com/aws/chalice"
EGIT_REPO_URI="https://github.com/aws/${PN}.git"

LICENSE="BSD"
SLOT="0"
RESTRICT="test" # needs deprecated botocore.vendored

RDEPEND="dev-python/botocore[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/inquirer[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

pkg_postinst() {
	optfeature "integration with event-file-poller" dev-python/watchdog
}
