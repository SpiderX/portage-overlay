# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Extension to whey to support .pth files"
HOMEPAGE="https://github.com/repo-helper/whey-pth"
EGIT_REPO_URI="https://github.com/repo-helper/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/dom-toml[${PYTHON_USEDEP}]
	dev-python/whey[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/coincidence[${PYTHON_USEDEP}]
		dev-python/domdf-python-tools[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
