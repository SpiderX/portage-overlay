# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="PSD & PSB Plugin for Qt/C++"
HOMEPAGE="https://github.com/roniemartinez/libqpsd"
SRC_URI="https://github.com/roniemartinez/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0/2.2.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5"
DEPEND="${RDEPEND}"
