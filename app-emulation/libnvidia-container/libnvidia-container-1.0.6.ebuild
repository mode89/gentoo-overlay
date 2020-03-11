# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="NVIDIA container runtime library"
HOMEPAGE="https://github.com/nvidia/libnvidia-container"
SRC_URI="https://github.com/nvidia/libnvidia-container.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE=""
RESTRICT="network-sandbox"

DEPEND=" \
	dev-libs/elfutils \
	net-libs/libtirpc \
	net-libs/rpcsvc-proto \
	sys-libs/libcap \
	sys-libs/libseccomp \
"
RDEPEND="${DEPEND}"
BDEPEND=""

EGIT_REPO_URI="${SRC_URI}"
EGIT_COMMIT="v${PV}"

PATCHES=(
	"${FILESDIR}/makefile.patch"
)

src_compile() {
	export WITH_LIBELF=yes
	default
}

src_install() {
	export LIBDIR=$(get_libdir)
	default
}
