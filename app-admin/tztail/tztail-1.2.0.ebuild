# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

CRATES="aho-corasick@0.6.9
	ansi_term@0.11.0
	assert_cmd@0.10.2
	atty@0.2.11
	bitflags@1.0.4
	cfg-if@0.1.6
	chrono@0.4.6
	chrono-tz@0.5.0
	clap@2.32.0
	colored@1.6.1
	difference@2.0.0
	escargot@0.3.1
	itoa@0.4.3
	kernel32-sys@0.2.2
	lazy_static@1.2.0
	libc@0.2.43
	memchr@2.1.1
	num-integer@0.1.39
	num-traits@0.2.6
	parse-zoneinfo@0.2.0
	predicates@1.0.0
	predicates-core@1.0.0
	predicates-tree@1.0.0
	proc-macro2@0.4.24
	quote@0.6.10
	redox_syscall@0.1.40
	redox_termios@0.1.1
	regex@1.0.5
	regex-syntax@0.6.2
	ryu@0.2.7
	serde@1.0.80
	serde_derive@1.0.80
	serde_json@1.0.33
	strsim@0.7.0
	syn@0.15.21
	term_size@0.3.1
	termion@1.5.1
	textwrap@0.10.0
	thread_local@0.3.6
	time@0.1.40
	treeline@0.1.0
	tztail@1.2.0
	ucd-util@0.1.2
	unicode-width@0.1.5
	unicode-xid@0.1.0
	utf8-ranges@1.0.2
	vec_map@0.8.1
	version_check@0.1.5
	winapi@0.2.8
	winapi@0.3.6
	winapi-build@0.1.1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0"

inherit cargo

DESCRIPTION="A log view in various timezones"
HOMEPAGE="https://github.com/thecasualcoder/tztail"
SRC_URI="${CARGO_CRATE_URIS}"

LICENSE="Apache-2.0 Boost-1.0 MIT MPL-2.0 Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~x86"

QA_FLAGS_IGNORED="usr/bin/tztail"

src_install() {
	einstalldocs
	cargo_src_install
}
