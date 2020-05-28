if exists('g:loaded_prettyjson') || &cp
    finish
endif
let g:loaded_prettyjson = 1

"TODO: add global var for options

function! s:pretty_visual()
    let jq_bin = system('which jq')
    if empty(jq_bin)
        echom 'error: could not find jq'
        return 1
    endif
    let redir_buf = ''
    redir => redir_buf
    silent execute "'<,'>w ! ".jq_bin
    redir END
    if redir_buf =~ 'shell returned'
        echom 'error: could not parse json'
        return 1
    endif
    silent execute "'<,'>! ".jq_bin
endfu

function! s:pretty()
    let jq_bin = system('which jq')
    if empty(jq_bin)
        echom 'error: could not find jq'
        return 1
    endif
    let redir_buf = ''
    redir => redir_buf
    silent execute 'w ! '.jq_bin
    redir END
    if redir_buf =~ 'shell returned'
        echom 'error: could not parse json'
        return 1
    endif
    silent execute '%! '.jq_bin
endfu

xnoremap <silent> <Leader>jp :<C-U>call <SID>pretty_visual()<Enter>
nnoremap <silent> <Leader>jp :call <SID>pretty()<Enter>
