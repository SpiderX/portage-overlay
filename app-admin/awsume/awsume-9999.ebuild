# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 edo git-r3 optfeature

DESCRIPTION="A utility for easily assuming AWS IAM roles from command line"
HOMEPAGE="https://github.com/trek10inc/awsume"
EGIT_REPO_URI="https://github.com/trek10inc/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pluggy[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/xmltodict[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_test() {
	edo mkdir "${HOME}"/.awsume
	edo touch "${HOME}"/.awsume/config.yaml
	epytest -v
}

pkg_postinst() {
	optfeature "SAML support" dev-python/xmltodict
	optfeature "fuzzy support" dev-python/python-levenshtein
	optfeature "console support" app-admin/awsume-console-plugin
}
