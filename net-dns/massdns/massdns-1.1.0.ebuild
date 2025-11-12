# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake edo

DESCRIPTION="A high-performance DNS stub resolver"
HOMEPAGE="https://github.com/blechschmidt/massdns"
SRC_URI="https://github.com/blechschmidt/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ipv6 test"
RESTRICT="test"
PROPERTIES="test_network"

BDEPEND="test? ( app-misc/jq )"

src_prepare() {
	! use ipv6 && edo rm -rf tests/single-lookup-A-ipv6-resolver

	cmake_src_prepare
}

src_test() {
	# mimic expected layout
	edo mkdir bin
	edo ln -s ../../massdns-1.1.0_build/bin/massdns bin/
	edo tests/run-tests.sh
}

src_install() {
	einstalldocs

	dobin "${S}"_build/bin/massdns
	dodoc -r lists
}
