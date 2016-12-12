set nocompatible " 非 vi 兼容模式
syntax enable " 色彩高亮
set background=dark
colorscheme solarized

set number " 显示行数
set ruler " 显示当前位置于右下角
set backspace=2 " 设置 backspace 模式为标准
set showmatch " 显示配对括号
set incsearch " 增量查找
set hlsearch
set si " 智能缩进
set tabstop=4 " Tab 宽度
set softtabstop=4 " Tab 宽度
set shiftwidth=4 " Tab 宽度
set expandtab " 输入的 tab(\t) 均不保持为 tab 而转换为空格
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,sjis,euc-kr,ucs-2le,latin1 "字符编码
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L] " 状态栏格式
set laststatus=2 " 一直显示状态栏
set encoding=utf8

if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"auto Header
function HeaderCreate()
    if expand("%:e") == "py" 
        call setline(1, "#! /usr/bin/env python")
    elseif expand("%:e") == "sh"
        call setline(1, "#! /bin/bash")
    endif
    call append(1, "# -*- coding: utf-8 -*-")
    call append(2, "")
    call append(3, "# *************************************************************")
    call append(4, "#       Filename @  " . expand("%:t"))
    call append(5, "#         Author @  Fengchi")
    call append(6, "#    Create date @  " . strftime('%Y-%m-%d %T', localtime()))
    call append(7, "#  Last Modified @  " . strftime('%Y-%m-%d %T', localtime()))
    call append(8, "#    Description @  ") 
    call append(9, "# *************************************************************")
    normal G
    normal o
    normal o
endfunc 

function ChangeModified()
    call cursor(8, 1)
    if search("Last Modified") != 0
        let line = line('.')
        call setline(line, '#  Last Modified @  ' . strftime('%Y-%m-%d %T', localtime()))
    endif
endfunc

map <F4> :call HeaderCreate()<CR>:10<CR>o

autocmd bufnewfile *.py,*.sh call HeaderCreate()
autocmd FileWritePre,BufWritePre *.py,*sh ks|call ChangeModified() |'s
