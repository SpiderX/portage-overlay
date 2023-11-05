# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{9..12} )

inherit distutils-r1 pypi

DESCRIPTION="Type annotations and code completion for awscrt"
HOMEPAGE="https://github.com/youtype/types-awscrt"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
