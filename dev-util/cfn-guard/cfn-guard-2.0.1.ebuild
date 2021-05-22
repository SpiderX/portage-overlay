# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=7

CRATES="
addr2line-0.15.1
adler-1.0.2
aho-corasick-0.7.18
ansi_term-0.11.0
arrayvec-0.5.2
atty-0.2.14
autocfg-1.0.1
backtrace-0.3.59
bitflags-1.2.1
bytecount-0.6.2
byteorder-1.4.3
bytes-0.4.12
cc-1.0.67
cfg-if-0.1.10
cfg-if-1.0.0
chrono-0.4.19
clap-2.33.3
cloudabi-0.0.3
colored-1.9.3
colored-2.0.0
crossbeam-deque-0.7.3
crossbeam-epoch-0.8.2
crossbeam-queue-0.2.3
crossbeam-utils-0.7.2
dtoa-0.4.8
either-1.6.1
failure-0.1.8
failure_derive-0.1.8
fnv-1.0.7
fuchsia-zircon-0.3.3
fuchsia-zircon-sys-0.3.3
futures-0.1.31
futures-cpupool-0.1.8
gimli-0.24.0
h2-0.1.26
hashbrown-0.9.1
heck-0.3.2
hermit-abi-0.1.18
http-0.1.21
http-body-0.1.0
httparse-1.4.1
hyper-0.12.36
indexmap-1.6.2
iovec-0.1.4
itertools-0.4.19
itoa-0.4.7
kernel32-sys-0.2.2
lambda_runtime-0.2.1
lambda_runtime_client-0.2.2
lambda_runtime_core-0.1.2
lambda_runtime_errors-0.1.1
lambda_runtime_errors_derive-0.1.1
lazy_static-1.4.0
lexical-core-0.7.6
libc-0.2.94
linked-hash-map-0.5.4
lock_api-0.3.4
log-0.4.14
maybe-uninit-2.0.0
memchr-2.4.0
memoffset-0.5.6
miniz_oxide-0.4.4
mio-0.6.23
mio-uds-0.6.8
miow-0.2.2
net2-0.2.37
nom-5.1.2
nom_locate-2.1.0
num-integer-0.1.44
num-traits-0.2.14
num_cpus-1.13.0
object-0.24.0
parking_lot-0.9.0
parking_lot_core-0.6.2
proc-macro2-0.4.30
proc-macro2-1.0.26
quote-0.6.13
quote-1.0.9
redox_syscall-0.1.57
regex-1.5.4
regex-syntax-0.6.25
rustc-demangle-0.1.19
rustc_version-0.2.3
ryu-1.0.5
same-file-1.0.6
scopeguard-1.1.0
semver-0.9.0
semver-parser-0.7.0
serde-1.0.126
serde_derive-1.0.126
serde_json-1.0.64
serde_yaml-0.8.17
simple-error-0.2.3
simple_logger-1.11.0
slab-0.4.3
smallvec-0.6.14
static_assertions-1.1.0
string-0.2.1
string-builder-0.2.0
strsim-0.8.0
syn-0.15.44
syn-1.0.72
synstructure-0.10.2
synstructure-0.12.4
textwrap-0.11.0
time-0.1.44
tokio-0.1.22
tokio-buf-0.1.1
tokio-codec-0.1.2
tokio-current-thread-0.1.7
tokio-executor-0.1.10
tokio-fs-0.1.7
tokio-io-0.1.13
tokio-reactor-0.1.12
tokio-sync-0.1.8
tokio-tcp-0.1.4
tokio-threadpool-0.1.18
tokio-timer-0.2.13
tokio-udp-0.1.6
tokio-uds-0.2.7
try-lock-0.2.3
unicode-segmentation-1.7.1
unicode-width-0.1.8
unicode-xid-0.1.0
unicode-xid-0.2.2
vec_map-0.8.2
version_check-0.9.3
walkdir-2.3.2
want-0.2.0
wasi-0.10.0+wasi-snapshot-preview1
winapi-0.2.8
winapi-0.3.9
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
ws2_32-sys-0.2.1
yaml-rust-0.4.5
"

inherit cargo

DESCRIPTION="AWS CloudFormation Guard"
HOMEPAGE="https://github.com/aws-cloudformation/cloudformation-guard"
SRC_URI="https://github.com/aws-cloudformation/cloudformation-guard/archive/${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0 BSL-1.1 MIT MPL-2.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

S="${WORKDIR}/cloudformation-guard-${PV}/guard"

QA_FLAGS_IGNORED="usr/bin/cfn-guard"
