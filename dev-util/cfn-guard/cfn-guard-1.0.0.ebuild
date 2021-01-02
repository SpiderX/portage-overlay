# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=7

CRATES="
addr2line-0.13.0
adler-0.2.3
aho-corasick-0.7.13
ansi_term-0.11.0
ascii-0.9.3
atty-0.2.14
autocfg-1.0.1
backtrace-0.3.50
bitflags-1.2.1
byteorder-1.3.4
bytes-0.4.12
cesu8-1.1.0
cfg-if-0.1.10
chrono-0.4.15
clap-2.33.3
cloudabi-0.0.3
colored-1.9.3
combine-3.8.1
crossbeam-deque-0.7.3
crossbeam-epoch-0.8.2
crossbeam-queue-0.2.3
crossbeam-utils-0.7.2
dtoa-0.4.6
either-1.6.1
error-chain-0.12.4
failure-0.1.8
failure_derive-0.1.8
fnv-1.0.7
fuchsia-zircon-0.3.3
fuchsia-zircon-sys-0.3.3
futures-0.1.29
futures-cpupool-0.1.8
gimli-0.22.0
h2-0.1.26
hashbrown-0.9.0
hermit-abi-0.1.15
http-0.1.21
http-body-0.1.0
httparse-1.3.4
hyper-0.12.35
indexmap-1.6.0
iovec-0.1.4
itoa-0.4.6
jni-0.14.0
jni-sys-0.3.0
kernel32-sys-0.2.2
lambda_runtime-0.2.1
lambda_runtime_client-0.2.2
lambda_runtime_core-0.1.2
lambda_runtime_errors-0.1.1
lambda_runtime_errors_derive-0.1.1
lazy_static-1.4.0
libc-0.2.77
linked-hash-map-0.5.3
lock_api-0.3.4
log-0.4.11
maybe-uninit-2.0.0
memchr-2.3.3
memoffset-0.5.6
miniz_oxide-0.4.2
mio-0.6.22
mio-uds-0.6.8
miow-0.2.1
net2-0.2.35
num-integer-0.1.43
num-traits-0.2.12
num_cpus-1.13.0
object-0.20.0
parking_lot-0.9.0
parking_lot_core-0.6.2
proc-macro2-0.4.30
proc-macro2-1.0.21
quote-0.6.13
quote-1.0.7
redox_syscall-0.1.57
regex-1.3.9
regex-syntax-0.6.18
rustc-demangle-0.1.16
rustc_version-0.2.3
ryu-1.0.5
same-file-1.0.6
scopeguard-1.1.0
semver-0.9.0
semver-parser-0.7.0
serde-1.0.116
serde_derive-1.0.116
serde_json-1.0.57
serde_yaml-0.8.13
simple-error-0.2.2
simple_logger-1.9.0
slab-0.4.2
smallvec-0.6.13
string-0.2.1
strsim-0.8.0
syn-0.15.44
syn-1.0.41
synstructure-0.10.2
synstructure-0.12.4
textwrap-0.11.0
thread_local-1.0.1
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
unicode-width-0.1.8
unicode-xid-0.1.0
unicode-xid-0.2.1
unreachable-1.0.0
vec_map-0.8.2
version_check-0.9.2
void-1.0.2
walkdir-2.3.1
want-0.2.0
wasi-0.10.0+wasi-snapshot-preview1
winapi-0.2.8
winapi-0.3.9
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
ws2_32-sys-0.2.1
yaml-rust-0.4.4
"

inherit cargo

DESCRIPTION="AWS CloudFormation Guard"
HOMEPAGE="https://github.com/aws-cloudformation/cloudformation-guard"
SRC_URI="https://github.com/aws-cloudformation/cloudformation-guard/archive/${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0 BSL-1.1 MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

S="${WORKDIR}/cloudformation-guard-${PV}/${PN}"
