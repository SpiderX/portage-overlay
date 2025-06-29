# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Collection of Python classes for working with network protocols"
HOMEPAGE="https://github.com/fortra/impacket"
EGIT_REPO_URI="https://github.com/fortra/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/charset-normalizer[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/ldap3[${PYTHON_USEDEP}]
	dev-python/ldapdomaindump[${PYTHON_USEDEP}]
	dev-python/pyasn1[${PYTHON_USEDEP}]
	dev-python/pyasn1-modules[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_prepare_all() {
	# use pycryptodome instead of pycryptodomex
	sed -i 's/Cryptodome/Crypto/' examples/{dpapi,describeTicket,goldenPac}.py \
		examples/{Get-GPPPassword,mimikatz,rdp_check}.py \
		impacket/examples/ntlmrelayx/{attacks/ldapattack,utils/shadow_credentials}.py \
		impacket/examples/{ntlmrelayx/clients/dcsyncclient,secretsdump}.py \
		impacket/{ntlm,dpapi,smb3,dpapi_ng,spnego,crypto}.py \
		impacket/krb5/{gssapi,crypto}.py \
		impacket/dcerpc/v5/{rpcrt,samr,drsuapi,nrpc}.py \
		tests/dcerpc/test_{nrpc,samr,mimilib}.py \
		tests/misc/test_dpapi.py tests/SMB_RPC/test_ntlm.py \
		|| die "sed failed for cryptodomex"

	# don't install docs
	sed -i 's|Darwin|Linux|' setup.py || die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}

python_test() {
	epytest -m 'not remote'
}
