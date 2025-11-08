# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Gregorian to Jalali and inverse date convertor"
HOMEPAGE="https://github.com/slashmili/jalali-core"
EGIT_REPO_URI="https://github.com/slashmili/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0"
