# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Pure-python selinux shim module for use in virtualenvs"
HOMEPAGE="https://github.com/pycontribs/selinux"
EGIT_REPO_URI="https://github.com/pycontribs/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/distro[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"
