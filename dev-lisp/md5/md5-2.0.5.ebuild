# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

DESCRIPTION="Common Lisp implementation of the MD5 Message-Digest Algorithm"
HOMEPAGE="https://github.com/pmai/md5"
SRC_URI="https://github.com/pmai/${PN}/archive/release-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-release-${PV}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lisp/flexi-streams"
BDEPEND="dev-lisp/asdf"
