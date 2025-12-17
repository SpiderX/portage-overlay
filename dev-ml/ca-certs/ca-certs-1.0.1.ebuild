# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Detect root CA certificates from the operating system"
HOMEPAGE="https://github.com/mirage/ca-certs"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/bos:0=
	dev-ml/digestif:0=[ocamlopt?]
	dev-ml/fmt:0=[ocamlopt?]
	dev-ml/fpath:0=
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/mirage-crypto:0=[ocamlopt?]
	dev-ml/ohex:0=[ocamlopt?]
	dev-ml/ptime:0=[ocamlopt?]
	dev-ml/x509:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/fmt )"
