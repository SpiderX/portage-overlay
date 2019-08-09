# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=7

CRATES="
arrayvec-0.4.11
cfg-if-0.1.9
crossbeam-deque-0.6.3
crossbeam-epoch-0.7.2
crossbeam-queue-0.1.2
crossbeam-utils-0.6.6
either-1.5.2
getopts-0.2.19
imgref-1.3.5
itertools-0.8.0
lazy_static-1.3.0
libc-0.2.60
lodepng-2.4.2
memoffset-0.5.1
nodrop-0.1.13
num_cpus-1.10.1
rayon-1.1.0
rayon-core-1.5.0
rgb-0.8.13
rustc_version-0.2.3
scopeguard-1.0.0
semver-0.9.0
semver-parser-0.7.0
unicode-width-0.1.5"

inherit cargo

DESCRIPTION="Image similarity comparison simulating human perception"
HOMEPAGE="https://github.com/kornelski/dssim"
SRC_URI="https://github.com/kornelski/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})"

LICENSE="AGPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="test"
RESTRICT="mirror test"
