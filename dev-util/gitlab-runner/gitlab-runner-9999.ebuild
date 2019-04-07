# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV="11.9.1"
EGO_PN="gitlab.com/gitlab-org/gitlab-runner"
BASE_URI="https://gitlab-runner-downloads.s3.amazonaws.com/v${MY_PV}/helper-images/prebuilt-_arch_.tar.xz"

inherit golang-build golang-vcs user readme.gentoo-r1 systemd tmpfiles user

DESCRIPTION="GitLab Runner"
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-runner"
SRC_URI="docker? ( amd64? ( ${BASE_URI/_arch_/x86_64} ) )"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="docker"

RDEPEND="docker? ( app-emulation/docker )"
DEPEND="${RDEPEND}"

RESTRICT="mirror strip"

DOCS=( "${S}"/src/"${EGO_PN}"/{CHANGELOG,README}.md )

DOC_CONTENTS="Register the runner as root using\\n
\\t# gitlab-runner register\\n
Configure the runner in /etc/gitlab-runner/config.toml"

pkg_setup() {
	enewgroup gitlab
	enewuser runner -1 /bin/bash /var/lib/gitlab-runner gitlab
}

src_unpack() {
	golang-vcs_src_unpack

	if use docker ; then
		mkdir -p "${S}"/out/helper-images || die "mkdir failed"
		if use amd64 ; then
			ln -sf "${DISTDIR}"/prebuilt-x86_64.tar.xz \
				"${S}"/out/helper-images/prebuilt-x86_64.tar.xz \
				|| die "ln failed"
		fi
	fi
}

src_install() {
	einstalldocs

	exeinto /usr/libexec/gitlab-runner
	doexe gitlab-runner
	dosym ../libexec/gitlab-runner/gitlab-runner /usr/bin/gitlab-runner

	if use docker ; then
		insinto /usr/libexec/gitlab-runner/helper-images
		doins -r out/helper-images/*.tar.xz
	fi

	newconfd "${FILESDIR}"/gitlab-runner.confd gitlab-runner
	newinitd "${FILESDIR}"/gitlab-runner.initd gitlab-runner
	systemd_dounit "${FILESDIR}"/gitlab-runner.service
	newtmpfiles "${FILESDIR}"/gitlab-runner.tmpfile gitlab-runner.conf

	readme.gentoo_create_doc

	insopts -orunner -ggitlab -m0600
	insinto /etc/gitlab-runner
	doins "${S}"/src/"${EGO_PN}"/config.toml.example

	diropts -orunner -ggitlab -m0700
	keepdir /etc/gitlab-runner /var/lib/gitlab-runner
}

pkg_postinst() {
	tmpfiles_process gitlab-runner.conf
	readme.gentoo_print_elog
}
