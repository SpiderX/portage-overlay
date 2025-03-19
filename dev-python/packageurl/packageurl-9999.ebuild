# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
EGIT_REPO_URI="https://github.com/bboe/packageurl-python.git"
PYTHON_COMPAT=( python3_{10..13} python3_13t )

inherit distutils-r1 git-r3

DESCRIPTION="Python implementation of the package url spec"
HOMEPAGE="https://github.com/package-url/packageurl-python"

LICENSE="MIT"
SLOT="0"

distutils_enable_tests pytest
