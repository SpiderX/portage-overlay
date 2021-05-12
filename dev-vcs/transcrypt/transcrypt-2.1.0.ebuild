# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1

DESCRIPTION="Transparently encrypt files within a git repository"
HOMEPAGE="https://github.com/elasticdog/transcrypt"
SRC_URI="https://github.com/elasticdog/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-libs/openssl:0
	dev-vcs/git"
BDEPEND="test? ( dev-util/bats )"

DOCS=( {CHANGELOG,README}.md )

src_test() {
	git config --global user.email "${PN}@gentoo.org" || die "git config failed"
	git config --global user.name "${PN}" || die "git config failed"
	bats tests/ || die "bats failed"
}

src_install() {
	einstalldocs
	dobin transcrypt
	doman man/transcrypt.1
	dobashcomp contrib/bash/transcrypt
	insinto /usr/share/zsh/site-functions
	doins contrib/zsh/_transcrypt
}
