# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=7

CRATES="
aho-corasick-0.7.10
ansi_term-0.11.0
arc-swap-0.4.4
arrayref-0.3.6
arrayvec-0.5.1
async-trait-0.1.24
atty-0.2.14
autocfg-1.0.0
base64-0.11.0
bitflags-1.2.1
blake2b_simd-0.5.10
block-buffer-0.7.3
block-padding-0.1.5
bumpalo-3.2.0
byte-tools-0.3.1
byteorder-1.3.4
bytes-0.5.4
cc-1.0.50
cfg-if-0.1.10
chrono-0.4.11
clap-2.33.0
constant_time_eq-0.1.5
core-foundation-0.7.0
core-foundation-sys-0.7.0
crossbeam-utils-0.7.2
crypto-mac-0.7.0
digest-0.8.1
dirs-1.0.5
dtoa-0.4.5
encoding_rs-0.8.22
fake-simd-0.1.2
fern-0.6.0
fnv-1.0.6
foreign-types-0.3.2
foreign-types-shared-0.1.1
fuchsia-zircon-0.3.3
fuchsia-zircon-sys-0.3.3
futures-0.3.4
futures-channel-0.3.4
futures-core-0.3.4
futures-executor-0.3.4
futures-io-0.3.4
futures-macro-0.3.4
futures-sink-0.3.4
futures-task-0.3.4
futures-util-0.3.4
generic-array-0.12.3
getrandom-0.1.14
h2-0.2.2
heck-0.3.1
hermit-abi-0.1.8
hex-0.4.2
hmac-0.7.1
http-0.2.0
http-body-0.3.1
httparse-1.3.4
hyper-0.13.3
hyper-tls-0.4.1
idna-0.2.0
indexmap-1.3.2
iovec-0.1.4
itoa-0.4.5
js-sys-0.3.36
kernel32-sys-0.2.2
lazy_static-1.4.0
libc-0.2.67
log-0.4.8
matches-0.1.8
md5-0.7.0
memchr-2.3.3
mime-0.3.16
mime_guess-2.0.3
mio-0.6.21
mio-named-pipes-0.1.6
mio-uds-0.6.7
miow-0.2.1
miow-0.3.3
native-tls-0.2.4
net2-0.2.33
num-integer-0.1.42
num-traits-0.2.11
opaque-debug-0.2.3
openssl-0.10.28
openssl-probe-0.1.2
openssl-sys-0.9.54
percent-encoding-2.1.0
pin-project-0.4.8
pin-project-internal-0.4.8
pin-project-lite-0.1.4
pin-utils-0.1.0-alpha.4
pkg-config-0.3.17
ppv-lite86-0.2.6
proc-macro-error-0.4.11
proc-macro-error-attr-0.4.11
proc-macro-hack-0.5.11
proc-macro-nested-0.1.3
proc-macro2-1.0.9
quote-1.0.3
r53ddns-1.0.0
rand-0.7.3
rand_chacha-0.2.2
rand_core-0.5.1
rand_hc-0.2.0
redox_syscall-0.1.56
redox_users-0.3.4
regex-1.3.4
regex-syntax-0.6.16
remove_dir_all-0.5.2
reqwest-0.10.4
rusoto_core-0.43.0-beta.1
rusoto_credential-0.43.0-beta.1
rusoto_route53-0.43.0-beta.1
rusoto_signature-0.43.0-beta.1
rust-argon2-0.7.0
rustc_version-0.2.3
rustversion-1.0.2
ryu-1.0.2
schannel-0.1.17
security-framework-0.4.1
security-framework-sys-0.4.1
semver-0.9.0
semver-parser-0.7.0
serde-1.0.104
serde_derive-1.0.104
serde_json-1.0.48
serde_urlencoded-0.6.1
sha2-0.8.1
shlex-0.1.1
signal-hook-registry-1.2.0
slab-0.4.2
smallvec-1.2.0
socket2-0.3.11
strsim-0.8.0
structopt-0.3.11
structopt-derive-0.4.4
subtle-1.0.0
syn-1.0.16
syn-mid-0.5.0
tempfile-3.1.0
textwrap-0.11.0
thread_local-1.0.1
time-0.1.42
time-0.2.7
time-macros-0.1.0
time-macros-impl-0.1.0
tokio-0.2.13
tokio-macros-0.2.5
tokio-tls-0.3.0
tokio-util-0.2.0
tower-service-0.3.0
try-lock-0.2.2
typenum-1.11.2
unicase-2.6.0
unicode-bidi-0.3.4
unicode-normalization-0.1.12
unicode-segmentation-1.6.0
unicode-width-0.1.7
unicode-xid-0.2.0
url-2.1.1
vcpkg-0.2.8
vec_map-0.8.1
version_check-0.9.1
want-0.3.0
wasi-0.9.0+wasi-snapshot-preview1
wasm-bindgen-0.2.59
wasm-bindgen-backend-0.2.59
wasm-bindgen-futures-0.4.9
wasm-bindgen-macro-0.2.59
wasm-bindgen-macro-support-0.2.59
wasm-bindgen-shared-0.2.59
web-sys-0.3.36
winapi-0.2.8
winapi-0.3.8
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
winreg-0.6.2
ws2_32-sys-0.2.1
xml-rs-0.8.0
zeroize-1.1.0
"

inherit cargo systemd

DESCRIPTION="Updates A record in Route53 with current global IP"
HOMEPAGE="https://github.com/coord-e/r53ddns"
SRC_URI="$(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2
	BSD BSL-1.1 CC0-1.0 MIT Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

src_install() {
	einstalldocs
	newinitd "${FILESDIR}"/r53ddns.initd r53ddns
	newconfd "${FILESDIR}"/r53ddns.confd r53ddns
	systemd_dounit "${FILESDIR}"/r53ddns.service

	cargo_src_install
}
