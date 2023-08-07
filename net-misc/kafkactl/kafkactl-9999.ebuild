# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/deviceinsight/${PN}.git"

inherit bash-completion-r1 edo git-r3 go-module

DESCRIPTION="A command-line interface for interaction with Apache Kafka"
HOMEPAGE="https://github.com/deviceinsight/kafkactl"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( {CHANGELOG,README}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	LDFLAGS="-w -X github.com/deviceinsight/kafkactl/cmd.Version=${PV}
	-X github.com/deviceinsight/kafkactl/cmd.GitCommit=${COMMIT}
	-X \"github.com/deviceinsight/kafkactl/cmd.BuildTime=${DATE}\""

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
	insinto /usr/share/fish/completion
	newins kafkactl.fish kafkactl
	insinto /usr/share/zsh/site-functions
	newins kafkactl.zsh _kafkactl
}
