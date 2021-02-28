# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=7

CRATES="
adler-0.2.3
aho-corasick-0.7.15
anyhow-1.0.38
argh-0.1.4
argh_derive-0.1.4
argh_shared-0.1.4
arrayvec-0.4.12
autocfg-1.0.1
bet-0.4.0
bitflags-1.2.1
cfg-if-0.1.10
cfg-if-1.0.0
chrono-0.4.19
cli-log-1.1.0
const_fn-0.4.5
crc32fast-1.2.1
crossbeam-0.8.0
crossbeam-channel-0.5.0
crossbeam-deque-0.8.0
crossbeam-epoch-0.9.1
crossbeam-queue-0.3.1
crossbeam-utils-0.8.1
crossterm-0.19.0
crossterm_winapi-0.7.0
either-1.6.1
file-size-1.0.3
flate2-1.0.19
have-0.1.1
heck-0.3.2
instant-0.1.9
itertools-0.10.0
itoa-0.4.7
lazy-regex-0.1.4
lazy_static-1.4.0
libc-0.2.82
lock_api-0.4.2
log-0.4.13
memchr-2.3.4
memoffset-0.6.1
minimad-0.7.0
miniz_oxide-0.4.3
mio-0.7.7
miow-0.3.6
nodrop-0.1.14
ntapi-0.3.6
num-format-0.4.0
num-integer-0.1.44
num-traits-0.2.14
once_cell-1.5.2
parking_lot-0.11.1
parking_lot_core-0.8.3
proc-macro2-1.0.24
quote-1.0.8
redox_syscall-0.2.5
regex-1.4.3
regex-syntax-0.6.22
rhit-1.3.2
scopeguard-1.1.0
signal-hook-0.1.17
signal-hook-registry-1.3.0
smallvec-1.6.1
socket2-0.3.19
syn-1.0.58
termimad-0.10.0
thiserror-1.0.23
thiserror-impl-1.0.23
thread_local-1.1.2
time-0.1.44
unicode-segmentation-1.7.1
unicode-width-0.1.8
unicode-xid-0.2.1
wasi-0.10.0+wasi-snapshot-preview1
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo

DESCRIPTION="A nginx log explorer"
HOMEPAGE="https://github.com/Canop/rhit"
SRC_URI="$(cargo_crate_uris ${CRATES})"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"

DOCS=( {CHANGELOG,README}.md )

QA_FLAGS_IGNORED="usr/bin/rhit"

src_install() {
	einstalldocs
	cargo_src_install
}
