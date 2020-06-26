# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1

DESCRIPTION="A helper for organizing Django project settings"
HOMEPAGE="https://github.com/jazzband/django-configurations"
SRC_URI="https://github.com/jazzband/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="test"

DEPEND="dev-python/six[${PYTHON_USEDEP}]"
RDEPEND="dev-python/django[${PYTHON_USEDEP}]"

distutils_enable_tests unittest

python_prepare_all() {
	# setuptools is unable to detect version
	sed -i  -e "/setup(/a\\    version='${PV}'," \
		-e "/use_scm_version/d" \
		-e "/setup_requires/d" setup.py || die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -name 'test*' -delete || die "tests removing failed"
}
