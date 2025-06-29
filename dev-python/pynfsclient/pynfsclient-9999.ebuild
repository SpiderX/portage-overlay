# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Python library to simulate NFS client"
HOMEPAGE="https://github.com/Pennyw0rth/NfsClient"
EGIT_REPO_URI="https://github.com/Pennyw0rth/NfsClient.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests
