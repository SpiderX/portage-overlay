# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

MY_PN="${PN/-/_}"

DESCRIPTION="Lazy parsing for Pydantic models"
HOMEPAGE="https://github.com/BeanieODM/lazy_model"
SRC_URI="https://github.com/BeanieODM/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pydantic[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
