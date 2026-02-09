# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Lazy parsing for Pydantic models"
HOMEPAGE="https://github.com/BeanieODM/lazy_model"
EGIT_REPO_URI="https://github.com/BeanieODM/lazy_model.git"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/pydantic[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
