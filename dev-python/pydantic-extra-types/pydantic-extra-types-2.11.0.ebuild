# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Extra Pydantic types"
HOMEPAGE="https://github.com/pydantic/pydantic-extra-types"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/cron-converter[${PYTHON_USEDEP}]
		dev-python/pendulum[${PYTHON_USEDEP}]
		dev-python/phonenumbers[${PYTHON_USEDEP}]
		dev-python/pycountry[${PYTHON_USEDEP}]
		dev-python/python-ulid[${PYTHON_USEDEP}]
		dev-python/semver[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

pkg_postinst() {
	optfeature "support for cron" dev-python/cron-converter
	optfeature "support of pendulum" dev-python/pendulum
	optfeature "support for phonenumbers" dev-python/phonenumbers
	optfeature "support of pycountry" dev-python/pycountry
	optfeature "support for semver" dev-python/semver
	optfeature "support for ulid" dev-python/python-ulid
}
