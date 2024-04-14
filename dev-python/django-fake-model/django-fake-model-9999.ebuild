# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..12} )
EGIT_REPO_URI="https://github.com/erm0l0v/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="A library for creating fake models in the unit tests"
HOMEPAGE="https://github.com/erm0l0v/django-fake-model"

LICENSE="BSD"
SLOT="0"
RESTRICT="test"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
