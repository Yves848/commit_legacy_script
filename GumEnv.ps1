# GUM dfault environment variables
# $env:GUM_FILTER_INDICATOR = "▶ "
$env:GUM_FILTER_INDICATOR = "$([char]::ConvertFromUtf32(0xf101)) "
$env:GUM_FILTER_INDICATOR_FOREGROUND = $Theme["green"]
$env:BORDER_FOREGROUND = $($Theme["purple"])
$env:GUM_CHOOSE_SELECTED_BACKGROUND = $Theme["blue"]
$env:GUM_CHOOSE_CURSOR_FOREGROUND = $Theme["brightgreen"]
$env:GUM_CHOOSE_CURSOR_UNDERLINE = 1
$env:GUM_CHOOSE_ITEM_FOREGROUND = $Theme["white"]
$env:GUM_CHOOSE_CURSOR = "$([char]::ConvertFromUtf32(0xf101)) "
$env:GUM_FILTER_CURSOR_TEXT_UNDERLINE = 1 #cursor-text.underline
$env:GUM_CONFIRM_PROMPT_WIDTH = $Host.UI.RawUI.WindowSize.Width -2
$env:GUM_CONFIRM_PROMPT_ALIGN = "center"
$env:GUM_CONFIRM_PROMPT_BORDER = "rounded"
$env:GUM_CONFIRM_PROMPT_BORDER_FOREGROUND = $Theme["purple"]
$env:GUM_CONFIRM_SELECTED_WIDTH = 30
$env:GUM_CONFIRM_UNSELECTED_WIDTH = 30
$env:GUM_CONFIRM_SELECTED_ALIGN = "center"
$env:GUM_CONFIRM_UNSELECTED_ALIGN = "center"
$env:GUM_CONFIRM_SELECTED_BACKGROUND = $Theme["blue"]