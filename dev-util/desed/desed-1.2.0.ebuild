# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=7

CRATES="
ansi_term-0.11.0
anyhow-1.0.37
atty-0.2.14
bitflags-1.2.1
bytes-0.5.6
cassowary-0.3.0
cfg-if-0.1.10
cfg-if-1.0.0
clap-2.33.3
cloudabi-0.0.3
crossterm-0.17.7
crossterm_winapi-0.6.2
either-1.6.1
fuchsia-zircon-0.3.3
fuchsia-zircon-sys-0.3.3
futures-core-0.3.8
hermit-abi-0.1.17
inotify-0.8.3
inotify-sys-0.1.4
iovec-0.1.4
itertools-0.9.0
kernel32-sys-0.2.2
kqueue-1.0.2
kqueue-sys-1.0.2
lazy_static-1.4.0
libc-0.2.81
lock_api-0.3.4
log-0.4.11
mio-0.6.23
mio-0.7.7
miow-0.2.2
miow-0.3.6
net2-0.2.37
ntapi-0.3.6
parking_lot-0.10.2
parking_lot_core-0.7.2
pin-project-lite-0.1.11
redox_syscall-0.1.57
scopeguard-1.1.0
signal-hook-0.1.17
signal-hook-registry-1.3.0
slab-0.4.2
smallvec-1.6.0
socket2-0.3.19
strsim-0.8.0
textwrap-0.11.0
tokio-0.2.24
tui-0.9.5
unicode-segmentation-1.7.1
unicode-width-0.1.8
vec_map-0.8.2
winapi-0.2.8
winapi-0.3.9
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
ws2_32-sys-0.2.1
"

inherit cargo

DESCRIPTION="Debugger for Sed"
HOMEPAGE="https://github.com/SoptikHa2/desed"
SRC_URI="https://github.com/SoptikHa2/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"

src_install() {
	einstalldocs
	cargo_src_install
}
