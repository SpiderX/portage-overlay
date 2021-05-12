# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit python-r1

DESCRIPTION="Utilities for interacting with a cloud"
HOMEPAGE="https://launchpad.net/cloud-utils"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fat iso qemu"
REQUIRED_USE="fat? ( iso qemu ) iso? ( fat qemu ) ${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	iso? ( app-cdr/cdrtools )
	fat? ( sys-fs/dosfstools
		sys-fs/mtools )
	qemu? ( app-emulation/qemu )"

src_install() {
	einstalldocs

	python_foreach_impl python_doscript bin/ec2metadata
	python_foreach_impl python_doscript bin/write-mime-multipart
	dobin bin/resize-part-image
	doman man/resize-part-image.1
	if use iso ; then
		python_foreach_impl python_doscript bin/cloud-localds
		doman man/cloud-localds.1
	fi
	if use qemu ; then
		dobin bin/mount-image-callback
	fi
}
