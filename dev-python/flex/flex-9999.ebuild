# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )
EGIT_REPO_URI="https://github.com/pipermerriam/${PN}.git"

inherit distutils-r1 eutils git-r3

DESCRIPTION="Validation tooling for Swagger 2.0 specifications"
HOMEPAGE="https://github.com/pipermerriam/flex"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/jsonpointer[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/rfc3987[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/strict-rfc3339[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/validate_email[${PYTHON_USEDEP}]' '-2')"
DEPEND="${RDEPEND}
	$(python_gen_cond_dep 'dev-python/validate_email[${PYTHON_USEDEP}]' '-3')"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/django[${PYTHON_USEDEP}]
		dev-python/factory_boy[${PYTHON_USEDEP}]
		dev-python/falcon[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-httpbin[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}]
		dev-python/webob[${PYTHON_USEDEP}]
		www-servers/tornado[${PYTHON_USEDEP}] )"

python_test() {
	py.test -v || die "tests failed with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "integration with django" dev-python/django
	optfeature "integration with tornado" www-servers/tornado
	optfeature "integration with falcon" dev-python/falcon
	optfeature "integration with webob" dev-python/webob
	optfeature "integration with werkzeug" dev-python/werkzeug
}
