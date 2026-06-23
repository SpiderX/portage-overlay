# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=""
RUST_MIN_VER="1.91.1"

declare -A GIT_CRATES=(
	[crossterm]='https://github.com/nornagon/crossterm;87db8bfa6dc99427fd3b071681b07fc31c6ce995;crossterm-%commit%'
	[libwebrtc]='https://github.com/juberti-oai/rust-sdks;e2d1d1d230c6fc9df171ccb181423f957bb3c1f0;rust-sdks-%commit%/libwebrtc'
	[livekit-protocol]='https://github.com/juberti-oai/rust-sdks;e2d1d1d230c6fc9df171ccb181423f957bb3c1f0;rust-sdks-%commit%/livekit-protocol'
	[livekit-runtime]='https://github.com/juberti-oai/rust-sdks;e2d1d1d230c6fc9df171ccb181423f957bb3c1f0;rust-sdks-%commit%/livekit-runtime'
	[nucleo-matcher]='https://github.com/helix-editor/nucleo;4253de9faabb4e5c6d81d946a5e35a90f87347ee;nucleo-%commit%/matcher'
	[nucleo]='https://github.com/helix-editor/nucleo;4253de9faabb4e5c6d81d946a5e35a90f87347ee;nucleo-%commit%'
	[ratatui]='https://github.com/nornagon/ratatui;9b2ad1298408c45918ee9f8241a6f95498cdbed2;ratatui-%commit%'
	[runfiles]='https://github.com/dzbarsky/rules_rust;b56cbaa8465e74127f1ea216f813cd377295ad81;rules_rust-%commit%/rust/runfiles'
	[tokio-tungstenite]='https://github.com/openai-oss-forks/tokio-tungstenite;132f5b39c862e3a970f731d709608b3e6276d5f6;tokio-tungstenite-%commit%'
	[tungstenite]='https://github.com/openai-oss-forks/tungstenite-rs;9200079d3b54a1ff51072e24d81fd354f085156f;tungstenite-rs-%commit%'
	[webrtc-sys-build]='https://github.com/juberti-oai/rust-sdks;e2d1d1d230c6fc9df171ccb181423f957bb3c1f0;rust-sdks-%commit%/webrtc-sys/build'
	[webrtc-sys]='https://github.com/juberti-oai/rust-sdks;e2d1d1d230c6fc9df171ccb181423f957bb3c1f0;rust-sdks-%commit%/webrtc-sys'
)

inherit cargo edo shell-completion

RUSTY_V8_PV="147.4.0"

DESCRIPTION="Lightweight coding agent that runs in your terminal"
HOMEPAGE="https://github.com/openai/codex"
SRC_URI="https://github.com/openai/${PN}/archive/rust-v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-crates.tar.xz
	https://github.com/denoland/rusty_v8/releases/download/v${RUSTY_V8_PV}/librusty_v8_release_x86_64-unknown-linux-gnu.a.gz
	${CARGO_CRATE_URIS}"
S="${WORKDIR}/${PN}-rust-v${PV}"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD Boost-1.0
	CC0-1.0 CDLA-Permissive-2.0 ISC MIT MPL-2.0 Unicode-3.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="tui"

RDEPEND="sys-apps/bubblewrap"

src_prepare() {
	default

	sed -i  -e "/crossterm =/s|git = \"https://github.com/nornagon/crossterm\", rev = \"|path = \"${WORKDIR}/crossterm-|" \
		-e "/ratatui =/s|git = \"https://github.com/nornagon/ratatui\", rev = \"|path = \"${WORKDIR}/ratatui-|" \
		-e "/tokio-tungstenite =/s|git = \"https://github.com/openai-oss-forks/tokio-tungstenite\", rev = \"|path = \"${WORKDIR}/tokio-tungstenite-|" \
		-e "/tungstenite =/s|git = \"https://github.com/openai-oss-forks/tungstenite-rs\", rev = \"|path = \"${WORKDIR}/tungstenite-rs-|g" \
		codex-rs/Cargo.toml || die "sed failed for Cargo.toml"
}

src_compile() {
	export RUSTY_V8_ARCHIVE="${DISTDIR}"/librusty_v8_release_x86_64-unknown-linux-gnu.a.gz
	cargo_src_compile --manifest-path codex-rs/cli/Cargo.toml
	use tui && cargo_src_compile --manifest-path codex-rs/tui/Cargo.toml --bin codex-tui

	local completion
	for completion in bash fish zsh ; do
		edo codex-rs/target/release/codex completion ${completion} > codex.${completion}
	done
}

src_test() {
	local CARGO_SKIP_TESTS=( sandbox_with_network_proxy_blocks_direct_loopback_access )

	# codex-tui doesn't have tests
	cargo_src_test --manifest-path codex-rs/cli/Cargo.toml
}

src_install() {
	einstalldocs
	cargo_src_install --path codex-rs/cli
	use tui && cargo_src_install --path codex-rs/tui --bin codex-tui

	newbashcomp codex.bash codex
	newfishcomp codex.fish codex
	newzshcomp codex.zsh _codex
}
