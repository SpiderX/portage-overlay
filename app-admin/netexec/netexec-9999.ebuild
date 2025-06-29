# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="The Network Execution Tool"
HOMEPAGE="https://github.com/Pennyw0rth/NetExec"
EGIT_REPO_URI="https://github.com/Pennyw0rth/NetExec.git"

LICENSE="BSD-2"
SLOT="0"
RESTRICT="test" # broken

RDEPEND="dev-python/aardwolf[${PYTHON_USEDEP}]
	dev-python/argcomplete[${PYTHON_USEDEP}]
	dev-python/asyauth[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/bloodhound[${PYTHON_USEDEP}]
	dev-python/dploot[${PYTHON_USEDEP}]
	dev-python/dsinternals[${PYTHON_USEDEP}]
	dev-python/impacket[${PYTHON_USEDEP}]
	dev-python/pyjwt[${PYTHON_USEDEP}]
	dev-python/lsassy[${PYTHON_USEDEP}]
	dev-python/masky[${PYTHON_USEDEP}]
	dev-python/minikerberos[${PYTHON_USEDEP}]
	dev-python/msldap[${PYTHON_USEDEP}]
	dev-python/neo4j[${PYTHON_USEDEP}]
	dev-python/oscrypto[${PYTHON_USEDEP}]
	dev-python/paramiko[${PYTHON_USEDEP}]
	dev-python/pyasn1-modules[${PYTHON_USEDEP}]
	dev-python/pylnk3[${PYTHON_USEDEP}]
	dev-python/pynfsclient[${PYTHON_USEDEP}]
	dev-python/pypsrp[${PYTHON_USEDEP}]
	dev-python/pypykatz[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/python-libnmap[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	dev-python/terminaltables3[${PYTHON_USEDEP}]
	dev-python/xmltodict[${PYTHON_USEDEP}]"
BDEPEND="dev-python/poetry-dynamic-versioning[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_prepare_all() {
	# change build backend and set version
	sed -i  -e '/build-backend/s|_dynamic_versioning.backend|.core.masonry.api|' \
		-e "/^version/s|0.0.0|${PV}|" pyproject.toml \
		|| die "sed failed for pyproject.toml"

	# use pycryptodome instead of pycryptodomex
	sed -i 's/Cryptodome/Crypto/' nxc/modules/{gpp_password,mremoteng,vnc}.py \
		nxc/protocols/{ldap,smb,smb/firefox}.py \
		|| die "sed failed for cryptodomex"

	# adjust import
	sed -i 's/terminaltables/terminaltables3/' nxc/nxcdb.py \
		|| die "sed failed for nxcdb.py"

	distutils-r1_python_prepare_all
}
