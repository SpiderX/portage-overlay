# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( {16..22} )

inherit cmake edo flag-o-matic llvm-r2

LICRYPTO_PV="0.1.1"
LUA_PV="5.5.1"
LUATO_COMMIT="df0c6f2d1cce2051b4711d36067619eda7933683"
RSTD_PV="0.1.5"
ZSTD_COMMIT="f8745da6ff1ad1e7bab384bd1f9d742439278e99"

DESCRIPTION="Module-first C++ build tool with manifest"
HOMEPAGE="https://github.com/litocpp/lito"
SRC_URI="https://github.com/litocpp/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/litocpp/licrypto/archive/v${LICRYPTO_PV}.tar.gz -> licrypto-${LICRYPTO_PV}.tar.gz
	https://github.com/litocpp/luato/archive/${LUATO_COMMIT}.tar.gz -> luato-${LUATO_COMMIT}.tar.gz
	https://github.com/litocpp/rstd/archive/v${RSTD_PV}.tar.gz -> rstd-${RSTD_PV}.tar.gz
	https://github.com/facebook/zstd/archive/${ZSTD_COMMIT}.tar.gz -> zstd-${ZSTD_COMMIT}.tar.gz
	https://www.lua.org/ftp/lua-${LUA_PV}.tar.gz"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# needs dev-lang/lua:5.5, wrt #968456
DEPEND="app-arch/zstd:0="
RDEPEND="${DEPEND}
	$(llvm_gen_dep 'llvm-core/clang:${LLVM_SLOT}
		llvm-core/lld:${LLVM_SLOT}
		llvm-core/llvm:${LLVM_SLOT}
		llvm-runtimes/libcxx')"
BDEPEND="virtual/pkgconfig"

PATCHES=( "${FILESDIR}/${PN}"-0.8.4-scan-execution-statistics.patch
	"${FILESDIR}/${PN}"-0.8.4-source-local.patch
	"${FILESDIR}/${PN}"-0.8.4-system-zstd-pkgconfig.patch
	"${FILESDIR}/${PN}"-0.8.4-tests-git-lock-checksum.patch
	"${FILESDIR}/${PN}"-0.8.4-tests-pmacro-provider.patch )

pkg_setup() {
	llvm-r2_pkg_setup

	export CC=clang
	export CXX=clang++
}

src_prepare() {
	# use Gentoo's selected LLVM toolchain in tests
	sed -i "s|/nix/opt/llvm/22|$(get_llvm_prefix)|g" \
		tests/src/support/build.cppm \
		tests/src/command/build.cpp || die

	cmake_src_prepare

	eapply --directory="${WORKDIR}/luato-${LUATO_COMMIT}" \
		"${FILESDIR}/${PN}"-0.8.4-source-luato-local-lua.patch

	# provide Portage-fetched sources for offline tests
	ln -s "${WORKDIR}/licrypto-${LICRYPTO_PV}" .licrypto || die
	ln -s "${WORKDIR}/luato-${LUATO_COMMIT}" .luato || die
	ln -s "${WORKDIR}/rstd-${RSTD_PV}" .rstd || die
	ln -s "${WORKDIR}/zstd-${ZSTD_COMMIT}" .zstd || die
}

src_configure() {
	append-cppflags -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=0

	local mycmakeargs=(
		-DLITO_USE_SYSTEM_ZSTD=ON
		-DFETCHCONTENT_SOURCE_DIR_LICRYPTO="${WORKDIR}/licrypto-${LICRYPTO_PV}"
		-DFETCHCONTENT_SOURCE_DIR_LUA="${WORKDIR}/lua-${LUA_PV}"
		-DFETCHCONTENT_SOURCE_DIR_LUATO="${WORKDIR}/luato-${LUATO_COMMIT}"
		-DFETCHCONTENT_SOURCE_DIR_RSTD="${WORKDIR}/rstd-${RSTD_PV}"
	)

	cmake_src_configure
}

src_test() {
	edo "${BUILD_DIR}"/cli/lito test --offline
}

src_install() {
	cmake_src_install

	edo rm -rf "${ED}"/usr/share/licenses/li{to,crypto}
}
