# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
EGIT_REPO_URI="https://github.com/microsoft/ApplicationInsights-Python.git"

inherit distutils-r1 eutils git-r3

DESCRIPTION="Application Insights SDK for Python"
HOMEPAGE="https://github.com/microsoft/ApplicationInsights-Python"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

BDEPEND="test? ( dev-python/django[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest

pkg_postinst() {
	optfeature "integration with Django" dev-python/django
}
