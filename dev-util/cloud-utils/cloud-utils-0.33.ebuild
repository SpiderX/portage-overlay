# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit python-r1

DESCRIPTION="Utilities for interacting with a cloud"
HOMEPAGE="https://github.com/canonical/cloud-utils"
SRC_URI="https://github.com/canonical/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

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
		doman man/write-mime-multipart.1
	fi
}
