## Ruby Install Script

*Installs Ruby, rbenv.*

**Script status**: Stable

**OS support**: Debian 9+, Ubuntu 18.04+, and downstream distros.

**Maintainer:** The OpenINF Community

### Syntax

```text
./ruby-debian.sh [Ruby version] [Non-root user] [Add rbenv to rc files flag]
```

Or as a feature:

```json
"features": {
    "ruby": "latest"
}
```

| Argument             | Feature option | Default     | Description                                                                                                                                                                                                                                                                 |
|----------------------|----------------|-------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Ruby version         | `version`      | `latest`    | Version of Ruby to install. A value of `none` will skip this step and just install rvm, rbenv, and tools.                                                                                                                                                                   |
| Non-root user        |                | `automatic` | Specifies a user in the container other than root that will use Ruby, rvm, and/or rbenv. A value of `automatic` will cause the script to check for a user called `vscode`, then `node`, `codespace`, and finally a user with a UID of `1000` before falling back to `root`. |
| Add to rc files flag |                | `true`      | A `true`/`false` flag that indicates whether sourcing the rbenv script should be added to `/etc/fish/config.fish`.                                                                                                                                                          |

### Usage

#### Feature Use

To install these capabilities in your primary dev container, reference it in `devcontainer.json` as follows:

```json
"features": {
    "ruby": "latest"
}
```

If you have already built your development container, run the **Rebuild Container** command from the command palette (<kbd>Ctrl/Cmd</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> or <kbd>F1</kbd>) to pick up the change.

#### Script Use

Usage:

1. Add [`ruby-debian.sh`](../ruby-debian.sh) to `.devcontainer/library-scripts`

2. Add the following to your `.devcontainer/Dockerfile`:

    ```Dockerfile
    COPY library-scripts/ruby-debian.sh /tmp/library-scripts/
    RUN apt-get update && bash /tmp/library-scripts/ruby-debian.sh
    ```

That's it!
