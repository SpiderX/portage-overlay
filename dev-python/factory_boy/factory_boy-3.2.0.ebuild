# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="A fixtures replacement tool"
HOMEPAGE="https://github.com/FactoryBoy/factory_boy"
SRC_URI="https://github.com/FactoryBoy/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/faker[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( $(python_gen_impl_dep sqlite)
		dev-python/django[${PYTHON_USEDEP}]
		dev-python/mongoengine[${PYTHON_USEDEP}]
		dev-python/pillow[jpeg,${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest

python_prepare_all() {
	# Fix symbolic link QA
	rm ChangeLog || die "remove failed"
	cp docs/changelog.rst ChangeLog || die "copy failed"

	# Remove tests require database
	rm tests/test_mongoengine.py || die "rm failed"

	distutils-r1_python_prepare_all
}
