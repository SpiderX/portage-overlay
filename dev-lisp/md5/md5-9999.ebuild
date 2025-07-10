# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Common Lisp implementation of the MD5 Message-Digest Algorithm"
HOMEPAGE="https://github.com/pmai/md5"
EGIT_REPO_URI="https://github.com/pmai/${PN}.git"

LICENSE="public-domain"
SLOT="0"

RDEPEND="dev-lisp/flexi-streams"
BDEPEND="dev-lisp/asdf"
