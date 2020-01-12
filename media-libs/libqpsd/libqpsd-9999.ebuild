# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/roniemartinez/libqpsd.git"

inherit cmake git-r3

DESCRIPTION="PSD & PSB Plugin for Qt/C++"
HOMEPAGE="https://github.com/roniemartinez/libqpsd"
SRC_URI=""

LICENSE="LGPL-2.1+"
SLOT="0/2.2.1"
KEYWORDS=""
IUSE=""

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5"
DEPEND="${RDEPEND}"
