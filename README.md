# template_repo
Template repo for miscellaneous ML project

When starting a new project, modify the parameters in the ``Makefile``:
* ``IMAGE_NAME``
* ``TAG_NAME``
Modify the list of dependencies in ``requirements.txt``.
You can then build your Docker image by doing ``make build``.
Once your image is built, you can either start a terminal by doing ``make shell``
or start a notebook by doing ``make notebook``.

Put your source code in ``src``, and your unit tests in ``src/tests``. You can run those unit tests by doing ``make tests``.

