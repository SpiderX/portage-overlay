# Copyright 2017-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=7

EGIT_REPO_URI="https://github.com/cardoe/${PN}.git"
CRATES="
advapi32-sys-0.2.0
aho-corasick-0.6.3
ansi_term-0.11.0
atty-0.2.3
backtrace-0.3.3
backtrace-sys-0.1.16
bitflags-0.7.0
bitflags-0.8.2
bitflags-1.0.3
cargo-0.21.1
cc-1.0.3
cfg-if-0.1.0
clap-2.32.0
cmake-0.1.22
crates-io-0.10.0
crossbeam-0.2.10
curl-0.4.6
curl-sys-0.3.10
dbghelp-sys-0.2.0
docopt-0.8.1
dtoa-0.4.2
env_logger-0.4.3
error-chain-0.11.0
filetime-0.1.10
flate2-0.2.19
foreign-types-0.2.0
fs2-0.4.2
gcc-0.3.45
gdi32-sys-0.2.0
git2-0.6.4
git2-curl-0.7.0
glob-0.2.11
hex-0.2.0
idna-0.1.1
itoa-0.3.4
jobserver-0.1.8
kernel32-sys-0.2.2
lazy_static-0.2.8
libc-0.2.21
libgit2-sys-0.6.7
libssh2-sys-0.2.5
libz-sys-1.0.13
log-0.3.7
matches-0.1.4
memchr-1.0.2
miniz-sys-0.1.9
miow-0.2.1
net2-0.2.27
num-traits-0.1.40
num_cpus-1.3.0
openssl-0.9.11
openssl-probe-0.1.1
openssl-sys-0.9.11
pkg-config-0.3.9
proc-macro2-0.4.6
psapi-sys-0.1.0
quote-0.3.15
quote-0.6.3
rand-0.3.15
redox_syscall-0.1.17
redox_termios-0.1.1
regex-0.2.2
regex-syntax-0.4.1
rustc-demangle-0.1.5
scoped-tls-0.1.0
semver-0.7.0
semver-parser-0.7.0
serde-1.0.16
serde_derive-1.0.16
serde_derive_internals-0.16.0
serde_ignored-0.0.3
serde_json-1.0.5
shell-escape-0.1.3
strsim-0.6.0
strsim-0.7.0
structopt-0.2.10
structopt-derive-0.2.10
syn-0.11.11
syn-0.14.2
synom-0.11.3
tar-0.4.11
tempdir-0.3.5
termcolor-0.3.3
termion-1.5.1
textwrap-0.10.0
thread_local-0.3.4
time-0.1.36
toml-0.4.5
unicode-bidi-0.2.5
unicode-normalization-0.1.4
unicode-width-0.1.5
unicode-xid-0.0.4
unicode-xid-0.1.0
unreachable-1.0.0
url-1.4.0
user32-sys-0.2.0
utf8-ranges-1.0.0
vec_map-0.8.1
void-1.0.2
winapi-0.2.8
winapi-0.3.5
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
wincolor-0.1.4
ws2_32-sys-0.2.1"

inherit cargo git-r3

DESCRIPTION="Generates an ebuild for a package using the in-tree eclasses"
HOMEPAGE="https://github.com/cardoe/cargo-ebuild"
SRC_URI="$(cargo_crate_uris ${CRATES})"

LICENSE="MIT"
KEYWORDS=""
SLOT="0"
IUSE="libressl"
RESTRICT="mirror"

DEPEND="net-libs/http-parser:0=
	net-libs/libssh2:0=
	net-misc/curl:0=
	sys-libs/zlib:0=
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )"
RDEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack
	cargo_src_unpack
}
