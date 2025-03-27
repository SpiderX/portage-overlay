# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo git-r3 go-module shell-completion

DESCRIPTION="AWS IAM Roles Anywhere Credential Helper"
HOMEPAGE="https://github.com/aws/rolesanywhere-credential-helper"
EGIT_REPO_URI="https://github.com/aws/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"
RESTRICT="test" # fails

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-w -X github.com/aws/rolesanywhere-credential-helper/cmd.Version=${PV}"

	ego build -ldflags "${LDFLAGS}" -trimpath -o bin/aws_signing_helper

	local completion
	for completion in bash fish zsh ; do
		edo ./bin/aws_signing_helper completion ${completion} > aws_signing_helper.${completion} \
			|| die "completion for ${completion} failed"
	done

}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin bin/aws_signing_helper

	newbashcomp aws_signing_helper.bash aws_signing_helper
	newfishcomp aws_signing_helper.fish aws_signing_helper
	newzshcomp aws_signing_helper.zsh _aws_signing_helper
}
