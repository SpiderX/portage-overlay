# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
EGIT_REPO_URI="https://github.com/salesforce/${PN}.git"
PYTHON_COMPAT=( python3_{9..12} )

inherit distutils-r1 git-r3

DESCRIPTION="AWS IAM Least Privilege Policy Generator"
HOMEPAGE="https://github.com/salesforce/policy_sentry"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/schema[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
