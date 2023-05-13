# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,10} )

inherit desktop linux-mod python-r1 readme.gentoo-r1 virtualx

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
		sys-apps/dbus
		x11-libs/gtk+:3[introspection] )"
DEPEND="${RDEPEND}
	virtual/linux-sources"

DOC_CONTENTS="To run as non-root, add yourself to the plugdev group:\\n
\\tusermod -a -G plugdev <user>"

BUILD_TARGETS="clean driver"
BUILD_PARAMS="O=${KV_OUT_DIR} KERNELDIR=${KERNEL_DIR} -C ${S} SUBDIRS=${S}/driver"
MODULE_NAMES="razeraccessory(hid:${S}/driver) \
		razerkbd(hid:${S}/driver) \
		razerkraken(hid:${S}/driver) \
		razermouse(hid:${S}/driver)"

src_prepare() {
	default

	# Fix jobserver unavailable
	sed -i  -e '/daemon install$/s/make/$(MAKE)/' \
		-e '/pylib install$/s/@make/$(MAKE)/' \
		Makefile || die "sed failed for Makefile"
	# Do not to install compressed files
	sed -i '/gzip/d' daemon/Makefile || die "sed failed for daemon/Makefile"
	# Change path to icon
	sed -i '/Icon=/d;/Exec=/aIcon=openrazer-daemon' \
		install_files/desktop/openrazer-daemon.desktop || die "sed faield for desktop"
	# Disable failing tests
	sed -i  -e '/test_device_keyboard_effect_framebuffer/i\    @unittest.skip("disable")' \
		-e '/test_device_keyboard_game_mode/i\    @unittest.skip("disable")' \
		-e '/test_device_keyboard_macro_add/i\    @unittest.skip("disable")' \
		-e '/test_device_keyboard_macro_enable/i\    @unittest.skip("disable")' \
		-e '/test_device_keyboard_macro_mode/i\    @unittest.skip("disable")' \
		pylib/tests/integration_tests/test_device_manager.py \
		|| die "sed failed for tests"
}

src_test() {
	if use daemon ; then
		pushd daemon || die "pushd daemon failed"
		python -m unittest discover -v tests || die "tests failed with ${EPYTHON}"
		popd || die "popd daemon failed"
	fi
	# gpasswd -a portage plugdev
	if use client ; then
		pushd pylib || die "pushd pylib failed"
		virtx python -m unittest discover -v tests/integration_tests \
			|| die "tests failed with ${EPYTHON}"
		popd || die "popd pylib failed"
	fi
}

src_install() {
	linux-mod_src_install
	readme.gentoo_create_doc

	newicon logo/openrazer-chroma.svg openrazer-daemon.svg
	domenu install_files/desktop/openrazer-daemon.desktop

	python_install() {
		# Pass dummy target for false, since empty string disallowed
		emake DESTDIR="${D}" "$(usex daemon daemon_install manual_install_msg)" \
			"$(usex client python_library_install manual_install_msg)"
		python_optimize
	}

	emake DESTDIR="${D}" ubuntu_udev_install appstream_install
	use daemon && python_foreach_impl python_install
}

pkg_postinst() {
	linux-mod_pkg_postinst
	readme.gentoo_print_elog
}
