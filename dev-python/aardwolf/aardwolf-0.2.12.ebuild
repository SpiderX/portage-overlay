# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{11..13} )

CRATES="autocfg@1.5.0
	byteorder@1.5.0
	cfg-if@1.0.1
	heck@0.5.0
	indoc@2.0.6
	libc@0.2.174
	memoffset@0.9.1
	once_cell@1.21.3
	portable-atomic@1.11.1
	proc-macro2@1.0.95
	pyo3-build-config@0.23.5
	pyo3-ffi@0.23.5
	pyo3-macros-backend@0.23.5
	pyo3-macros@0.23.5
	pyo3@0.23.5
	quote@1.0.40
	syn@2.0.104
	target-lexicon@0.12.16
	unicode-ident@1.0.18
	unindent@0.2.4"

inherit cargo distutils-r1 pypi

DESCRIPTION="Asynchronous RDP client for Python"
HOMEPAGE="https://github.com/skelsec/aardwolf"
SRC_URI+="
	${CARGO_CRATE_URIS}
"

LICENSE="Apache-2.0-with-LLVM-exceptions MIT Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # no tests

RDEPEND="dev-python/arc4[${PYTHON_USEDEP}]
	dev-python/asn1crypto[${PYTHON_USEDEP}]
	dev-python/asn1tools[${PYTHON_USEDEP}]
	dev-python/asyauth[${PYTHON_USEDEP}]
	dev-python/asysocks[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pyperclip[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/unicrypto[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools-rust[${PYTHON_USEDEP}]"

QA_FLAGS_IGNORED="usr/lib/python3.*/site-packages/librlers.cpython-.*-x86_64-linux-gnu.so"
