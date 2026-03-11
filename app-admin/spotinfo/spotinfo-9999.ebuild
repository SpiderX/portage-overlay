# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo git-r3 go-module

DESCRIPTION="Exploring AWS EC2 Spot inventory"
HOMEPAGE="https://github.com/alexei-led/spotinfo"
EGIT_REPO_URI="https://github.com/alexei-led/${PN}.git"

LICENSE="Apache-2.0 BSD-2 MIT"
SLOT="0"
IUSE="embed-data-files"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor

	edo mkdir -p public/spot/data
	if use embed-data-files ; then
		edo wget https://spot-bid-advisor.s3.amazonaws.com/spot-advisor-data.json -O \
			public/spot/data/spot-advisor-data.json
		edo wget http://spot-price.s3.amazonaws.com/spot.js -O \
			public/spot/data/spot-price-data.json
	fi
}

src_prepare() {
	default

	if use embed-data-files ; then
		sed -i -e "s/callback(//g" \
			-e "s/);//g" \
			public/spot/data/spot-price-data.json || die "sed failed"
	else
		touch public/spot/data/spot-{advisor,price}-data.json \
			|| die "touch failed"
	fi
}

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	LDFLAGS="-w -X main.Version=${PV}
	-X main.GitCommit=${COMMIT}
	-X main.GitHubRelease=v${PV}
	-X main.GitBranch=master
	-X \"main.BuildDate=${DATE}\""

	ego build -ldflags "${LDFLAGS}" -o spotinfo ./cmd/spotinfo
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin spotinfo
}
