# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1

DESCRIPTION="An implementation of a LDAPObject to fake a ldap server"
HOMEPAGE="https://github.com/zulip/fakeldap"
SRC_URI="https://github.com/zulip/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/python-ldap[${PYTHON_USEDEP}]"

distutils_enable_tests nose

python_prepare_all() {
	# Remove unneeded requirement
	sed -i '/setup_requires/d' setup.py \
		|| die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}
