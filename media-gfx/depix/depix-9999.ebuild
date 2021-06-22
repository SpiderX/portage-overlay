# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/beurtschipper/${PN^}.git"

inherit git-r3 python-single-r1

DESCRIPTION="A tool for recovering passwords from pixelized screenshots"
HOMEPAGE="https://github.com/beurtschipper/Depix"
SRC_URI=""

LICENSE="CC-BY-4.0"
SLOT="0"
KEYWORDS=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/pillow[${PYTHON_USEDEP}]')"
DEPEND="${RDEPEND}"

src_prepare() {
	default

	# Add shebang
	sed -i '1i\#!/usr/bin/env python' depix.py || \
		die "sed failed for depix.py"
}

src_install() {
	python_doscript depix.py
	python_domodule depixlib
}
