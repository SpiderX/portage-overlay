# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Ordered YAML"
HOMEPAGE="https://github.com/wimglenn/oyaml"
EGIT_REPO_URI="https://github.com/wimglenn/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/pyyaml[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
