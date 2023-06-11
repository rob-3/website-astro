---
title: "The Right Default Branch Name"
description: "Lorem ipsum dolor sit amet"
pubDate: "Sun May 28 2023 19:28"
---

`master`, `main`, `trunk`, `develop` -- there are many names people use for
their default branch. Which should you choose?

If you're working on an existing project, probably just whatever is already in
use. Changing the default branch can be a hassle, and maintainers are likely to
have a dim view of it, especially if this is your first or only contribution.

But what should new projects use?

## Use `main`, not `master`

The default branch used to be `master`, so many projects use `master`. However,
in recent times, [some](https://groups.google.com/a/chromium.org/g/chromium-dev/c/mQ1u-I5U500/m/FdvzlTzhAAAJ?pli=1)
major projects started changing their default branch name
to avoid the master-slave terminology.

![Records](../../assets/pexels-robin-mcpherson-908965.jpeg)

<aside>
I personally always thought Git was referring to a master copy (as in
"remastering"), which fits my mental model of Git very well. However, the
term is taken from an older version control system, Bitkeeper, where
<a href="https://mail.gnome.org/archives/desktop-devel-list/2019-May/msg00066.html">
it did refer to a master-slave relationship.
</a>
</aside>

While there were some flame wars about whether this change was really worth the
breakage at the time, the community has largely spoken in favor.

I suggest switching to `main` for future projects. There are three main[^hehe] advantages:

1. `main` doesn't offend anyone.
2. `main` is shorter.
3. The cloud hosts and tooling are moving to `main`.

[GitHub](https://github.blog/changelog/2020-10-01-the-default-branch-for-newly-created-repositories-is-now-main/)
and [GitLab](https://about.gitlab.com/blog/2021/03/10/new-git-default-branch-name/)
have both switched their default branch name to `main`, while
[Bitbucket](https://confluence.atlassian.com/bitbucketserver/setting-a-system-wide-default-branch-name-1021220665.html)
gives you the option, but defers to Git's behavior by default.
Git[^git-version] defaults to `master`, but gives warnings that you haven't set
a default. These defaults favor `main` in the long run.

Other projects (especially migrated from Subversion) continue to use `trunk`,
since that is what they've always used. This has the upside of being a clever
reference to the idea of Git being a tree.[^tree] However, few new developers will
be familiar with `trunk`, so I can't recommend it.

For existing projects, the choice is less clear, as existing shell scripts or
tools might hard-code `master` as the main branch, and links to the `master`
branch might become broken in some tools (although
[GitHub already redirects these](https://github.com/github/renaming/)). This
issue is the main blocker in Git itself, as dozens of tests and other parts of
`git` rely on `master` being the name of the default branch.

```bash
# just run this and get it over with
git config --global init.defaultBranch main
```

I suggest running the above command and switching to `main`.

## Don't use `develop`

Some people are using `develop`, and I think it is 100% due to [this
article about Gitflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow),
which is a good read and a classic work about Git workflows.[^gitflow]

<figure>
    <a>
        <img 
            src="/atlassian-gitflow.svg"
            alt="Gitflow, including a main branch and develop branch"
        >
    </a>
    <figcaption>
        <p class="text-xs">By
            <a href="https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow">
                Atlassian
            </a>
            and licensed under the 
            <a href="http://creativecommons.org/licenses/by/2.5/au/">
                Creative Commons Attribution 2.5 Australia License
            </a>
        </p>
        <p class="m-0 md:text-base">Pretty diagram == a good Git workflow?</p>
    </figcaption>
</figure>

That being said, there are two reasons not to use `develop`:

1. Gitflow has fallen out of favor, for good reasons.
2. If you really want Gitflow, use `main` for development and `release` for release.

Putting `develop` as the default branch isn't entirely wrong. There are good
reasons to make the default branch the development branch. GitHub pull requests
default to merging into the default branch, and the default branch is displayed
and checked out by, well, default.

However, you should just use `main` for the default branch. The development
branch is likely the most important and active branch in your repository.
Calling any other branch `main` is unintuitive at best.

You can name your release branch `release`, or, better yet, [tag your releases](https://git-scm.com/book/en/v2/Git-Basics-Tagging)
directly from the development branch.

## But the poor users!

I've heard some say that GitHub is their release channel, so they want the
default branch to be a release for users. If this is you, you should look
into the [releases page](https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases)
and creating prebuilt releases as a better alternative.

The amount of pain from pull requests into the (incorrectly default) release
branch isn't worth the advantage for users trying to download the software. As
a user, I'm also more attracted to actively maintained projects. Projects that
put the release branch as the default branch make themselves seem less active.

## Conclusion

In short, use `main` by default for future work, but don't be shocked if you
see other projects using `master`, `trunk`, `develop`, or otherwise. There are
many ways to use Git, but using `main` as the default, development branch
should be the bog standard approach that should require reason for deviation.

[^hehe]:
    :)
[^git-version]:
    As of 2.40.0
[^tree]:
    See [git branch](https://git-scm.com/docs/git-branch), [git worktree](https://git-scm.com/docs/git-worktree)
[^gitflow]:
    That being said, many people (including me) don't recommend Gitflow anymore
    and favor trunk-based workflows and short-lived branches, especially for
    small teams. Treat it like
    [K&R](https://en.wikipedia.org/wiki/The_C_Programming_Language);
    well-considered and influential, but not always suitable for modern
    readers.
