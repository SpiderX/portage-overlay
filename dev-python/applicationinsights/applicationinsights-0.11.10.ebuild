# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Application Insights SDK for Python"
HOMEPAGE="https://github.com/microsoft/ApplicationInsights-Python"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test" # not ready

distutils_enable_tests unittest

pkg_postinst() {
	optfeature "integration with Django" dev-python/django
}
