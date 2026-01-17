# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm-backend
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Document parameters, class attributes and variables inline"
HOMEPAGE="https://github.com/fastapi/annotated-doc"
EGIT_REPO_URI="https://github.com/fastapi/${PN}.git"

LICENSE="MIT"
SLOT="0"

distutils_enable_tests pytest
