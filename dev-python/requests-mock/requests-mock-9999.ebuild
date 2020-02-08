# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{6..8} )
EGIT_REPO_URI="https://github.com/jamielennox/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Mock out responses from the requests package"
HOMEPAGE="https://github.com/jamielennox/requests-mock"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="doc test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/pbr[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( dev-python/fixtures[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/purl[${PYTHON_USEDEP}]
		dev-python/testrepository[${PYTHON_USEDEP}]
		dev-python/testtools[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Disable reno which only works inside a git repository
	# Disable intersphinx
	sed -i  -e "s/'reno.sphinxext',//" \
		-e "s/'sphinx.ext.intersphinx'//" \
		doc/source/conf.py || die "sed failed for conf.py"

	# Remove the release notes section which requires reno
	rm doc/source/release-notes.rst || die
	sed -i '/^=============$/,/release-notes/d' doc/source/index.rst \
		|| die "sed failed for index.rst"

	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc ; then
		sphinx-build doc/source docs/source/build/_html || die
		HTML_DOCS=( docs/source/build/_html/. )
	fi
}

python_test() {
	"${PYTHON}" -m unittest discover -v || die "tests failed with ${EPYTHON}"
}
