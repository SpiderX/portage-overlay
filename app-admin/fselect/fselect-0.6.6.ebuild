# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=7

CRATES="
adler32-1.0.4
aho-corasick-0.7.6
ansi_term-0.12.1
app_dirs-1.2.1
atty-0.2.13
autocfg-0.1.6
base64-0.10.1
bitreader-0.3.2
bitstream-io-0.8.4
block-buffer-0.7.3
block-padding-0.1.4
bstr-0.2.8
byte-tools-0.3.1
bytecount-0.6.0
byteorder-1.3.2
bzip2-0.3.3
bzip2-sys-0.1.7
cc-1.0.45
cfg-if-0.1.10
chrono-0.4.9
chrono-english-0.1.4
crc32fast-1.2.0
csv-1.1.1
csv-core-0.1.6
digest-0.8.1
fake-simd-0.1.2
fixedbitset-0.1.9
flate2-1.0.11
fnv-1.0.6
fselect-0.6.6
fuchsia-cprng-0.1.1
generic-array-0.12.3
humansize-1.1.0
imagesize-0.8.0
itoa-0.4.4
kamadak-exif-0.3.1
keccak-0.1.0
lazy_static-0.2.11
lazy_static-1.4.0
libc-0.2.62
log-0.4.8
lscolors-0.6.0
matroska-0.5.1
memchr-2.2.1
miniz_oxide-0.3.2
mp3-metadata-0.3.2
mp4parse-0.11.2
nom-2.2.1
num-integer-0.1.41
num-traits-0.2.8
ole32-sys-0.2.0
opaque-debug-0.2.3
ordermap-0.3.5
owning_ref-0.3.3
parking_lot-0.4.8
parking_lot_core-0.2.14
petgraph-0.4.13
podio-0.1.6
proc-macro2-1.0.4
quote-1.0.2
rand-0.4.6
rand_core-0.3.1
rand_core-0.4.2
rdrand-0.4.0
redox_syscall-0.1.56
regex-1.3.1
regex-automata-0.1.8
regex-syntax-0.6.12
ryu-1.0.0
scanlex-0.1.2
serde-1.0.101
serde_derive-1.0.101
serde_json-1.0.40
sha-1-0.8.1
sha2-0.8.0
sha3-0.8.2
shell32-sys-0.1.2
smallvec-0.6.10
stable_deref_trait-1.1.1
syn-1.0.5
thread_local-0.3.6
time-0.1.42
toml-0.5.3
tree_magic-0.2.1
typenum-1.11.2
unicode-xid-0.2.0
users-0.9.1
winapi-0.2.8
winapi-0.3.8
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
xattr-0.2.2
xdg-2.2.0
zip-0.5.3
"

inherit cargo

DESCRIPTION="Find files with SQL-like queries"
HOMEPAGE="https://github.com/jhspetersson/fselect"
SRC_URI="$(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DOCS=( docs/usage.md )

src_install() {
	einstalldocs
	dobin target/release/fselect
	doman docs/fselect.1
}
