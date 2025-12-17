# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Lwt-friendly logger"
HOMEPAGE="https://github.com/ocsigen/lwt_log"
EGIT_REPO_URI="https://github.com/ocsigen/${PN}.git"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="dev-ml/lwt:0=[ocamlopt?]"
