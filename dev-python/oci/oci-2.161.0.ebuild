# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 optfeature

MY_PN="${PN}-python-sdk"

DESCRIPTION="Oracle Cloud Infrastructure Python SDK"
HOMEPAGE="https://github.com/oracle/oci-python-sdk"
SRC_URI="https://github.com/oracle/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/circuitbreaker[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/requests[${PYTHON_USEDEP}]
		dev-python/vcrpy[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

src_prepare() {
	default

	# https://github.com/oracle/oci-python-sdk/issues/565
	sed -i 's/--config-file/--config-file-path/' tests/conftest.py \
		|| die "sed failed for conftest.py"
	# https://github.com/oracle/oci-python-sdk/pull/253
	sed -i '/from . import vcr_mods/d' tests/test_config_container.py \
		|| die "sed failed for test_config_container.py"
}

python_test() {
	epytest -v tests/autogentest tests/unit tests/integ
}

pkg_postinst() {
	optfeature "integration with adk" dev-python/pydantic dev-python/rich
}
