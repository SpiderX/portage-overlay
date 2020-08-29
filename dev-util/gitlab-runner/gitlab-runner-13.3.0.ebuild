# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module readme.gentoo-r1 systemd tmpfiles

BASE_URI="https://gitlab-runner-downloads.s3.amazonaws.com/v${PV}/helper-images/prebuilt-_arch_.tar.xz"
MY_P="${PN}-v${PV}"
REVISION="86ad88ea"
BRANCH="13-3-stable"
NS="gitlab.com/gitlab-org/gitlab-runner/common"

DESCRIPTION="GitLab Runner"
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-runner"
SRC_URI="https://gitlab.com/gitlab-org/${PN}/-/archive/v${PV}/${MY_P}.tar.gz
	docker? ( amd64? ( ${BASE_URI/_arch_/x86_64} ) )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="docker"
RESTRICT="mirror"

RDEPEND="acct-user/gitlab-runner
	docker? ( app-emulation/docker )"

S="${WORKDIR}/${MY_P}"

DOCS=( {CHANGELOG,README}.md )

DOC_CONTENTS="Register the runner using\\n
\\t gitlab-runner register\\n
Configure the runner in /etc/gitlab-runner/config.toml"

src_unpack() {
	default

	if use docker ; then
		mkdir -p "${S}"/out/helper-images || die "mkdir failed"
		if use amd64 ; then
			ln -sf "${DISTDIR}"/prebuilt-x86_64.tar.xz \
				"${S}"/out/helper-images/prebuilt-x86_64.tar.xz \
				|| die "ln failed"
		fi
	fi
}

src_compile() {
	LDFLAGS="-X ${NS}.NAME=${PN} -X ${NS}.VERSION=${PV}
		-X ${NS}.REVISION=${REVISION} -X ${NS}.BUILT=$(date -u +%Y-%m-%dT%H:%M:%S%z)
		-X ${NS}.BRANCH=${BRANCH}"

	GOFLAGS="-v -x -mod=vendor" \
		go build -ldflags "${LDFLAGS}" || die "go build failed"
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" \
		go test -work || die "test failed"
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

	insopts -o gitlab-runner -g gitlab -m 0600
	insinto /etc/gitlab-runner
	doins config.toml.example

	diropts -o gitlab-runner -g gitlab -m 0700
	keepdir /etc/gitlab-runner /var/log/gitlab-runner
}

pkg_postinst() {
	go-module_pkg_postinst
	readme.gentoo_print_elog
	tmpfiles_process gitlab-runner.conf
}
