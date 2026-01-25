-- Comprehensive ignore patterns for Telescope and other file operations
-- Organized by category for maintainability

local M = {}

M.patterns = {
	-- Version control
	"^.git/",
	"^.svn/",
	"^.hg/",
	"^CVS/",

	-- OS generated
	"^.DS_Store",
	"^Thumbs.db",
	".Trashes",
	"ehthumbs.db",
	"desktop.ini",

	-- JavaScript/Node
	"node_modules/",
	"npm-debug.log",
	"yarn-error.log",
	"package-lock.json",
	"yarn.lock",

	-- Python
	"__pycache__/",
	"%.pyc$",
	"%.pyo$",
	"%.pyd$",
	".Python",
	"pip-log.txt",
	"pip-delete-this-directory.txt",
	".venv/",
	"venv/",
	".env",

	-- Rust
	"target/",
	"Cargo.lock",

	-- Go
	"go.sum",

	-- Java
	"%.class$",
	"%.jar$",
	"%.war$",
	"target/",

	-- C/C++
	"%.o$",
	"%.a$",
	"%.so$",
	"%.dylib$",
	"%.exe$",

	-- IDEs and editors
	".vscode/",
	".idea/",
	"%.swp$",
	"%.swo$",
	"*~",

	-- Logs and temporary files
	"%.log$",
	"%.tmp$",
	"%.temp$",
}

return M
