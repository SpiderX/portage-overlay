# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 edo git-r3

DESCRIPTION="PostgreSQL locking context managers and functions for Django"
HOMEPAGE="https://github.com/Xof/django-pglocks"
EGIT_REPO_URI="https://github.com/Xof/${PN}.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-db/postgresql:* )"

distutils_enable_tests pytest

export DJANGO_SETTINGS_MODULE='django_pglocks'

python_test() {
	local PYTHONPATH=. db="${T}/pgsql"
	edo initdb -U postgres -A trust -D "${db}" || die "initdb failed"
	edo pg_ctl -w -D "${db}" start -o "-h '127.0.0.1' -p 5432 -k '${T}'" \
		|| die "pg_ctl for start failed"
	epytest
	edo pg_ctl -w -D "${db}" stop || die "pg_ctl for stop failed"
}
