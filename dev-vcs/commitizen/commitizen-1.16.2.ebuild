# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..7} )

inherit python-r1

DESCRIPTION="Python commitizen client tool"
HOMEPAGE="https://github.com/Woile/commitizen"
SRC_URI="https://github.com/Woile/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

RDEPEND="${PYTHON_DEPS}
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/decli[${PYTHON_USEDEP}]
	>=dev-python/packaging-18[${PYTHON_USEDEP}]
	dev-python/questionary[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	dev-python/tomlkit[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}] )"

src_prepare() {
	default

	# Remove failing test requires repository
	rm tests/commands/test_bump_command.py || die "remove test_bump_command.py failed"
	rm tests/test_cz_customize.py || die "remove test_cz_customize.py failed"
}

src_test() {
	git init || die "git init failed"
	git config user.email "you@example.com" || die "git mail config failed"
	git config user.name "Your Name" || die "git user config failed"
	py.test -v || die "tests failed with ${EPYTHON}"
}

src_install() {
	einstalldocs
	do_install() {
		python_domodule commitizen
		python_scriptinto /usr/bin
		python_doexe "${FILESDIR}"/cz
		python_export "${PYTHON_TARGETS}" PYTHON_SCRIPTDIR
		python_fix_shebang "${ED}${PYTHON_SCRIPTDIR}"/cz
		python_optimize
	}
	python_foreach_impl do_install
}
