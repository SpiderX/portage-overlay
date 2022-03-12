# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

PN_CORE="uap-core"
PV_CORE="0.8.0"
P_CORE="${PN_CORE}-${PV_CORE}"

DESCRIPTION="A python implementation of the UA Parser"
HOMEPAGE="https://github.com/ua-parser/uap-python"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	test? ( https://github.com/ua-parser/${PN_CORE}/archive/v${PV_CORE}.tar.gz -> ${P_CORE}.tar.gz )"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="test? ( dev-python/pyyaml[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest

src_unpack() {
	default

	if use test ; then
		cp -R "${S}"/../"${P_CORE}"/. "${S}"/"${PN_CORE}" \
			|| die "copying of uap-core failed"
	fi
}

python_test() {
	"${PYTHON}" ua_parser/user_agent_parser_test.py -v || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${D}" -name '*test.*' -delete || die "test removing failed"
}
