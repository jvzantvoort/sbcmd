Site Builder Command image
==========================

This tools attempts to allow the user to build sphinx based
documentation without the tedium of trying to maintain the proper
package list and python version required.

Use
---

```bash
  docker run --rm -v $PWD:/code --mount type=tmpfs,destination=/output \
    "jvzantvoort/sbcmd:1" sphinx srcdir=test uid=$(id -u) \
    gid=$(id -g)
```

Docker options:

```
--rm
```
Automatically remove the container when it exits.

```
-v $PWD:/code
```
Mount the directory `$PWD` in the image under `/code` the other
options use this as a starting point.

```
--mount type=tmpfs,destination=/output
```
Add a tmpfs mount to the image mounted under `/output`. This is used
to write the initial output.


Included themes
---------------

* sphinx-bootstrap-theme (0.6.5)
* sphinx-glpi-theme (0.3)
* sphinx-nameko-theme (0.0.3)
* sphinx-readable-theme (1.3.0)
* sphinx-rtd-theme (0.4.3)
* sphinx-typlog-theme (0.7.2)
* zerovm-sphinx-theme (1.1)

