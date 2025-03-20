# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Backport of configparser from Python 3"
HOMEPAGE="https://github.com/jaraco/configparser"
SRC_URI="https://github.com/jaraco/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? ( dev-python/test[${PYTHON_USEDEP}] )"

export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"

distutils_enable_tests pytest
