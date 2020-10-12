# qhub-github-actions
Github Actions for QHub

# Usage

In the workflows directory add the following lines of code:

```
steps:
  - name: 'Checkout Infastructure'
    uses: actions/checkout@master
  - name: 'Qhub Format'
    uses: Quansight/qhub-github-actions@v0.1-beta
    with:
      qhub_actions_version: 0.0.1
      qhub_actions_subcommand: 'validate'
      qhub_actions_working_dir: '.'
      qhub_actions_comment: true
```

# Inputs

The action supports the following inputs:

* `qhub_actions_subcommand`: QHub subcommand to execute.
* `qhub_actions_version`: QHub version to install.
* `qhub_actions_working_dir`: QHub working directory.
* `qhub_actions_comment`: Comment on the PR.

# Outputs

The action supports following outputs:

* `qhub_actions_output`: QHub outputs in JSON format.

# Testing Locally

```
docker run --env-file env -v /path/to/host/directory:/mnt/data image
```

# License

BSD-3-Clause License
