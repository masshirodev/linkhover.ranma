-- linkhover: rest the pointer on a link and see where it goes.
--
-- A tooltip under the link: its host, then the whole address (wrapped, up to
-- two lines), and the keys that act on it (leader o labels every link on the
-- screen: its label copies it, in capitals opens it). An OSC 8 link, whose
-- text says something else than where it points, shows the difference.
--
-- Needs the mouse on (the `mouse` setting, "click" or "hover"). ranma's
-- plugin API: https://github.com/masshirodev/ranma/blob/main/doc/CONFIG.md ("Tooltips").

ranma.option("linkhover.enabled", {
  type = "bool", default = true,
  name = "Link tooltips", desc = "A tooltip with where a link goes when the pointer rests on it.",
})

local WIDTH = 72

local function host_of(url)
  return url:match("^%a[%w+.-]*://([^/?#]+)") or url:match("^mailto:(.+)$")
end

-- By characters, not bytes: a cut inside one hands ranma invalid UTF-8,
-- which fails the whole hook.
local function wrap(s, width, max)
  local chars = {}
  for _, c in utf8.codes(s) do chars[#chars + 1] = utf8.char(c) end
  local out = {}
  local i = 1
  while i <= #chars and #out < max do
    local last = i + width - 1
    if #out == max - 1 and last < #chars then
      out[#out + 1] = table.concat(chars, "", i, last - 1) .. "…"
    else
      out[#out + 1] = table.concat(chars, "", i, math.min(last, #chars))
    end
    i = last + 1
  end
  return out
end

ranma.on("hover", function(e)
  if not ranma.get("linkhover.enabled") then return end
  local p = ranma.pane(e.pane)
  local l = p and p:link_at(e.line, e.col)
  if not l then return ranma.tooltip(nil) end
  local lines = wrap(l.url, WIDTH, 2)
  -- The text the link is drawn as, when it is not the address itself. From
  -- ranma, not a slice of the row: columns count cells, not bytes.
  local shown = l.text or ""
  if shown ~= "" and shown ~= l.url:sub(1, #shown) then
    table.insert(lines, 1, { { "shown as ", "dim" }, { shown } })
  end
  ranma.tooltip({ pane = e.pane, line = l.line, col = l.col, span = l.span }, {
    title = host_of(l.url),
    lines = { table.unpack(lines, 1, 3) },
    keys = { { "leader o", "label, copy or open" } },
  })
end)
