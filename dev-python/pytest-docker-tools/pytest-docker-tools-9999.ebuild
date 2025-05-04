# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Opionated helpers for creating py.test fixtures for Docker"
HOMEPAGE="https://github.com/Jc2k/pytest-docker-tools"
EGIT_REPO_URI="https://github.com/Jc2k/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/docker[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
