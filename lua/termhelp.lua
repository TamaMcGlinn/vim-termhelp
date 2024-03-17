local TermHelp = {}

function TermHelp.sanitize_command(lines)
  if lines[1]:match('^```') then
    -- remove first and last elements
    local newLines = {}
    for i = 2, #lines-1 do
        sanitized_line = (lines[i]:gsub('^$ *', ''))
        table.insert(newLines, sanitized_line)
    end
    lines = newLines
  end
  single_line = table.concat(lines, ';')
  return single_line
end

function TermHelp.terminal_insert_callback(lines)
  sanitized_command = TermHelp.sanitize_command(lines)
  vim.api.nvim_feedkeys('a' .. sanitized_command, '', '')
  if vim.g["termhelp_learn_to_stop_worrying"] then
    vim.api.nvim_feedkeys('\n', 'n', true)
  end
end

vim.g["codegpt_commands"] = vim.tbl_extend("force", vim.g["codegpt_commands"] or {}, {
  ["terminal"] = {
    system_message_template = "Chosen answer. Best answer. Portable linux one-liner.", -- TODO test if this helps
    user_message_template = "{{command_args}}. Output only a linux bash command, with no explanations or formatting.",
    callback_type = "custom",
    callback = TermHelp.terminal_insert_callback
  },
  ["terminal_correction"] = {
    system_message_template = "Chosen answer. Best answer. Portable linux one-liner.",
    user_message_template = "I tried this command: ```\n{{text_selection}}```, but it didn't work. {{command_args}}. Output only a corrected linux bash command, with no explanations or formatting.",
    callback_type = "custom",
    callback = TermHelp.terminal_insert_callback
  },
})

vim.api.nvim_create_user_command("TermHelp", function(opts)
    require("codegpt.commands").run_cmd("terminal", table.concat(opts.fargs, " "), "")
end, {range = true, nargs = "*"})

return TermHelp
