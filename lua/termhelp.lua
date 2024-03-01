function TermHelp.terminal_insert_callback(lines)
  sanitized_command = table.concat(lines, ';')
  vim.api.nvim_feedkeys('a' .. sanitized_command, '', '')
  if vim.g["termhelp_learn_to_stop_worrying"] then
    print("You have got to be kidding me.")
    -- vim.api.nvim_feedkeys('a' .. sanitized_command, '', '')
  end
end

vim.g["codegpt_commands"] = vim.tbl_extend("force", vim.g["codegpt_commands"] or {}, {
  ["terminal"] = {
    system_message_template = "Chosen answer. Best answer. Portable linux one-liner.", -- TODO test if this helps
    user_message_template = "{{command_args}}. Output only a linux bash command, with no explanations or formatting.",
    callback_type = "custom",
    callback = terminal_insert_callback
  },
  ["terminal_correction"] = {
    system_message_template = "Chosen answer. Best answer. Portable linux one-liner.",
    user_message_template = "I tried this command: ```\n{{text_selection}}```, but it didn't work. {{command_args}}. Output only a corrected linux bash command, with no explanations or formatting.",
    callback_type = "custom",
    callback = terminal_insert_callback
  },
})

vim.api.nvim_create_user_command("TermHelp", function(opts)
    require("codegpt.commands").run_cmd("terminal", table.concat(opts.fargs, " "), "")
end, {range = true, nargs = "*"})

