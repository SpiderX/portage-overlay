# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 systemd

MY_PN="${PN/-bin/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Modern UI for Ansible"
HOMEPAGE="https://github.com/ansible-semaphore/semaphore"
SRC_URI="https://github.com/ansible-semaphore/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz
	https://github.com/ansible-semaphore/${MY_PN}/releases/download/v${PV}/${MY_PN}_${PV}_linux_amd64.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="acct-user/semaphore"

S="${WORKDIR}/${MY_P}"

QA_PREBUILT="usr/bin/semaphore"

src_install() {
	einstalldocs
	dobin "${WORKDIR}"/semaphore

	insinto /etc/semaphore
	doins deployment/systemd/env

	newinitd "${FILESDIR}"/semaphore.initd semaphore
	newconfd "${FILESDIR}"/semaphore.confd semaphore
	systemd_dounit deployment/systemd/semaphore.service

	newbashcomp - semaphore < <("${ED}"/usr/bin/semaphore completion bash \
		|| die "sed failed bash completion" )
	insinto /usr/share/fish/completion
	newins - semaphore < <("${ED}"/usr/bin/semaphore completion fish \
		|| die "sed failed fish completion" )
	insinto /usr/share/zsh/site-functions
	newins - _semaphore < <("${ED}"/usr/bin/semaphore completion zsh \
		|| die "sed failed zsh completion" )

	diropts -o semaphore -g semaphore -m 0700
	keepdir /var/lib/semaphore
}
