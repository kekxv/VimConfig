set tags+=~/.vim/tags/cpp_src/tags " 设置tags搜索路径
set wildmode=longest,list " Ex命令自动补全采用bash方式"
syntax on
filetype plugin indent on

" 打开文件列表
map <C-n> :NERDTree<CR>

" pathongen
execute pathogen#infect()

" taglist
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1
let Tlist_Sort_Type="name"

" omnicppcomplete
set completeopt=longest,menu
let OmniCpp_NamespaceSearch = 2 " search namespaces in the current buffer and in included files
let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表
let OmniCpp_MayCompleteScope = 1 " 输入 :: 后自动补全
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]"]"
set nu

map <C-j> :set nu<CR>
map <C-k> :set nonu<CR>
function HeaderPython()
	call setline(1, "# !/usr/bin/env python")
	call append(1, "# -*- coding:utf8 -*-")
	call append(2, "# Crate by Caesar ")
	call append(3, "# Time : " . strftime('%Y-%m-%d %T', localtime()))
	normal G
	normal o
	normal o
endfunction
autocmd bufnewfile *.py call HeaderPython()

function! UpdateCtags()
    let curdir=getcwd()
    while !filereadable("./tags")
        cd ..
        if getcwd() == "/"
            break
        endif
    endwhile
    if filewritable("./tags")
        !ctags -R --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q
        TlistUpdate
    endif
    execute ":cd " . curdir
endfunction

nmap <C-u> :call UpdateCtags()<CR>
