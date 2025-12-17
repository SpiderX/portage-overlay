# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="metrics metrics-influx metrics-lwt metrics-rusage metrics-unix"

inherit dune

DESCRIPTION="Infrastructure to collect metrics from OCaml applications"
HOMEPAGE="https://github.com/mirage/metrics"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/duration:0=[ocamlopt?]
	dev-ml/fmt:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/mtime:0=
	dev-ml/uuidm:0=[ocamlopt?]
	sci-visualization/gnuplot"
BDEPEND="test? ( dev-ml/alcotest )"
