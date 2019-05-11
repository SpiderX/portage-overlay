# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5..6} )

inherit distutils-r1 linux-mod

DESCRIPTION="Linux drivers for the Razer devices"
HOMEPAGE="https://openrazer.github.io"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="client +daemon test"
REQUIRED_USE="daemon? ( ${PYTHON_REQUIRED_USE} )
	client? ( daemon )
	test? ( || ( client daemon ) )"

RDEPEND="virtual/udev
	client? ( dev-python/numpy[$PYTHON_USEDEP] )
	daemon? ( ${PYTHON_DEPS}
		dev-python/daemonize[$PYTHON_USEDEP]
		dev-python/dbus-python[$PYTHON_USEDEP]
		dev-python/notify2[$PYTHON_USEDEP]
		dev-python/pygobject:3[$PYTHON_USEDEP]
		dev-python/python-evdev[$PYTHON_USEDEP]
		dev-python/pyudev[$PYTHON_USEDEP]
		dev-python/setproctitle[$PYTHON_USEDEP]
		sys-apps/dbus )"
DEPEND="${RDEPEND}
	virtual/linux-sources"
BDEPEND="test? ( client? ( x11-libs/gtk+:3[introspection] ) )"

pkg_setup() {
	BUILD_TARGETS="clean modules"
	BUILD_PARAMS="KERNELDIR=${KERNEL_DIR} -C ${KERNEL_DIR} SUBDIRS=${S}/driver"
	MODULE_NAMES="razerkbd(hid:${S}/driver) \
			razermouse(hid:${S}/driver) \
			razermousemat(hid:${S}/driver) \
			razerkraken(hid:${S}/driver) \
			razermug(hid:${S}/driver) \
			razercore(hid:${S}/driver)"
	linux-mod_pkg_setup
}

src_prepare() {
	default

	# Fix jobserver unavailable
	sed -i  -e '/daemon install$/s/make/$(MAKE)/' \
		-e '/pylib install$/s/@make/$(MAKE)/' \
		Makefile || die "sed failed for Makefile"
	# Do not to install compressed files
	sed -i '/gzip/d' daemon/Makefile || die "sed failed for daemon/Makefile"
}

python_test() {
	if use daemon ; then
		pushd daemon || die "pushd daemon failed"
		"${PYTHON}" -m unittest discover -v tests || die "tests failed with ${EPYTHON}"
		popd || die "popd daemon failed"
	fi
	if use client ; then
		pushd pylib || die "pushd pylib failed"
		"${PYTHON}" -m unittest discover -v tests/integration_tests \
			|| die "tests failed with ${EPYTHON}"
		popd || die "popd pylib failed"
	fi
}

src_install() {
	linux-mod_src_install

	python_install() {
		# Pass dummy target for false, since empty string disallowed
		emake DESTDIR="${D}" "$(usex daemon daemon_install manual_install_msg)" \
			"$(usex client python_library_install manual_install_msg)"
		python_optimize
	}

	emake DESTDIR="${D}" ubuntu_udev_install
	use daemon && python_foreach_impl python_install
}
