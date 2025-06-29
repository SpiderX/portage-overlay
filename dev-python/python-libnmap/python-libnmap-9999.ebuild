# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Python NMAP library"
HOMEPAGE="https://github.com/savon-noir/python-libnmap"
EGIT_REPO_URI="https://github.com/savon-noir/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"
RESTRICT="test" # no tests

pkg_postinst() {
	optfeature "support boto" dev-python/boto3
	optfeature "support defusedxml" dev-python/defusedxml
	optfeature "support mongodb" dev-python/pymongo
	optfeature "support sqlalchemy" dev-python/sqlalchemy
}
