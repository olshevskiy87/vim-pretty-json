if exists('g:loaded_prettyjson') || &cp || v:version < 800
    finish
endif
let g:loaded_prettyjson = 1

let g:prettyjson_jq_options = trim(get(g:, 'prettyjson_jq_options', ''))

function! s:pretty_visual()
    let cmd = s:prepare_jq_command()
    if empty(cmd)
        echoerr 'error: could not prepare jq command'
        return 1
    endif

    let redir_buf = ''
    redir => redir_buf
    silent execute "'<,'>w ! ".cmd
    redir END
    if redir_buf =~ 'shell returned'
        echoerr 'error: could not parse json'
        return 1
    endif
    silent execute "'<,'>! ".cmd
    if v:shell_error == '0'
        set syntax=json
    endif
endfu

function! s:pretty()
    let cmd = s:prepare_jq_command()
    if empty(cmd)
        echoerr 'error: could not prepare jq command'
        return 1
    endif

    let redir_buf = ''
    redir => redir_buf
    silent execute 'w ! '.cmd
    redir END
    if redir_buf =~ 'shell returned'
        echoerr 'error: could not parse json'
        return 1
    endif
    silent execute '%! '.cmd
    if v:shell_error == '0'
        set syntax=json
    endif
endfu

function! s:prepare_jq_command()
    let cmd = trim(system('which jq'))
    if empty(cmd)
        echoerr 'error: could not find jq binary'
        return ''
    endif
    if !empty(g:prettyjson_jq_options)
        let cmd .= ' '.g:prettyjson_jq_options
    endif
    let cmd .= ' .'
    return cmd
endfu

xnoremap <silent> <Leader>jp :<C-U>call <SID>pretty_visual()<Enter>
nnoremap <silent> <Leader>jp :call <SID>pretty()<Enter>
