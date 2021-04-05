# Colors
function orange
    set_color -o ffb86c
end

function yellow
    set_color -o b58900
end

function red
    set_color -o ff5555
end

function cyan
    set_color -o 8be9fd
end

function white
    set_color -o f8f8f2
end

function green
    set_color -o 50fa7b
end

function pink
    set_color -o ff79c6
end

function purple
    set_color -o bd93f9
end

function dark_purple
    set_color -o 6272a4
end

function grey
    set_color -o 44475a
end

function off
    set_color -o normal
end

# Git
function git::is_repo
	test -d .git; or command git rev-parse --git-dir >/dev/null ^/dev/null
end

function git::branch_name
	git::is_repo; and begin
		command git symbolic-ref --short HEAD ^/dev/null;
		or command git show-ref --head -s --abbrev | head -n1 ^/dev/null
	end
end

function git::is_dirty
	git::is_repo; and not command git diff --no-ext-diff --quiet --exit-code
end

function git::is_staged
	git::is_repo; and begin
		not command git diff --cached --no-ext-diff --quiet --exit-code
	end
end

function git::is_stashed
	git::is_repo; and begin
		command git rev-parse --verify --quiet refs/stash >/dev/null
	end
end

# Kubernetes

function k8s::current_context
    command kubectl config current-context
end

function k8s::current_namespace
    command kubectl config view --minify -o jsonpath='{.contexts[0].context.namespace}'
end

# Terraform

# Test whether this is a terraform directory by finding .tf files
function terraform::directory
	command find . -name '*.tf' >/dev/null ^/dev/null -maxdepth 0
end

function terraform::workspace
	terraform::directory; and begin
		test -e .terraform/environment
	end
end

function _load_sushi
	# do nothing
end
