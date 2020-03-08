This is a [Gentoo overlay](https://wiki.gentoo.org/wiki/Ebuild_repository)
holding [ebuild](https://devmanual.gentoo.org/eclass-reference/ebuild/index.html)
scripts for packages that I ever needed, but didn't find in the official
Gentoo repositories, like ```nvidia-docker2```, ```nvidia-container-toolkit```
and etc.

## Usage

Gentoo has many ways of managing third-party ebuild repositories. Please checkout the
[official guide](https://wiki.gentoo.org/wiki/Ebuild_repository#Available_software)
for mode details.

One of the ways is declaring the repository inside the
[/etc/portage/repos.conf](https://wiki.gentoo.org/wiki//etc/portage/repos.conf).

Add ```mode.conf``` file to the ```/etc/portage/repos.conf``` directory
with the following content:

```ini
[mode]
location = /usr/local/portage/mode
sync-type = git
sync-uri = https://github.com/mode89/gentoo-overlay.git
```

Syncing with the repository is performed automatically every time you
launched ```emerge --sync```.

## Contributing

If you would like to improve or fix any of the ebuild scripts contained in
this repository, please submit a pull request.
