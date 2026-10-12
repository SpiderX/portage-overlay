# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo go-module shell-completion

COMMIT="f33857a"

DESCRIPTION="A command-line interface for interaction with Apache Kafka"
HOMEPAGE="https://github.com/deviceinsight/kafkactl"
SRC_URI="https://github.com/deviceinsight/kafkactl/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND=">=dev-lang/go-1.27.1"

DOCS=( CHANGELOG.md README.adoc )

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	LDFLAGS="-w -X github.com/deviceinsight/kafkactl/v5/cmd.Version=${PV}
	-X github.com/deviceinsight/kafkactl/v5/cmd.GitCommit=${COMMIT}
	-X \"github.com/deviceinsight/kafkactl/v5/cmd.BuildTime=${DATE}\""

	ego build -ldflags "${LDFLAGS}" -o kafkactl

	local completion
	for completion in bash fish zsh ; do
		edo ./kafkactl completion "${completion}" > kafkactl."${completion}"
	done
}

src_test() {
	ego test -short ./...
}

src_install() {
	einstalldocs
	dobin kafkactl
	newbashcomp kafkactl.bash kafkactl
	dofishcomp kafkactl.fish kafkactl
	newzshcomp kafkactl.zsh _kafkactl
}
