return {
	{
		'stevearc/conform.nvim',
		opts = {
			formatters_by_ft = {
				-- Для C/C++ используем clang-format
				c = { "clang_format" },
				cpp = { "clang_format" },
			},

			-- Автоматическое форматирование при сохранении файла (не обязательно)
			format_on_save = false,
		},
	}
}
