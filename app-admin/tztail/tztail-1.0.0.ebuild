# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
aho-corasick-0.6.9
ansi_term-0.11.0
atty-0.2.11
bitflags-1.0.4
byteorder-0.4.2
cfg-if-0.1.6
chrono-0.4.6
chrono-tz-0.5.0
clap-2.32.0
hourglass-0.7.1
kernel32-sys-0.2.2
lazy_static-1.1.0
libc-0.2.43
memchr-2.1.1
nom-1.2.4
num-integer-0.1.39
num-traits-0.2.6
parse-zoneinfo-0.2.0
redox_syscall-0.1.40
redox_termios-0.1.1
regex-1.0.5
regex-syntax-0.6.2
strsim-0.7.0
term_size-0.3.1
termion-1.5.1
textwrap-0.10.0
thread_local-0.3.6
time-0.1.40
tztail-1.0.0
ucd-util-0.1.2
unicode-width-0.1.5
utf8-ranges-1.0.2
vec_map-0.8.1
version_check-0.1.5
winapi-0.2.8
winapi-0.3.6
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo

DESCRIPTION="A log view in various timezones"
HOMEPAGE="https://github.com/thecasualcoder/tztail"
SRC_URI="$(cargo_crate_uris ${CRATES})"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="test"
RESTRICT="test"

src_test() {
	cargo test --all || die "tests failed"
}
