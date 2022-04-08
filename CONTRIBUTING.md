### Contributing

I welcome bug reports, feedbacks and ebuild feature requests; you can use the
[GitHub issue tracker](https://github.com/SpiderX/portage-overlay/issues/) or
[e-mail](repositories.xml#L9) to provide them.

Code contributions and bug fixes are welcome too, and I encourage the use of
merge requests to _discuss_ and _review_ your ebuild code changes. Before
proposing a large change, please discuss it by raising an issue.

### Before You Begin

This overlay assumes that you have read and properly understood the
[Gentoo Developer Manual](https://devmanual.gentoo.org).

### Making and Submitting Changes

To make the process of merge requests submission as seamless as possible, I ask
for the following:

1.  Go ahead and [fork](https://help.github.com/articles/fork-a-repo)
    this project.
2.  Create your feature branch:
    `git checkout -b my-new-feature develop`
3.  When your code changes are ready, make sure to run
    `repoman manifest`, `repoman full` and `pkgcheck scan`
    in the package directory to ensure that all the Gentoo's QA tests pass.
    This is necessary to assure that nothing was accidentally broken by your changes;
    for the purpose this project integrates [GitHub Actions](.github/workflows)
    for _repoman_, _pkgcheck_ and _shellcheck_ tests.
4.  Make sure your git commit messages are in the proper format to make reading
    history easier. Commit your message with `repoman commit`, which should look
    like:

    ```console
    category/package-name: short description

    Long description
    ```

    If you have questions about how to write the short/long descriptions,
    please read these blog articles:
    [How to Write a Commit Message](https://chris.beams.io/posts/git-commit/),
    [5 Useful Tips For A Better Commit Message](https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message).
    Both of them are excellent resources for learning how to write a well-crafted
    git commit message.
5.  GPG signing your changes is a good idea, but not mandatory.
6.  Push your changes in your fork `git push origin my-new-feature`, and then
    submit a [pull request](https://help.github.com/articles/creating-a-pull-request).

    > **Note:**  If you get in trouble with _**shellcheck's**_ tests, please see
    > their [checks guide](https://github.com/koalaman/shellcheck/wiki/Checks).

7.  Squash your commits into a single one with `git rebase -i`. It's okay to
    force update your merge request.
