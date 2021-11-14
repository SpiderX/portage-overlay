# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Backport of configparser from Python 3"
HOMEPAGE="https://github.com/jaraco/configparser"
SRC_URI="https://github.com/jaraco/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]"

export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"

distutils_enable_tests pytest
