# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Converts cron expressions into human readable strings"
HOMEPAGE="https://github.com/Salamek/cron-descriptor"
EGIT_REPO_URI="https://github.com/Salamek/${PN}.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

distutils_enable_tests unittest
