# linkhover.ranma

A plugin for [ranma](https://github.com/masshirodev/ranma), the terminal tiling window manager: rest the pointer on a link and see where it goes.

## Install

With [hako](https://github.com/masshirodev/hako.ranma), in `~/.config/ranma/lua/plugins/linkhover.lua`:

```lua
return { "masshirodev/linkhover.ranma" }
```

Or by hand, as ranma loads any package under `pack/*/start/`:

```sh
git clone https://github.com/masshirodev/linkhover.ranma ~/.config/ranma/pack/plugins/start/linkhover.ranma
```

Needs: The mouse on in ranma (`mouse = "click"` or `"hover"`).

## What it does

```text
A tooltip under the link: its host, then the whole address (wrapped, up to
two lines), and the keys that act on it (leader o labels every link on the
screen: its label copies it, in capitals opens it; with openpath.ranma
loaded, ctrl+click opens the link and ctrl+right-click lists what to copy).
An OSC 8 link, whose text says something else than where it points, shows
the difference.

Needs the mouse on (the `mouse` setting, "click" or "hover"). ranma's
plugin API: https://github.com/masshirodev/ranma/blob/main/doc/CONFIG.md ("Tooltips").
```

## Options

In ranma's settings panel under `linkhover`, or with hako's `opts` (`{ "masshirodev/linkhover.ranma", opts = { ... } }`), or `ranma.set { linkhover = { ... } }`.

| Option | Default | |
| --- | --- | --- |
| `linkhover.enabled` | `true` | A tooltip with where a link goes when the pointer rests on it. |

## License

MIT or Apache-2.0, as ranma.
