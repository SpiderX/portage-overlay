# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="f0052f34a006ec995086aa3b2e42182a178fe228"

DESCRIPTION="Common Lisp implementation of UUIDs according to RFC4122"
HOMEPAGE="https://github.com/dardoria/uuid"
SRC_URI="https://github.com/dardoria/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lisp/ironclad
	dev-lisp/trivial-utf8"
BDEPEND="dev-lisp/asdf"
