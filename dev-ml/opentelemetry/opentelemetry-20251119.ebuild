# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="opentelemetry opentelemetry-client-cohttp-eio
	opentelemetry-client-cohttp-lwt opentelemetry-client-ocurl
	opentelemetry-cohttp-lwt opentelemetry-logs opentelemetry-lwt"

inherit dune

COMMIT="e31f5f6aba3884e614e79a06dc4e0d4e8b1ee494"
MY_PN="ocaml-${PN}"

DESCRIPTION="Instrumentation and serialization for opentelemetry"
HOMEPAGE="https://github.com/ocaml-tracing/ocaml-opentelemetry"
SRC_URI="https://github.com/ocaml-tracing/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/ca-certs:0=[ocamlopt?]
	dev-ml/cohttp:0=[ocamlopt?]
	dev-ml/eio:0=[ocamlopt?]
	dev-ml/ezcurl:0=[ocamlopt?]
	dev-ml/hmap
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/mirage-crypto:0=[ocamlopt?]
	dev-ml/mtime:0=
	dev-ml/ocurl:0=[ocamlopt?]
	dev-ml/protoc:0=[ocamlopt?]
	dev-ml/ptime:0=[ocamlopt?]
	dev-ml/thread-local-storage:0=[ocamlopt?]
	dev-ml/tls:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/containers )"

src_prepare() {
	default

	sed -i '/atomic/d' src/ambient-context/dune \
		|| die "sed failed for dune"
}
