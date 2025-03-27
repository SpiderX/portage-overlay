# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit python-single-r1

DESCRIPTION="A tool to detect similarities between files within a repository"
HOMEPAGE="https://github.com/platisd/duplicate-code-detection-tool"
SRC_URI="https://github.com/platisd/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/astor[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/gensim[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/nltk[${PYTHON_USEDEP}]')
	dev-python/nltk-data"
BDEPEND="${RDEPEND}"

src_prepare() {
	default

	sed -i '1i#!/usr/bin/env python' duplicate_code_detection.py \
		|| die "sed failed"
}

src_install() {
	python_newexe duplicate_code_detection.py duplicate-code-detection
}
