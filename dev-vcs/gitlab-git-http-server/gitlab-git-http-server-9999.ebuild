# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 golang-base user

DESCRIPTION="A Git HTTP server for GitLab"
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-git-http-server"
LICENSE="MIT"

GO_PN="gitlab.com/gitlab-org/gitlab-git-http-server"
EGIT_REPO_URI="https://${GO_PN}.git"
SRC_URI=""

SLOT="0"
KEYWORDS=""
RESTRICT="test"
IUSE="test"

DEPEND=">=dev-lang/go-1.5:=
	test? ( dev-go/go-tools )
	"
RDEPEND=""

src_prepare() {
	epatch_user
}

src_install() {
	dobin gitlab-git-http-server

	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
}
