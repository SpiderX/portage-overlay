# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=7

CRATES="
addr2line-0.13.0
adler-0.2.3
aho-corasick-0.7.10
ansi_term-0.11.0
ascii-0.9.3
atty-0.2.14
autocfg-1.0.0
backtrace-0.3.50
bitflags-1.2.1
byteorder-1.3.4
cesu8-1.1.0
cfg-if-0.1.10
chrono-0.4.11
clap-2.33.1
colored-1.9.3
combine-3.8.1
dtoa-0.4.5
either-1.6.0
error-chain-0.12.4
gimli-0.22.0
hermit-abi-0.1.13
itoa-0.4.5
jni-0.14.0
jni-sys-0.3.0
lazy_static-1.4.0
libc-0.2.71
linked-hash-map-0.5.3
log-0.4.8
memchr-2.3.3
miniz_oxide-0.4.1
num-integer-0.1.43
num-traits-0.2.12
object-0.20.0
proc-macro2-1.0.18
quote-1.0.7
regex-1.3.9
regex-syntax-0.6.18
rustc-demangle-0.1.16
ryu-1.0.5
same-file-1.0.6
serde-1.0.111
serde_derive-1.0.111
serde_json-1.0.55
serde_yaml-0.8.13
simple_logger-1.6.0
strsim-0.8.0
syn-1.0.31
textwrap-0.11.0
thread_local-1.0.1
time-0.1.43
unicode-width-0.1.7
unicode-xid-0.2.0
unreachable-1.0.0
vec_map-0.8.2
version_check-0.9.2
void-1.0.2
walkdir-2.3.1
winapi-0.3.8
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
yaml-rust-0.4.4
"

inherit cargo

DESCRIPTION="AWS CloudFormation Guard"
HOMEPAGE="https://github.com/aws-cloudformation/cloudformation-guard"
SRC_URI="https://github.com/aws-cloudformation/cloudformation-guard/archive/v${PV//_/-}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0 BSL-1.1 MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

S="${WORKDIR}/cloudformation-guard-${PV//_/-}/${PN}"
