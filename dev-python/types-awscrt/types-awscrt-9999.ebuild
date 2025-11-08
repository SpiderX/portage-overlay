# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Type annotations and code completion for awscrt"
HOMEPAGE="https://github.com/youtype/types-awscrt"
EGIT_REPO_URI="https://github.com/youtype/${PN}.git"

LICENSE="MIT"
SLOT="0"
