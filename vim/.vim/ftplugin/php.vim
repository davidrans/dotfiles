let g:ale_linters = {
\   'php': ['php', 'phpcs', 'psalm'],
\}

let g:ale_fixers = {
\   'php': ['phpcbf'],
\}

let g:ale_php_phpcs_executable = 'vendor/bin/phpcs'
let g:ale_php_phpcbf_executable = 'vendor/bin/phpcbf'
let g:ale_php_psalm_executable = 'vendor/bin/psalm'
