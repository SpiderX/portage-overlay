# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="The control tool for InputActions"
HOMEPAGE="https://github.com/InputActions/ctl"
SRC_URI="https://github.com/InputActions/ctl/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ctl-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-cpp/cli11
	dev-qt/qtbase:6[dbus]"
BDEPEND="kde-frameworks/extra-cmake-modules"
