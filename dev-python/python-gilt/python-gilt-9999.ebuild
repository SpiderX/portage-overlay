# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="A GIT layering tool"
HOMEPAGE="https://github.com/metacloud/gilt"
EGIT_REPO_URI="https://github.com/metacloud/gilt.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # fails

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/fasteners[${PYTHON_USEDEP}]
	dev-python/git-url-parse[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]"
BDEPEND="dev-python/pbr[${PYTHON_USEDEP}]
	test? ( dev-python/pytest-helpers-namespace[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
