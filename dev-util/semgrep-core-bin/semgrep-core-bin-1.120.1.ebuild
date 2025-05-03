# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit pypi

PY_TAG="cp39.cp310.cp311.py39.py310.py311"
ABI_TAG="none-musllinux_1_0_x86_64.manylinux2014_x86_64"

DESCRIPTION="Lightweight static analysis for many languages"
HOMEPAGE="https://github.com/semgrep/semgrep"
SRC_URI="$(pypi_wheel_url --unpack semgrep ${PV} ${PY_TAG} ${ABI_TAG})"
S="${WORKDIR}/semgrep-${PV}.data"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="app-arch/unzip"

QA_PREBUILT="usr/bin/semgrep-core"

src_install(){
	dobin purelib/semgrep/bin/semgrep-core
}
