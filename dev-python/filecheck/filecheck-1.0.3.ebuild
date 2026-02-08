# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="A Python-native clone of LLVMs FileCheck tool"
HOMEPAGE="https://github.com/AntonLydike/filecheck"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
