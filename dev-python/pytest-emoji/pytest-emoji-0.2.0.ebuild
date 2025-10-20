# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="A pytest plugin that adds emojis to your test result report"
HOMEPAGE="https://github.com/hackebrot/pytest-emoji"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/${PN}"-0.2.0-tests.patch )

distutils_enable_tests pytest
