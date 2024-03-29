## GitHub CLI Install Script

_Installs the GitHub CLI. Auto-detects latest version and installs needed
dependencies._

**Script status**: Stable

**OS support**: Debian 9+, Ubuntu 18.04+, and downstream distros.

**Maintainer:** The OpenINF Community

### Syntax

```text
./github-debian.sh [Version]
```

Or as a feature:

```json
"features": {
    "github-cli": "latest"
}
```

| Argument | Feature option | Default  | Description                                                                                                                 |
| -------- | -------------- | -------- | --------------------------------------------------------------------------------------------------------------------------- |
| Version  | `version`      | `latest` | Version of GitHub CLI to install. Use `latest` to install the latest released version. Partial version numbers are allowed. |

### Usage

#### Feature Use

To install these capabilities in your primary dev container, reference it in
`devcontainer.json` as follows:

```json
"features": {
    "github-cli": "latest"
}
```

If you have already built your development container, run the **Rebuild
Container** command from the command palette (<kbd>Ctrl/Cmd</kbd> +
<kbd>Shift</kbd> + <kbd>P</kbd> or <kbd>F1</kbd>) to pick up the change.

#### Script Use

1. Add [`github-debian.sh`](../github-debian.sh) to
   `.devcontainer/library-scripts`

2. Add the following to your `.devcontainer/Dockerfile`:

   ```Dockerfile
   COPY library-scripts/github-debian.sh /tmp/library-scripts/
   RUN apt-get update && bash /tmp/library-scripts/github-debian.sh
   ```

That's it!

<!-- LINK LABEL DEFINITIONS - START -->

<!-- LINK LABEL DEFINITIONS - END -->
