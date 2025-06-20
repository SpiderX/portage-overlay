# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="adler2@2.0.0
	aom-decode@0.2.13
	arrayvec@0.7.6
	autocfg@1.4.0
	avif-parse@1.3.2
	bitreader@0.3.11
	bytemuck@1.22.0
	byteorder@1.5.0
	cc@1.2.16
	cfg-if@1.0.0
	cmake@0.1.54
	crc32fast@1.4.2
	crossbeam-channel@0.5.14
	crossbeam-deque@0.8.6
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.21
	dunce@1.0.5
	either@1.14.0
	fallible_collections@0.5.1
	flate2@1.1.0
	foreign-types-macros@0.2.3
	foreign-types-shared@0.3.1
	foreign-types@0.5.0
	getopts@0.2.21
	imgref@1.11.0
	itertools@0.14.0
	jobserver@0.1.32
	jpeg-decoder@0.3.1
	lcms2-sys@4.0.5
	lcms2@6.1.0
	leb128@0.2.5
	libaom-sys@0.17.1+libaom.3.10.0
	libc@0.2.170
	libwebp-sys2@0.1.11
	libwebp@0.1.2
	load_image@3.2.1
	lodepng@3.11.0
	log@0.4.26
	miniz_oxide@0.8.5
	num-traits@0.2.19
	ordered-channel@1.1.0
	pkg-config@0.3.32
	proc-macro2@1.0.94
	quick-error@2.0.1
	quote@1.0.39
	rayon-core@1.12.1
	rayon@1.10.0
	rexif@0.7.5
	rgb@0.8.50
	shlex@1.3.0
	syn@2.0.99
	unicode-ident@1.0.18
	unicode-width@0.1.14
	vcpkg@0.2.15
	yuv@0.1.9"

inherit cargo

DESCRIPTION="Image similarity comparison simulating human perception"
HOMEPAGE="https://github.com/kornelski/dssim"
SRC_URI="https://github.com/kornelski/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}"

LICENSE="AGPL-3 Apache-2.0 BSD BSD-2 CC0-1.0 GPL-3+ MIT MPL-2.0 Unicode-3.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

QA_FLAGS_IGNORED="usr/bin/dssim"

src_install() {
	einstalldocs
	cargo_src_install
}
