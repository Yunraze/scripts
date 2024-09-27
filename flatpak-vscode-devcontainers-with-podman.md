# Visual Studio Code (flatpak) + podman + DevContainers

## Preparation

Install Visual Studio Code and the Podman tool:

```sh
flatpak install com.visualstudio.code
flatpak install com.visualstudio.code.tool.podman
```

Make sure you have `podman` installed. I think that `qemu` is a dependency for the next phase.

Initialize the `podman` machine:

```sh
podman machine init
```

Install Flatseal (or manage the permissions in any way you want)

```sh
flatpak install com.github.tchx84.Flatseal
```

With `Flatseal`, find `Visual Studio Code` from the Applications list, and scroll down to **Filesystem** permissions. Assign two new permissions:
 * `/run/podman/podman.sock`
 * `xdg-run/podman`

Then open Visual Studio Code, and find these two settings:
 * **Dev > Containers: Docker Path**: 
   Set this to `/app/tools/podman/bin/podman-remote`

 * **Dev > Containers: Docker Socket Path**:
   Set this to `/run/podman/podman.sock`

## Modifications to `.devcontainer.json`

Typically a `.devcontainer.json` can be as simple as this:

```json
// For format details, see https://aka.ms/devcontainer.json. For config options, see the
// README at: https://github.com/devcontainers/templates/tree/main/src/dotnet
{
	"name": "C# (.NET)",
	// Or use a Dockerfile or Docker Compose file. More info: https://containers.dev/guide/dockerfile
	"image": "mcr.microsoft.com/devcontainers/dotnet:1-8.0-bookworm"
}
```

You need some modifications to the `.devcontainer.json` to make it work with `podman`. Generally most of them use the `vscode` user (at least the Microsoft ones), with `uid=1000` and `gid=1000`.

Put in `runArgs`, `containerUser`, `updateRemoteUserUID`, `workspaceMount` and `workspaceFolder`:

```json
// For format details, see https://aka.ms/devcontainer.json. For config options, see the
// README at: https://github.com/devcontainers/templates/tree/main/src/dotnet
{
	"name": "C# (.NET)",
	// Or use a Dockerfile or Docker Compose file. More info: https://containers.dev/guide/dockerfile
	"image": "mcr.microsoft.com/devcontainers/dotnet:1-8.0-bookworm",

	"runArgs": [
		"--userns=keep-id:uid=1000,gid=1000"
	],
	"containerUser": "vscode",
	"updateRemoteUserUID": true,
	"workspaceMount": "source=${localWorkspaceFolder},target=/workspace,type=bind,Z",
	"workspaceFolder": "/workspace"
}
```

