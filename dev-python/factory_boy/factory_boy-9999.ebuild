# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )
EGIT_REPO_URI="https://github.com/FactoryBoy/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="A fixtures replacement tool"
HOMEPAGE="https://github.com/FactoryBoy/factory_boy"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/faker[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( $(python_gen_impl_dep sqlite)
		dev-db/mongodb[python_targets_python2_7]
		dev-python/django[${PYTHON_USEDEP}]
		dev-python/mongoengine[${PYTHON_USEDEP}]
		dev-python/pillow[jpeg,${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
		virtual/python-unittest-mock[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Fix symbolic link QA
	rm ChangeLog || die "remove failed"
	cp docs/changelog.rst ChangeLog || die "copy failed"

	distutils-r1_python_prepare_all
}

python_test() {
	# Wait for mongod shutdown
	sleep 2 || die "sleep failed"
	# Avoid allocating too much disk space by using mmapv1.smallFiles = 1
	echo -e "storage:\\n    mmapv1.smallFiles: true" > "${T}/mongod.conf" \
		|| die "echo failed with ${EPYTHON}"
	mongod --bind_ip 127.0.0.1 --nounixsocket --fork \
		--logpath="${T}/${EPYTHON}/mongod.log" -f "${T}/mongod.conf" \
		--dbpath="${T}/${EPYTHON}" || die "mongod startup failed with ${EPYTHON}"
	"${PYTHON}" -Wdefault -m unittest -v tests || die "tests failed with ${EPYTHON}"
	kill "$(<"${T}/${EPYTHON}/mongod.lock")" || die "mongod kill failed with ${EPYTHON}"
}
