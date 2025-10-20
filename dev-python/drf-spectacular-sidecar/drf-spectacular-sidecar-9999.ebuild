# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Self-contained distribution builds of Swagger UI and Redoc with Django"
HOMEPAGE="https://github.com/tfranzel/drf-spectacular-sidecar"
EGIT_REPO_URI="https://github.com/tfranzel/${PN}.git"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
