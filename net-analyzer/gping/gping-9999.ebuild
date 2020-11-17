# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=7

EGIT_REPO_URI="https://github.com/orf/${PN}.git"
CRATES="
aho-corasick-0.7.15
ansi_term-0.11.0
anyhow-1.0.34
atty-0.2.14
bitflags-1.2.1
cassowary-0.3.0
cfg-if-0.1.10
cfg-if-1.0.0
clap-2.33.3
cloudabi-0.0.3
crossterm-0.17.7
crossterm_winapi-0.6.2
dns-lookup-1.0.5
heck-0.3.1
hermit-abi-0.1.17
histogram-0.6.9
lazy_static-1.4.0
libc-0.2.80
lock_api-0.3.4
log-0.4.11
memchr-2.3.4
mio-0.7.6
miow-0.3.6
ntapi-0.3.6
os_info-3.0.1
parking_lot-0.10.2
parking_lot_core-0.7.2
pinger-0.1.8
proc-macro-error-1.0.4
proc-macro-error-attr-1.0.4
proc-macro2-1.0.24
quote-1.0.7
redox_syscall-0.1.57
regex-1.4.2
regex-syntax-0.6.21
scopeguard-1.1.0
signal-hook-0.1.16
signal-hook-registry-1.2.2
smallvec-1.4.2
socket2-0.3.16
static_assertions-1.1.0
strsim-0.8.0
structopt-0.3.20
structopt-derive-0.4.13
syn-1.0.48
textwrap-0.11.0
thiserror-1.0.22
thiserror-impl-1.0.22
thread_local-1.0.1
tui-0.12.0
unicode-segmentation-1.7.0
unicode-width-0.1.8
unicode-xid-0.2.1
vec_map-0.8.2
version_check-0.9.2
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
winapi_forked_icmpapi-0.3.7
winping-0.10.1
"

inherit cargo git-r3

DESCRIPTION="Ping, but with a graph"
HOMEPAGE="https://github.com/orf/gping/releases"
SRC_URI="$(cargo_crate_uris ${CRATES})"

LICENSE="MIT"
KEYWORDS=""
SLOT="0"
IUSE=""

src_unpack() {
	git-r3_src_unpack
	cargo_src_unpack
}
