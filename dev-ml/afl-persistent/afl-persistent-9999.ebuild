# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune edo git-r3

DESCRIPTION="Persistent-mode afl-fuzz for ocaml OCaml"
HOMEPAGE="https://github.com/stedolan/ocaml-afl-persistent"
EGIT_REPO_URI="https://github.com/stedolan/ocaml-afl-persistent.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="test" # fails

BDEPEND="test? ( app-forensics/afl )"

src_test() {
	edo pushd test
	edo ./test.sh
	edo popd
}
