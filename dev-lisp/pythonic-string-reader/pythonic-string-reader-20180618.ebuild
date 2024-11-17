# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="47a70ba1e32362e03dad6ef8e6f36180b560f86a"

DESCRIPTION="A simple and unintrusive read table modification"
HOMEPAGE="https://github.com/smithzvk/pythonic-string-reader"
SRC_URI="https://github.com/smithzvk/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="dev-lisp/asdf"
