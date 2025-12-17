# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="prometheus prometheus-app"

inherit dune git-r3

DESCRIPTION="OCaml library for reporting metrics to a Prometheus server"
HOMEPAGE="https://github.com/mirage/prometheus"
EGIT_REPO_URI="https://github.com/mirage/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="test" # alcotest doesn't provide alcotest-lwt

RDEPEND="dev-ml/asetmap:0=[ocamlopt?]
	dev-ml/astring:0=
	dev-ml/cmdliner:0=[ocamlopt?]
	dev-ml/cohttp:0=[ocamlopt?]
	dev-ml/fmt:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/re:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest )"
