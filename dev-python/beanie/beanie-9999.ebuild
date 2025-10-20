# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 edo git-r3

DESCRIPTION="Asynchronous Python ODM for MongoDB"
HOMEPAGE="https://github.com/BeanieODM/beanie"
EGIT_REPO_URI="https://github.com/BeanieODM/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/lazy-model[${PYTHON_USEDEP}]
	dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/pymongo[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-db/mongodb
		dev-python/asgi-lifespan[${PYTHON_USEDEP}]
		dev-python/email-validator[${PYTHON_USEDEP}]
		dev-python/fastapi[${PYTHON_USEDEP}]
		dev-python/httpx[${PYTHON_USEDEP}]
		dev-python/pydantic-settings[${PYTHON_USEDEP}] )"

# xdist creates race in mongodb queries
EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

src_prepare() {
	default

	# remove coverage
	sed -i '/addopts/d' pyproject.toml || die "sed failed"
}

src_test() {
	edo mongod --port 27017 --bind_ip 127.0.0.1 --nounixsocket --fork \
		--dbpath="${T}" --logpath="${T}/mongod.log"
	# ulimit -n 16384
	distutils-r1_src_test
	edo kill "$(<"${T}/mongod.lock")"
}
