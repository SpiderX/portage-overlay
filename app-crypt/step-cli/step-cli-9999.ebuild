# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo git-r3 go-module readme.gentoo-r1 shell-completion systemd tmpfiles

DESCRIPTION="A zero trust swiss army knife for working with X509"
HOMEPAGE="https://github.com/smallstep/cli"
EGIT_REPO_URI="https://github.com/smallstep/cli.git"

LICENSE="Apache-2.0"
SLOT="0"
RESTRICT="test"
PROPERTIES="test_network"

DOCS=( {CHANGELOG,README}.md )

DOC_CONTENTS="Run 'env-update && source /etc/profile' to\\n
export STEPPATH envvar, after that you can init CA via\\n
'step-cli ca init' into /etc/step directory.\\n\\n"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	LDFLAGS="-w -X main.Version=${PV} -X \"main.BuildTime=${DATE}\""

	ego build -ldflags "${LDFLAGS}" -o step-cli ./cmd/...

	local completion
	for completion in bash fish zsh ; do
		edo ./step-cli completion ${completion} > step-cli.${completion}
		edo sed -i "s/step/step-cli/g" step-cli.${completion}
	done
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	readme.gentoo_create_doc

	dobin step-cli
	doenvd "${FILESDIR}"/99step-cli
	systemd_dounit systemd/{cert-renewer@,ssh-cert-renewer}.service \
		systemd/cert-renewer.target systemd/{cert-renewer@,ssh-cert-renewer}.timer
	newinitd "${FILESDIR}"/step-cli.initd step-cli
	newconfd "${FILESDIR}"/step-cli.confd step-cli
	newtmpfiles "${FILESDIR}"/step-cli.tmpfile step-cli.conf

	newbashcomp step-cli.bash step-cli
	newfishcomp step-cli.fish step-cli
	newzshcomp step-cli.zsh _step-cli
}

pkg_postinst() {
	readme.gentoo_print_elog
	tmpfiles_process step-cli.conf
}
