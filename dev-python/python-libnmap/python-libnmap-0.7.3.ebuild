# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Python NMAP library"
HOMEPAGE="https://github.com/savon-noir/python-libnmap"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

pkg_postinst() {
	optfeature "support boto" dev-python/boto3
	optfeature "support defusedxml" dev-python/defusedxml
	optfeature "support mongodb" dev-python/pymongo
	optfeature "support sqlalchemy" dev-python/sqlalchemy
}
