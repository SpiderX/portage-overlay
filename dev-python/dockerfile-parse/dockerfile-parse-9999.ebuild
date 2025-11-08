# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} python3_{13,14}t )

inherit distutils-r1 git-r3

DESCRIPTION="Python library for parsing Dockerfile files"
HOMEPAGE="https://github.com/containerbuildsystem/dockerfile-parse"
EGIT_REPO_URI="https://github.com/containerbuildsystem/${PN}.git"

LICENSE="BSD"
SLOT="0"

distutils_enable_tests pytest
