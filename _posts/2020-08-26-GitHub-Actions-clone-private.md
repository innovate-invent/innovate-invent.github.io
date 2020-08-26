---
title: Preconfigure git with credentials
excerpt: Configure git to use credentails when cloning a private repository
tags: git github actions credentials private repository clone terraform
---

You may encounter a program that is indirectly trying to use git to access a private repository. If this program has no means to configure credentials you might think you are out of luck.
Git provides a way to preconfigure credentials that your program can then pick up. Note that you should not use this if you are simply trying to directly clone a repository in a GitHub Action. 
GitHub provides the [checkout](https://github.com/actions/checkout#usage) action to do that and provides a configuration option to hand it an authentication token.

This is particularitly useful if you are using an application called Terraform. It provides a means to download modules via GitHub prepositories.
Terraform does not provide a means to authenticate against private repositories.

To get around this, you can preconfigure credentials before running your application via the following commands:

```sh
git config --global credential.helper cache
printf "protocol=https\nhost=github.com\nusername=innovate-invent\npassword=$PASSWORD" |
git credential approve
```

The first command simply ensures that you have the cache credential helper active. If you are using any other credential helper then this post may not be relevant to you.
The second generates a config in the format expected by the `git credentail approve` command. `$PASSWORD` can be substitued with your account password or a GitHub PAT (Personal Access Token).

I personally use this in my GitHub Actions Terraform pipelines.
