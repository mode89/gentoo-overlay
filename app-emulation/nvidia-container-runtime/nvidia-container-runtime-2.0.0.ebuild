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
RESTRICT="network-sandbox"

DEPEND=""
RDEPEND="${DEPEND} \
	app-emulation/libnvidia-container \
"
BDEPEND=" \
	dev-lang/go \
"

EGIT_REPO_URI="${SRC_URI}"
EGIT_COMMIT="runtime-v2.0.0"

export GOPATH=${WORKDIR}/gopath
export PATH=$PATH:$GOPATH/bin

RUNC_DIR=$GOPATH/src/github.com/opencontainers/runc
RUNC_COMMIT=refs/tags/v1.0.0-rc8

fetch_runc() {
	mkdir -p $RUNC_DIR
	cd $RUNC_DIR
	einfo "Clonning https://github.com/opencontainers/runc.git ..."
	git init || die
	git remote add origin https://github.com/opencontainers/runc.git || die
	git fetch --depth 1 origin $RUNC_COMMIT || die
	git checkout --quiet FETCH_HEAD || die
	eend
}

src_unpack() {
	git-r3_src_unpack
	fetch_runc
}

patch_runc() {
	einfo "Patching runc ..."
	cd $RUNC_DIR
	git apply "${FILESDIR}/runc-add-nvidia-hook.patch" || die
	eend
}

src_prepare() {
	mkdir -p $GOPATH/src
	cp -r ${S}/hook/nvidia-container-runtime-hook $GOPATH/src/
	default
	patch_runc
}

src_configure() { :; }

src_compile() {
	go get -ldflags "-s -w" -v nvidia-container-runtime-hook || die
	cd $RUNC_DIR && make BUILDTAGS="seccomp apparmor selinux" || die
}

src_install() {
	dobin $GOPATH/bin/nvidia-container-runtime-hook
	newbin $RUNC_DIR/runc nvidia-container-runtime
	insinto /etc/nvidia-container-runtime
	newins ${S}/hook/config.toml.ubuntu config.toml
}
