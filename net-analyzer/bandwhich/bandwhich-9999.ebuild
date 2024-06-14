# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

EGIT_REPO_URI="https://github.com/imsnif/bandwhich.git"

inherit cargo git-r3 shell-completion

DESCRIPTION="Network utilization by process, connection and hostname"
HOMEPAGE="https://github.com/imsnif/bandwhich"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 CC0-1.0 MIT Unlicense ZLIB"
SLOT="0"
RESTRICT="mirror"

DOCS=( {CHANGELOG,README}.md )

src_unpack() {
	git-r3_src_unpack
	cargo_src_unpack
}

src_prepare() {
	default
	export BANDWHICH_GEN_DIR="${T}/bandwhich-gen-dir" || die "export failed"
	mkdir -p "${BANDWHICH_GEN_DIR}" || die "mkdir failed"
}

src_install() {
	einstalldocs
	dobashcomp "${BANDWHICH_GEN_DIR}"/bandwhich.bash
	dofishcomp "${BANDWHICH_GEN_DIR}"/bandwhich.fish
	dozshcomp "${BANDWHICH_GEN_DIR}"/_bandwhich
	doman "${BANDWHICH_GEN_DIR}"/bandwhich.1
	cargo_src_install
}
