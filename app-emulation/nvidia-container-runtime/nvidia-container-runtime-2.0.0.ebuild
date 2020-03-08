# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="NVIDIA container runtime"
HOMEPAGE="https://github.com/nvidia/nvidia-container-runtime"
SRC_URI="https://github.com/nvidia/nvidia-container-runtime.git"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

BDEPEND="
	dev-lang/go \
"

EGIT_REPO_URI="${SRC_URI}"
EGIT_COMMIT="runtime-v2.0.0"

export GOPATH=${WORKDIR}/gopath

src_prepare() {
	mkdir -p $GOPATH/src
	cp -r ${S}/hook/nvidia-container-runtime-hook $GOPATH/src/
	default
}

src_compile() {
	go get -ldflags "-s -w" -v nvidia-container-runtime-hook || die
}

src_install() {
	dobin $GOPATH/bin/nvidia-container-runtime-hook
}
