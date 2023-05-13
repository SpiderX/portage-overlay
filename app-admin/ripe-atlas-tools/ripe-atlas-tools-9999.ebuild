# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,10} )
EGIT_REPO_URI="https://github.com/RIPE-NCC/${PN}.git"

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="The official command-line client for RIPE Atlas"
HOMEPAGE="https://github.com/RIPE-NCC/ripe-atlas-tools"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/ipy[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/ripe-atlas-cousteau[${PYTHON_USEDEP}]
	dev-python/ripe-atlas-sagan[${PYTHON_USEDEP}]
	dev-python/tzlocal[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}] )"

DOCS=( {CHANGES,README}.rst )

distutils_enable_sphinx docs
distutils_enable_tests nose

python_prepare_all() {
	# wrt 659348
	sed -i 's/yaml.load/yaml.safe_load/' ripe/atlas/tools/settings/__init__.py \
		|| die "sed failed for __init__.py"
	# reports require network
	sed -i  -e "/from .report import TestReportCommand/d" \
		-e "/TestReportCommand,/d" tests/commands/__init__.py \
		|| die "sed failed for commands/__init__.py"
	sed -i "/TestReportCommand,/d" tests/__init__.py \
		|| die "sed failed for tests/__init__.py"
	distutils-r1_python_prepare_all
}

python_install() {
	distutils-r1_python_install
	echo "RIPE Atlas Tools (Magellan) [Gentoo Linux] ${PVR}" > \
		"${D}$(python_get_sitedir)"/ripe/atlas/tools/user-agent
}

python_install_all() {
	distutils-r1_python_install_all
	find "${D}" -name '*.pth' -delete || die
}

pkg_postinst() {
	optfeature "fast json processing" dev-python/ujson
}
