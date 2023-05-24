# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/smallstep/cli.git"

inherit bash-completion-r1 edo git-r3 go-module readme.gentoo-r1 systemd

DESCRIPTION="A zero trust swiss army knife for working with X509"
HOMEPAGE="https://github.com/smallstep/cli"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
RESTRICT="test"
PROPERTIES="test_network"

S="${WORKDIR}/cli-${PV}"

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

	ego build -buildmode=pie \
		-ldflags "${LDFLAGS}" -trimpath -o step-cli ./cmd/...

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
	systemd_dounit systemd/{cert-renewer@,ssh-cert-renewer}.service \
		systemd/cert-renewer.target systemd/{cert-renewer@,ssh-cert-renewer}.timer
	newbashcomp step-cli.bash step-cli
	insinto /usr/share/fish/completion
	newins step-cli.fish step-cli
	insinto /usr/share/zsh/site-functions
	newins step-cli.zsh _step-cli
	doenvd "${FILESDIR}"/99step-cli
}

pkg_postinst() {
	readme.gentoo_print_elog
}
