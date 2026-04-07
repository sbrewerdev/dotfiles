local ls = require "luasnip"

local extend_decorator = require "luasnip.util.extend_decorator"

local s = extend_decorator.apply(ls.s, {})

local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local snippets = {}

table.insert(
    snippets,
    s({
        trig = "daily",
        name = "Daily Note Template",
        desc = "Template for daily work log",
    }, {
        t {
            "---",
            "tags:",
            "    - 📅Daily",
            "---",
            "",
            "# DAILY NOTE - ",
        },
        i(1, "todays date"),
        t {
            "",
            "***",
            "## Work Log",
            "",
            "### Tasks/Tickets:",
            "",
            "### Meetings:",
            "",
            "### Miscellaneous:",
            "",
            "## Notes",
            "- ",
        },
    })
)

ls.add_snippets("markdown", snippets)
