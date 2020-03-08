# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Build and run Docker containers leveraging NVIDIA GPUs"
HOMEPAGE="https://github.com/nvidia/nvidia-docker"
SRC_URI="https://github.com/nvidia/nvidia-docker.git"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND} \
	app-emulation/docker \
	app-emulation/nvidia-container-runtime \
"
BDEPEND=""

EGIT_REPO_URI="${SRC_URI}"
EGIT_COMMIT="v2.0.3"

src_compile() { :; }

src_install() {
	dobin ${S}/nvidia-docker
	insinto /etc/docker
	doins ${S}/daemon.json
}
