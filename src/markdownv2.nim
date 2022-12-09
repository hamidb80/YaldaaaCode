import std/strformat


type StyledString* = distinct string
template `$`*(ss: StyledString): untyped = ss.string
template ss*(s: string): untyped = StyledString s

func bold*(s: string): StyledString = ss fmt"*{s}*"
func italic*(s: string): StyledString = ss fmt"_{s}_"
func underline*(s: string): StyledString = ss fmt"__{s}__"
func link*(url, label: string): StyledString = ss fmt"[{url}]({label})"
func spoiler*(s: string): StyledString = ss fmt"||{s}||"
func inlineCode*(s: string): StyledString = ss fmt"`{s}`"
func codeBlock*(s: string): StyledString = ss fmt "```\n{s}\n```"

func escapeMarkdownV2*(s: string): string =
    result = newStringOfCap(s.len * 2)
    for c in s:
        if c in "_*[]()~`>#+-=|{}.!\\":
            result.add '\\'

        result.add c
