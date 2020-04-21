# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{6..7}} )
EGIT_REPO_URI="https://github.com/microsoft/ApplicationInsights-Python.git"

inherit distutils-r1 git-r3

DESCRIPTION="Application Insights SDK for Python"
HOMEPAGE="https://github.com/microsoft/ApplicationInsights-Python"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

python_test() {
	"${PYTHON}" -m unittest discover -v tests || die "tests failed with ${EPYTHON}"
}
