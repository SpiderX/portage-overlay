# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo multiprocessing toolchain-funcs

MY_PN="${PN}"-toolchain
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Cross-platform toolchain for building and packaging C++ code"
HOMEPAGE="https://build2.org"
SRC_URI="https://download.build2.org/${PV}/${MY_P}.tar.xz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+libpkgconf test"
RESTRICT="!test? ( test )"

RDEPEND="dev-db/sqlite:3"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	test? ( dev-vcs/git )"

src_prepare() {
	default

	# fix handling of empty library lists returned by the libpkgconf import backend.
	# without it configure can fail with "library expected in ''" while importing pkg-config dependencies.
	use libpkgconf && eapply "${FILESDIR}/${PN}"-0.18.1-pkgconf.patch

	# phase 1: build the minimal build2 executable with the upstream GNU make bootstrap.
	# This gives us a local b-boot that can understand the build2 project files.
	emake -C build2 -f bootstrap.gmake \
		CXX="$(tc-getCXX)" \
		CXXFLAGS="${CXXFLAGS}" \
		LDFLAGS="${LDFLAGS}"

	# phase 2: rebuild b-boot with build2 itself. Keep this binary static so later
	# configure/build/install phases do not depend on shared libraries that are still
	# being rebuilt inside the source tree.
	edo build2/b/b-boot -V -j "$(makeopts_jobs)" \
		config.build2_toolchain.build.readonly=true \
		config.cxx="$(tc-getCXX)" \
		config.cxx.coptions="${CXXFLAGS}" \
		config.cxx.loptions="${LDFLAGS}" \
		config.bin.lib=static \
		build2/b/exe{b}

	edo mv build2/b/{b,b-boot}
}

src_configure() {
	# configure the full toolchain from the top-level project. The top-level
	# buildfile only supports configure/dist until this step has completed.
	# Use hermetic configuration to avoid accidental host/user build2 state.
	# Use system sqlite/pkgconf rather than bundled replacements.
	edo build2/b/b-boot -V configure \
		config.build2_toolchain.build.readonly=true \
		config.config.hermetic=true \
		config.cxx="$(tc-getCXX)" \
		config.cxx.coptions="${CXXFLAGS}" \
		config.cxx.loptions="${LDFLAGS}" \
		config.c="$(tc-getCC)" \
		config.cc.coptions="${CFLAGS}" \
		config.cc.loptions="${LDFLAGS}" \
		config.bin.ar="$(tc-getAR)" \
		config.bin.ranlib="$(tc-getRANLIB)" \
		config.bin.lib=shared \
		config.install.root="${EPREFIX}"/usr \
		config.install.lib="${EPREFIX}"/usr/"$(get_libdir)" \
		config.install.doc="${EPREFIX}"/usr/share/doc/"${PF}" \
		libbutl/config.libbutl.system_libsqlite3=true \
		build2/config.build2.libpkgconf="$(usex libpkgconf true false)"
}

src_compile() {
	# build installable targets with shared libraries using the bootstrapped driver.
	# b-boot is still used deliberately: this mirrors upstream's bootstrap-unix flow
	# and avoids executing partly-installed tools.
	edo build2/b/b-boot -V -j "$(makeopts_jobs)" update-for-install: \
		build2/ bpkg/ bdep/ libbpkg/

	# optional standard build system modules shipped by this package.
	edo build2/b/b-boot -V -j "$(makeopts_jobs)" \
		update-for-install: libbuild2-{autoconf,kconfig}/

	# pre-build test targets during src_compile so src_test does not trigger unexpected relinks later.
	use test && edo build2/b/b-boot -V -j "$(makeopts_jobs)" \
		update-for-test: build2/ bpkg/ bdep/ libbpkg/
}

src_test() {
	# bdep discovers both ${S}/manifest and ${S}/bdep/manifest and reports
	# "multiple package manifests". Test the components that work correctly
	# in-tree; bdep needs an isolated copy to run.
	# Tests need an abosolute path to b-boot.
	edo "${S}"/build2/b/b-boot -V -j "$(makeopts_jobs)" test: build2/ bpkg/ libbpkg/
}

src_install() {
	# install from the configured top-level project. This is valid only after
	# src_configure; otherwise the top-level buildfile supports configure/dist only.
	edo build2/b/b-boot -V -j "$(makeopts_jobs)" \
		config.install.chroot="${ED}" \
		install: build2/ bpkg/ bdep/ libbpkg/

	# install optional build2 modules with project-local install scope,
	# as expected for libbuild2 module packages.
	edo build2/b/b-boot -V -j "$(makeopts_jobs)" \
		config.install.chroot="${ED}" \
		'!config.install.scope=project' \
		install:  libbuild2-{autoconf,kconfig}/

	edo mkdir -p "${ED}"/usr/share/doc/"${PF}"/html
	edo mv -f "${ED}"/usr/share/doc/"${PF}"/{*.xhtml,html}
}
