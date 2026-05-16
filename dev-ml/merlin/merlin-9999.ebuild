# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="dot-merlin-reader merlin merlin-lib ocaml-index"

inherit dune edo elisp-common git-r3

DESCRIPTION="Context sensitive completion for OCaml in Vim and Emacs"
HOMEPAGE="https://github.com/ocaml/merlin"
EGIT_REPO_URI="https://github.com/ocaml/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="emacs +ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-lang/ocaml-5.3.0:0=[ocamlopt]
	dev-ml/csexp:0=[ocamlopt]
	dev-ml/yojson:0=[ocamlopt]
	emacs? ( >=app-editors/emacs-23.1:*
		app-emacs/auto-complete
		app-emacs/company-mode )"
DEPEND="${RDEPEND}"
BDEPEND="dev-ml/findlib
	test? ( app-misc/jq
		dev-ml/alcotest
		dev-ml/ppxlib
		dev-ml/ppx_string )"

SITEFILE="50${PN}-gentoo.el"

src_unpack() {
	default

	if has_version "=dev-lang/ocaml-5.3*" ; then
		edo mv "${P}-503" "${S}"
	elif has_version "=dev-lang/ocaml-5.4*" ; then
		edo mv "${P}-504" "${S}"
	else
		die "The installed version of OCaml is not yet supported"
	fi
}

src_prepare() {
	default

	# Handle ELisp installation via the Emacs Eclass.
	edo rm emacs/dune

	# Remove Menhir requirement.
	# > MenhirLib.StaticVersion.require_20201216
	sed -i src/ocaml/preprocess/parser_raw.ml \
		-e "s|MenhirLib.StaticVersion.require_.*|()|g" \
		|| die "sed failed for parser_raw.ml"

	# fix path to lib
	sed -i "s|lib|/usr/$(get_libdir)|" \
		tests/test-dirs/locate/ill-typed/issue1580.t \
		tests/test-dirs/occurrences/issue1404.t \
		tests/test-dirs/locate/context-detection/cd-mod_constr.t/run.t \
		|| die "sed failed for tests"
	edo rm tests/test-dirs/search/{issue1113,polarity-search-comparison-to-search-by-type}.t
}

src_compile() {
	dune-compile ${DUNE_PKG_NAME}

	if use emacs ; then
		# iedit isn't packaged yet
		edo rm emacs/merlin-iedit.el

		local -x BYTECOMPFLAGS="-L emacs"
		elisp-compile ./emacs/*.el
	fi
}

src_install() {
	dune_src_install

	if use emacs ; then
		elisp-install merlin ./emacs/*.el{,c}
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
