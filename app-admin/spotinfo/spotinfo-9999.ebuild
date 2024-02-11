# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/alexei-led/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Exploring AWS EC2 Spot inventory"
HOMEPAGE="https://github.com/alexei-led/spotinfo"
SRC_URI="https://spot-bid-advisor.s3.amazonaws.com/spot-advisor-data.json
	http://spot-price.s3.amazonaws.com/spot.js -> spot-price-data.json"

LICENSE="Apache-2.0 BSD-2 MIT"
SLOT="0"
RESTRICT="test" #fail on pricingLazyLoad

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_prepare() {
	default

	mkdir public/spot/data
	cp "${DISTDIR}"/spot-{advisor,price}-data.json public/spot/data \
		|| die "cp failed"

	sed -i -e "s/callback(//g" \
		-e "s/);//g" \
		public/spot/data/spot-price-data.json || die "sed failed"
}

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	LDFLAGS="-w -X main.Version=${PV}
	-X main.GitCommit=${COMMIT}
	-X main.GitBranch=master
	-X \"main.BuildDate=${DATE}\""

	ego build -buildmode=pie -ldflags "${LDFLAGS}" -o spotinfo ./cmd/main.go
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin spotinfo
}
