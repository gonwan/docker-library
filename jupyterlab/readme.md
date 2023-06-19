# Introduction

The application runs under uid [1000](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html). Run `chown -R 1000:1000 work` for volume write permissions, if docker-compose fails.

Follow the instructions on the start page, and get token from `docker logs <your_container>`.

Run `%conda install ...` & `%conda install --file requirements.txt` to install packages to the current notebook kernel. Alternatively, [mamba](https://github.com/mamba-org/mamba) can also be used, which is much faster. See [here](https://jakevdp.github.io/blog/2017/12/05/installing-python-packages-from-jupyter/) for package management.
