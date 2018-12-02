# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )
EGIT_REPO_URI="https://github.com/jazzband/${PN}.git"

inherit distutils-r1 eutils git-r3

DESCRIPTION="An asset packaging library for Django"
HOMEPAGE="https://github.com/jazzband/django-pipeline"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	virtual/python-futures[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/jinja[${PYTHON_USEDEP}]
		dev-python/jsmin[${PYTHON_USEDEP}]
		dev-python/slimit[${PYTHON_USEDEP}]
		virtual/python-unittest-mock[${PYTHON_USEDEP}]
		$(python_gen_impl_dep sqlite) )"

python_test() {
	# Upstream allows tests to fail
	# https://github.com/jazzband/django-pipeline/blob/master/.travis.yml#L65
	python_is_python3 && eapply "${FILESDIR}"/"${PN}"-1.6.14-py3-test.patch
	PYTHONPATH=. django-admin.py test --settings=tests.settings tests \
		|| die "tests failed with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "integration with Closure Compiler compressor" dev-lang/closure-compiler-bin
	optfeature "integration with JSMin compressor" dev-python/jsmin
	optfeature "integration with SlimIt compressor" dev-python/slimit
	optfeature "integration with YUI compressor" dev-util/yuicompressor
}
