# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=""
RUST_MIN_VER="1.95.0"

declare -A GIT_CRATES=(
	[appcontainer_common]='https://github.com/microsoft/mxc;6cd3d58f05d3447e67109cfb75e042803b843ca4;mxc-%commit%/src/backends/appcontainer/common'
	[crossterm]='https://github.com/openai-oss-forks/crossterm;45fecb9508105988f42fe6ff0441783ed3717f92;crossterm-%commit%'
	[learning_mode_core]='https://github.com/microsoft/mxc;6cd3d58f05d3447e67109cfb75e042803b843ca4;mxc-%commit%/src/core/learning_mode_core'
	[learning_mode_windows]='https://github.com/microsoft/mxc;6cd3d58f05d3447e67109cfb75e042803b843ca4;mxc-%commit%/src/backends/learning_mode/windows'
	[mxc_config_contract]='https://github.com/microsoft/mxc;6cd3d58f05d3447e67109cfb75e042803b843ca4;mxc-%commit%/src/core/mxc_config_contract'
	[mxc_telemetry]='https://github.com/microsoft/mxc;6cd3d58f05d3447e67109cfb75e042803b843ca4;mxc-%commit%/src/mxc_telemetry'
	[nucleo-matcher]='https://github.com/helix-editor/nucleo;4253de9faabb4e5c6d81d946a5e35a90f87347ee;nucleo-%commit%/matcher'
	[nucleo]='https://github.com/helix-editor/nucleo;4253de9faabb4e5c6d81d946a5e35a90f87347ee;nucleo-%commit%'
	[process_security_environment_spec]='https://github.com/microsoft/mxc;6cd3d58f05d3447e67109cfb75e042803b843ca4;mxc-%commit%/src/core/generated/process_security_environment_specification'
	[runfiles]='https://github.com/dzbarsky/rules_rust;b56cbaa8465e74127f1ea216f813cd377295ad81;rules_rust-%commit%/rust/runfiles'
	[sandbox_spec]='https://github.com/microsoft/mxc;6cd3d58f05d3447e67109cfb75e042803b843ca4;mxc-%commit%/src/core/generated/base_container_specification'
	[tokio-tungstenite]='https://github.com/openai-oss-forks/tokio-tungstenite;0e5b2d73aa18dd9f0a50ee9ff199d5aef7594186;tokio-tungstenite-%commit%'
	[tungstenite]='https://github.com/openai-oss-forks/tungstenite-rs;4fffad30fe373adbdcffab9545e9e9bf4f2fc19f;tungstenite-rs-%commit%'
	[wxc_common]='https://github.com/microsoft/mxc;6cd3d58f05d3447e67109cfb75e042803b843ca4;mxc-%commit%/src/core/wxc_common'
)

inherit cargo check-reqs edo toolchain-funcs shell-completion

CHECKREQS_MEMORY="12G"
CHECKREQS_DISK_BUILD="10G"
RUSTY_V8_PV="150.4.0"

DESCRIPTION="Lightweight coding agent that runs in your terminal"
HOMEPAGE="https://github.com/openai/codex"
SRC_URI="https://github.com/openai/${PN}/archive/rust-v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-crates.tar.xz
	amd64? ( https://github.com/openai/${PN}/releases/download/rusty-v8-v${RUSTY_V8_PV}/librusty_v8_ptrcomp_sandbox_release_x86_64-unknown-linux-gnu.a.gz
			-> librusty_v8_${RUSTY_V8_PV}_x86_64-unknown-linux-gnu.a.gz
		https://github.com/openai/${PN}/releases/download/rusty-v8-v${RUSTY_V8_PV}/src_binding_ptrcomp_sandbox_release_x86_64-unknown-linux-gnu.rs
			-> src_binding_${RUSTY_V8_PV}_x86_64-unknown-linux-gnu.rs )
	arm64? ( https://github.com/openai/${PN}/releases/download/rusty-v8-v${RUSTY_V8_PV}/librusty_v8_ptrcomp_sandbox_release_aarch64-unknown-linux-gnu.a.gz
			-> librusty_v8_${RUSTY_V8_PV}_aarch64-unknown-linux-gnu.a.gz
		https://github.com/openai/codex/releases/download/rusty-v8-v150.4.0/src_binding_ptrcomp_sandbox_release_aarch64-unknown-linux-gnu.rs
			-> src_binding_${RUSTY_V8_PV}_aarch64-unknown-linux-gnu.rs )
	${CARGO_CRATE_URIS}"
S="${WORKDIR}/${PN}-rust-v${PV}/${PN}-rs"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD Boost-1.0 CC0-1.0 CDLA-Permissive-2.0 ISC MIT MPL-2.0 Unicode-3.0 ZLIB"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

DEPEND="app-arch/xz-utils:=
	dev-libs/openssl:0=
	virtual/zlib:0="
RDEPEND="${DEPEND}
	sys-apps/bubblewrap
	sys-apps/ripgrep"
BDEPEND="virtual/pkgconfig"

pkg_setup() {
	check-reqs_pkg_setup
	rust_pkg_setup
}

src_prepare() {
	default

	for dep in 'crossterm:openai-oss-forks/crossterm' \
		'tokio-tungstenite:openai-oss-forks/tokio-tungstenite' \
		'tungstenite:openai-oss-forks/tungstenite-rs'
	do
		sed -i -e "/${dep%%:*} =/s|git = \"https://github.com/${dep#*:}\", rev = \"|path = \"${WORKDIR}/${dep##*/}-|" \
			Cargo.toml || die "sed failed for Cargo.toml"
	done
}

src_compile() {
	local arch=x86_64
	use arm64 && arch=aarch64

	tc-is-lto || export CARGO_PROFILE_RELEASE_LTO=false
	export RUSTY_V8_ARCHIVE="${DISTDIR}"/librusty_v8_"${RUSTY_V8_PV}_${arch}"-unknown-linux-gnu.a.gz \
		RUSTY_V8_SRC_BINDING_PATH="${DISTDIR}"/src_binding_"${RUSTY_V8_PV}_${arch}"-unknown-linux-gnu.rs
	cargo_src_compile --package codex-cli --package codex-code-mode-host

	local completion
	for completion in bash fish zsh ; do
		edo target/release/codex completion ${completion} > codex.${completion}
	done
}

src_test() {
	local skip=(
		# require working bubblewrap user namespaces; fails under portage sandbox
		sandbox_fetches_and_enforces_cloud_managed_permission_profile
		sandbox_with_network_proxy_allows_explicit_loopback_access
		sandbox_with_network_proxy_blocks_direct_loopback_access )

	# run tests in debug mode, as upstream expects; release mode rejects temporary CODEX_HOME paths used by tests.
	cargo_env "${CARGO}" test "${ECARGO_ARGS[@]}" --package codex-cli -- "${skip[@]/#/--skip=}" || die "cargo test failed"
}

src_install() {
	einstalldocs
	dobin "$(cargo_target_dir)"/codex{,-code-mode-host}

	newbashcomp codex.bash codex
	newfishcomp codex.fish codex
	newzshcomp codex.zsh _codex
}
