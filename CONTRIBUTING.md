# Contributing

Thank you for considering contributing to this module. Please follow these guidelines to keep the project consistent and maintainable.

## Getting Started

1. Fork the repository and create a branch from `main`.
2. Make your changes, following the standards described below.
3. Open a pull request with a clear description of what changed and why.

## Requirements

- [Terraform](https://www.terraform.io/downloads) `~> 1.5.7`
- [terraform-docs](https://terraform-docs.io) `v0.24.0` for README generation
- [pre-commit](https://pre-commit.com) for local quality checks
- [Gitleaks](https://github.com/gitleaks/gitleaks) for secret scanning

## Local Development

Install the pre-commit hooks after cloning:

```bash
pre-commit install
```

The hooks will run automatically on every commit and enforce:

- `terraform fmt` — consistent formatting
- `terraform validate` — configuration validity
- `terraform-docs` — keeps `README.md` up to date
- `gitleaks` — prevents accidental secret commits

To run all hooks manually against the full repo:

```bash
pre-commit run --all-files
```

## Commit Messages

This project uses [Conventional Commits](https://www.conventionalcommits.org/) to drive automated versioning and changelog generation via [release-please](https://github.com/googleapis/release-please).

Use the following prefixes in your commit messages:

| Prefix | Effect | Example |
|--------|--------|---------|
| `fix:` | Patch release | `fix: correct subnet validation logic` |
| `feat:` | Minor release | `feat: add support for private endpoints` |
| `feat!:` or `BREAKING CHANGE:` in body | Major release | `feat!: remove deprecated variable` |
| `chore:`, `docs:`, `ci:` | No release | `docs: update README example` |

## Releases

Releases are fully automated via release-please:

1. Merge your PR to `main` with conventional commit messages.
2. release-please will open or update a **Release PR** accumulating all changes since the last release, with an updated `CHANGELOG.md`.
3. When you are ready to publish a release, **merge the Release PR**.
4. release-please automatically creates the git tag and GitHub Release.

You never need to manually edit `CHANGELOG.md` for a release or create tags yourself.

## Pull Request Guidelines

- Keep PRs focused — one logical change per PR.
- Reference any related issues in the PR description.
- Ensure all pre-commit hooks pass before requesting review.
- Use conventional commit message format (see above) so release-please can determine the version bump.

## Authors

Module managed by [Zoi](https://github.com/zoitech).

## License

MIT License. See [LICENSE](LICENSE) for full details.
