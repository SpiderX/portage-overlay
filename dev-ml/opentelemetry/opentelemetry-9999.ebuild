# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="opentelemetry opentelemetry-client opentelemetry-client-cohttp-eio
	opentelemetry-client-cohttp-lwt opentelemetry-client-ocurl
	opentelemetry-cohttp-lwt opentelemetry-logs opentelemetry-lwt"

inherit dune git-r3

DESCRIPTION="Instrumentation and serialization for opentelemetry"
HOMEPAGE="https://github.com/ocaml-tracing/ocaml-opentelemetry"
EGIT_REPO_URI="https://github.com/ocaml-tracing/ocaml-opentelemetry.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/ambient-context:0=[ocamlopt?]
	dev-ml/ca-certs:0=[ocamlopt?]
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
