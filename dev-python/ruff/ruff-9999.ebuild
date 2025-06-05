# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit git-r3 python-r1

DESCRIPTION="Pytest module for ruff"
HOMEPAGE="https://github.com/astral-sh/ruff"
EGIT_REPO_URI="https://github.com/astral-sh/${PN}.git"

LICENSE="MIT"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="dev-util/ruff
	${PYTHON_DEPS}"

my_install() {
	python_moduleinto ruff
	python_domodule python/ruff/__main__.py
	python_domodule python/ruff/__init__.py
}

src_install() {
	python_foreach_impl my_install
}
