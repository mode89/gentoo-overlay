# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="NVIDIA container runtime toolkit"
HOMEPAGE="https://github.com/nvidia/nvidia-container-runtime"
SRC_URI="https://github.com/nvidia/nvidia-container-runtime.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	app-emulation/libnvidia-container \
	>=app-emulation/docker-19.03 \
	!app-emulation/nvidia-container-runtime \
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-lang/go \
"

EGIT_REPO_URI="${SRC_URI}"
EGIT_COMMIT="v3.1.4"

export GOPATH=${WORKDIR}/gopath
export PATH=$PATH:$GOPATH/bin

src_prepare() {
	mkdir -p ${GOPATH}/src || die
	ln -rTsf ${S}/toolkit/${PN} ${GOPATH}/src/${PN}
	default
}

src_configure() { :; }

src_compile() {
	go build -v ${PN} || die
}

src_install() {
	dobin ${S}/${PN}
	dosym ${PN} /usr/bin/nvidia-container-runtime-hook
	insinto /etc/nvidia-container-runtime
	doins ${FILESDIR}/config.toml
}
