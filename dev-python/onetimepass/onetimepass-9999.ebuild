# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )
EGIT_REPO_URI="https://github.com/tadeck/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="One-time password library for HOTP and TOTP passwords"
HOMEPAGE="https://github.com/tadeck/onetimepass"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/timecop[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest
