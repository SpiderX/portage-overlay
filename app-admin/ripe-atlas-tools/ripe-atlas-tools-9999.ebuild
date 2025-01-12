# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
EGIT_REPO_URI="https://github.com/RIPE-NCC/${PN}.git"

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="The official command-line client for RIPE Atlas"
HOMEPAGE="https://github.com/RIPE-NCC/ripe-atlas-tools"

LICENSE="GPL-3"
SLOT="0"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/ipy[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/ripe-atlas-cousteau[${PYTHON_USEDEP}]
	dev-python/ripe-atlas-sagan[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	dev-python/tzlocal[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

DOCS=( {CHANGES,README}.rst )

distutils_enable_sphinx docs
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# format is deprecated
	tests/test_docs.py::DocTest::test_html_documentation
	# assertion error
	tests/renderers/test_traceroute_aspath.py::TestTracerouteASPathRenderer::test_arg_radius
	tests/renderers/test_traceroute_aspath.py::TestTracerouteASPathRenderer::test_basic
)

python_prepare_all() {
	sed -i  -e '/namespace_packages/d' \
		-e '/ripe.atlas.tools/s/"]/", "ripe.atlas.tools.aggregators", "ripe.atlas.tools.commands"]/' \
		-e '/ripe.atlas.tools/s/"]/", "ripe.atlas.tools.commands.measure", "ripe.atlas.tools.helpers"]/' \
		-e '/ripe.atlas.tools/s/"]/", "ripe.atlas.tools.renderers", "ripe.atlas.tools.renderers.templates.reports"]/' \
		-e '/ripe.atlas.tools/s/"]/", "ripe.atlas.tools.settings", "ripe.atlas.tools.settings.templates"]/' \
		setup.py || die "sed failed"
	distutils-r1_python_prepare_all
}

python_install() {
	distutils-r1_python_install
	echo "RIPE Atlas Tools (Magellan) [Gentoo Linux] ${PVR}" > \
		"${D}$(python_get_sitedir)"/ripe/atlas/tools/user-agent
}

pkg_postinst() {
	optfeature "fast json processing" dev-python/ujson
}
