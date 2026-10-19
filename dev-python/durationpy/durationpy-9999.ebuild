# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 git-r3

DESCRIPTION="Converting between datetime.timedelta and Go Duration strings"
HOMEPAGE="https://github.com/icholy/durationpy"
EGIT_REPO_URI="https://github.com/icholy/${PN}.git"

LICENSE="MIT"
SLOT="0"

distutils_enable_tests unittest
