# Releasing

This add-on is a *local-build* add-on: Home Assistant builds the container on the
device from [`lmgtools/Dockerfile`](lmgtools/Dockerfile), which installs the
[`cuveland/lmgtools`][lmgtools] Python package pinned to a specific git tag.

Two version numbers are involved and they are released together:

- **lmgtools** — the Python package, tagged in the `cuveland/lmgtools` repo
  (e.g. `v0.1.0`). Pinned via `ARG LMGTOOLS_VERSION` in the Dockerfile.
- **add-on** — the `version:` field in [`lmgtools/config.yaml`](lmgtools/config.yaml).
  Home Assistant shows an "Update" button when this is higher than the installed
  version.

## How updates reach users

Home Assistant periodically refreshes the add-on repository and compares
`config.yaml`'s `version:` against the installed version. A higher version makes
the "Update" button appear; updating rebuilds the container, which re-runs the
pinned `pip install`.

Because the Dockerfile pins an exact lmgtools tag, the add-on version maps to
specific code and rebuilds are reproducible. Pushing changes to lmgtools alone
does **not** reach users — you must cut a new tag and bump the add-on version.

## Release steps

1. **Release lmgtools** (only if its code changed)
   - In the `cuveland/lmgtools` repo, bump `version` in `pyproject.toml`.
   - Commit, then tag and push:
     ```bash
     git tag -a vX.Y.Z -m "Release vX.Y.Z"
     git push origin vX.Y.Z
     ```

2. **Pin the add-on to the new lmgtools tag**
   - Update `ARG LMGTOOLS_VERSION=vX.Y.Z` in `lmgtools/Dockerfile`.

3. **Bump the add-on version**
   - Update `version:` in `lmgtools/config.yaml`.
   - Add an entry to `lmgtools/CHANGELOG.md`.

4. **Commit and push**
   ```bash
   git add -A
   git commit -m "Release add-on X.Y.Z (lmgtools vX.Y.Z)"
   git push
   ```

Users will see the update after Home Assistant refreshes the repository (or after
a manual reload via the add-on store's ⋮ menu).

## Local build check

To verify a build before releasing:

```bash
docker build \
  --build-arg BUILD_FROM=ghcr.io/home-assistant/aarch64-base:latest \
  -t lmgtools-test lmgtools/
docker run --rm lmgtools-test powerlog95 --help
```

[lmgtools]: https://github.com/cuveland/lmgtools
