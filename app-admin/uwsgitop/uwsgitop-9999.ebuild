# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} python3_13t )

inherit distutils-r1 git-r3

DESCRIPTION="uWSGI stats viewer"
HOMEPAGE="https://github.com/xrmx/uwsgitop"
EGIT_REPO_URI="https://github.com/xrmx/${PN}.git"

LICENSE="MIT"
SLOT="0"
