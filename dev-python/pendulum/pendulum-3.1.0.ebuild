# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=maturin
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{11..14} )

CRATES="autocfg@1.4.0
	cc@1.2.19
	cfg-if@1.0.0
	heck@0.5.0
	indoc@2.0.6
	libc@0.2.172
	memoffset@0.9.1
	once_cell@1.21.3
	portable-atomic@1.11.0
	proc-macro2@1.0.95
	pyo3-build-config@0.24.1
	pyo3-ffi@0.24.1
	pyo3-macros-backend@0.24.1
	pyo3-macros@0.24.1
	pyo3@0.24.1
	python3-dll-a@0.2.13
	quote@1.0.40
	shlex@1.3.0
	syn@2.0.100
	target-lexicon@0.13.2
	unicode-ident@1.0.18
	unindent@0.2.4"

inherit cargo distutils-r1

DESCRIPTION="Python datetimes made easy"
HOMEPAGE="https://github.com/python-pendulum/pendulum"
SRC_URI="https://github.com/python-pendulum/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz
	${CARGO_CRATE_URIS}"

LICENSE="Apache-2.0-with-LLVM-exceptions MIT Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/tzdata[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/time-machine[${PYTHON_USEDEP}] )"

QA_FLAGS_IGNORED="usr/lib/python3.*/site-packages/pendulum/_pendulum.cpython-313-x86_64-linux-gnu.so"

distutils_enable_tests pytest
