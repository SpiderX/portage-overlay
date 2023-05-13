# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8,10} )
EGIT_REPO_URI="https://github.com/RIPE-NCC/${PN}.git"

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Official python wrapper around RIPE Atlas API"
HOMEPAGE="https://github.com/RIPE-NCC/ripe-atlas-cousteau"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/socketio-client[${PYTHON_USEDEP}]
	dev-python/websocket-client[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/jsonschema[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}] )"

DOCS=( {CHANGES,README}.rst )

distutils_enable_sphinx docs
distutils_enable_tests nose

python_install_all() {
	distutils-r1_python_install_all
	find "${D}" -name '*.pth' -delete || die
}

pkg_postinst() {
	optfeature "fast json processing" dev-python/ujson
}
