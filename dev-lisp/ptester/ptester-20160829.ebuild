# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

MY_PN="cl-ptester"
MY_PV="${PV}.gitfe69fde"

DESCRIPTION="Portable test harness package"
HOMEPAGE="https://tracker.debian.org/pkg/cl-ptester"
SRC_URI="mirror://debian/pool/main/c/${MY_PN}/${MY_PN}_${MY_PV}.orig.tar.xz -> ${P}.tar.xz"
S="${WORKDIR}/${MY_PN}-${MY_PV}"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
