# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5..6}} )
PYTHON_REQ_USE="threads(+)"
EGIT_REPO_URI="https://github.com/jazzband/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="A configurable set of panels that display debug information"
HOMEPAGE="https://github.com/django-debug-toolbar/django-debug-toolbar"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="doc examples test"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/python-sqlparse[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( $(python_gen_impl_dep sqlite)
		dev-python/django-jinja[${PYTHON_USEDEP}]
		dev-python/html5lib[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Prevent non essential d'loading by intersphinx
	sed -i 's:intersphinx_mapping:_&:' docs/conf.py \
		|| die "sed failed for docs/conf.py"

	# Don't install tests
	sed -i "/find_packages/s:'tests':'tests.\\*', 'tests':" setup.py \
		|| die "sed failed for setup.py"

	# Make tests verbose
	sed -i '/python -m django test/s/$/ --verbosity 2/' Makefile \
		|| die "sed failed for Makefile"

	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	emake test
	#todo: emake test_selenium
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	use examples && local EXAMPLES=( example/. )
	distutils-r1_python_install_all
}
