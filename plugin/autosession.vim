" Plugin Name: vim-autosession
" Maintainer: Simon Poirier <simpoir@gmail.com>
" Version: 0.1
" Last Modified: Tue, 17 Oct 2017 11:09:01 -0400
" Description: Autoload/save sessions

if !exists('g:autosession_file')
  let g:autosession_file = 'Session.vim'
endif

if !exists('g:autosession_minutes')
  let g:autosession_minutes=5
endif

function! SaveSession()
  if filewritable(g:autosession_file) && (argc() == 0) && g:session_loaded
    execute 'mksession! ' . g:autosession_file
    call timer_start(60000*g:autosession_minutes, 'SaveSession')
  endif
endfunction

function! LoadSession()
  if filereadable(g:autosession_file) && (argc() == 0)
    execute 'source ' . g:autosession_file
    let g:session_loaded = 1
  endif
endfunction

augroup 0
  autocmd VimEnter * nested call LoadSession()
  autocmd VimLeave * call SaveSession()
augroup END
call timer_start(60000*g:autosession_minutes, 'SaveSession')
