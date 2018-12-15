# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )

inherit distutils-r1 eutils

DESCRIPTION="An asset packaging library for Django"
HOMEPAGE="https://github.com/jazzband/django-pipeline"
SRC_URI="https://github.com/jazzband/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	virtual/python-futures[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( $(python_gen_impl_dep sqlite)
		dev-python/jinja[${PYTHON_USEDEP}]
		dev-python/jsmin[${PYTHON_USEDEP}]
		dev-python/slimit[${PYTHON_USEDEP}]
		virtual/python-unittest-mock[${PYTHON_USEDEP}] )"

python_test() {
	# Upstream allows tests to fail
	# https://github.com/jazzband/django-pipeline/blob/master/.travis.yml#L65
	python_is_python3 && eapply "${FILESDIR}"/"${P}"-py3-test.patch
	PYTHONPATH=. django-admin.py test --settings=tests.settings tests \
		|| die "tests failed with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "integration with Closure Compiler compressor" dev-lang/closure-compiler-bin
	optfeature "integration with JSMin compressor" dev-python/jsmin
	optfeature "integration with SlimIt compressor" dev-python/slimit
	optfeature "integration with YUI compressor" dev-util/yuicompressor
}
