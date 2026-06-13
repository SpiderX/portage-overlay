# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_IN_SOURCE_BUILD=1
CRATES=""
RUST_MIN_VER="1.93.0"

inherit cargo cmake edo git-r3 shell-completion

DESCRIPTION="A lightweight WebAssembly runtime"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime"
EGIT_REPO_URI="https://github.com/bytecodealliance/${PN}.git"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD CC0-1.0
	CDLA-Permissive-2.0 ISC MIT MPL-2.0 UoI-NCSA Unicode-3.0 ZLIB"
SLOT="0"
IUSE="cxx llvm_targets_WebAssembly rust_sysroots_wasm test"
REQUIRED_USE="test? ( llvm_targets_WebAssembly rust_sysroots_wasm )"
RESTRICT="!test? ( test )"

DEPEND="llvm_targets_WebAssembly? ( >=dev-lang/rust-${RUST_MIN_VER}[llvm_targets_WebAssembly,rust_sysroots_wasm?] )"
RDEPEND="${DEPEND}"
BDEPEND="test? ( dev-cpp/gtest )"

PATCHES=( "${FILESDIR}/${PN}"-45.0.1-test-cmake.patch )

DOCS=( "${S}"/{README,RELEASES}.md )
CMAKE_USE_DIR="${S}/crates/c-api"
BUILD_DIR="${S}/crates/c-api"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_prepare() {
	# run it unconditionally to avoid double patching
	cmake_src_prepare
}

src_configure() {
	if use cxx ; then
		local mycmakeargs=(
			-DCMAKE_CXX_STANDARD=20
		)
		cmake_src_configure
		if use test ; then
			local mycmakeargs=(
				-DBUILD_TESTS=ON
			)
			CMAKE_USE_DIR="${S}"/examples BUILD_DIR="${S}"/examples/build \
				cmake_src_configure
		fi
	fi

	cargo_src_configure
}

src_compile() {
	cargo_src_compile

	if use cxx ; then
		for ldflag in ${LDFLAGS} ; do RUSTFLAGS+=" -C link-arg=${ldflag}" ; done
		export RUSTFLAGS="${RUSTFLAGS} -C link-arg=-Wl,-soname,libwasmtime.so.${PV%%.*}"
		cmake_src_compile
		if use test ; then
			CMAKE_USE_DIR="${S}"/examples BUILD_DIR="${S}"/examples/build \
				cmake_src_compile
		fi
	fi

	local completion
	for completion in bash fish zsh ; do
		edo target/release/wasmtime completion ${completion} > wasmtime.${completion}
	done
}

src_test() {
	use cxx && CMAKE_USE_DIR="${S}/examples" \
		BUILD_DIR="${S}/examples/build" cmake_src_test

	cargo_src_test
}

src_install() {
	einstalldocs
	cargo_src_install
	if use cxx ; then
		cmake_src_install
		edo mv "${ED}"/usr/"$(get_libdir)"/libwasmtime.so{,."${PV%%.*}"}
		dosym libwasmtime.so."${PV%%.*}" usr/"$(get_libdir)"/libwasmtime.so
	fi

	newbashcomp wasmtime.bash wasmtime
	newfishcomp wasmtime.fish wasmtime
	newzshcomp wasmtime.zsh _wasmtime
}
