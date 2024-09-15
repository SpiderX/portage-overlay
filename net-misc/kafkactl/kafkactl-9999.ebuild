# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/deviceinsight/${PN}.git"

inherit edo git-r3 go-module shell-completion

DESCRIPTION="A command-line interface for interaction with Apache Kafka"
HOMEPAGE="https://github.com/deviceinsight/kafkactl"

LICENSE="Apache-2.0"
SLOT="0"

DOCS=( CHANGELOG.md README.adoc )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	LDFLAGS="-w -X github.com/deviceinsight/kafkactl/v5/cmd.Version=${PV}
	-X github.com/deviceinsight/kafkactl/v5/cmd.GitCommit=${COMMIT}
	-X \"github.com/deviceinsight/kafkactl/v5/cmd.BuildTime=${DATE}\""

	ego build -buildmode=pie \
		-ldflags "${LDFLAGS}" -trimpath -o kafkactl

	local completion
	for completion in bash fish zsh ; do
		edo ./kafkactl completion "${completion}" > kafkactl."${completion}"
	done
}

src_install() {
	einstalldocs
	dobin kafkactl
	newbashcomp kafkactl.bash kafkactl
	dofishcomp kafkactl.fish kafkactl
	newzshcomp kafkactl.zsh _kafkactl
}
