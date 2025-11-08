# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="AWS CloudFormation Template Flip"
HOMEPAGE="https://github.com/awslabs/aws-cfn-template-flip"
EGIT_REPO_URI="https://github.com/awslabs/aws-${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_prepare_all() {
	# disable coverage
	sed -i '/addopts/d' tox.ini || die "sed failed for tox.ini"

	# add missing loader
	sed -i '/yaml.load(/s|string|string, Loader=yaml.SafeLoader|' \
		tests/test_yaml_patching.py || die "sed failed for test_yaml_patching.py"

	distutils-r1_python_prepare_all
}
