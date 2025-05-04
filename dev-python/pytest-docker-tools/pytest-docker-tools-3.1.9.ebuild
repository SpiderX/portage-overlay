# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Opionated helpers for creating py.test fixtures for Docker"
HOMEPAGE="https://github.com/Jc2k/pytest-docker-tools"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/docker[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
