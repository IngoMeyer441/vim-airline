" MIT License. Copyright (c) 2017 YoungHoon Rhiu.
" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8

if !exists('g:XkbSwitchLib')
  finish
endif

function! airline#extensions#xkblayout#status()
  let l:keyboard_layout = libcall(g:XkbSwitchLib, 'Xkb_Switch_getXkbLayout', '')
  let l:keyboard_layout = split(l:keyboard_layout, '\.')[-1]

  let l:short_codes = {
    \ '2SetKorean': 'KR',
    \ 'Chinese': 'CN',
    \ 'Japanese': 'JP',
    \ 'USwithumlauts': 'US',
    \ 'us_with_umlauts': 'US',
    \ 'German': 'DE',
    \ }

  " remove extra information in parentheses
  let l:keyboard_layout = substitute(l:keyboard_layout, '\v\(.*\)', '', '')

  " replace keyboard layout with a short version
  if has_key(l:short_codes, l:keyboard_layout)
    let l:keyboard_layout = l:short_codes[l:keyboard_layout]
  endif

  " transform layout name to uppercase
  let l:keyboard_layout = toupper(l:keyboard_layout)

  return l:keyboard_layout
endfunction

function! airline#extensions#xkblayout#init(ext)
  call airline#parts#define_function('xkblayout', 'airline#extensions#xkblayout#status')
endfunction

