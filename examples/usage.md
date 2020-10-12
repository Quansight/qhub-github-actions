# Validation

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
