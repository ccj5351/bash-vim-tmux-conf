" Vundle is short for Vim bundle and is a Vim plugin manager.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" install YouCompleteMe with Vundle
Plugin 'Valloric/YouCompleteMe'
let g:ycm_server_python_interpreter = '/usr/bin/python2.7'
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" 
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
if(has("win32") || has("win95") || has("win64") || has("win16")) "判定当前操作系统类型
    let g:iswindows=1
else
    let g:iswindows=0
endif
autocmd BufEnter * lcd %:p:h

set nocompatible "不要vim模仿vi模式，建议设置，否则会有很多不兼容的问题

if has("autocmd")
    filetype plugin indent on "根据文件进行缩进
    augroup vimrcEx
        au!
        autocmd FileType text setlocal textwidth=78
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \ exe "normal! g`\"" |
                    \ endif
    augroup END
else
    "智能缩进，相应的有cindent，官方说autoindent可以支持各种文件的缩进，但是效果会比只支持C/C++的cindent效果会差一点，但笔者并没有看出来
    set autoindent " always set autoindenting on 
endif " has("autocmd")
set tabstop=2 "让一个tab等于2个空格
set shiftwidth=2
set vb t_vb=
set nowrap "不自动换行
set hlsearch "高亮显示结果
set incsearch "在输入要搜索的文字时，vim会实时匹配
set backspace=indent,eol,start whichwrap+=<,>,[,] "允许退格键的使用
if(g:iswindows==1) "允许鼠标的使用
    "防止linux终端下无法拷贝
    if has('mouse')
        set mouse=a
    endif
    au GUIEnter * simalt ~x
endif


" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on


" 配色方案
if has('gui_running')
	    set background=light
else
			set background=dark
endif
" set background=dark
" set background=black
set t_Co=256 " force vim to use 256 colors
let g:solarized_termcolors = 256
colorscheme solarized
"colorscheme molokai
"colorscheme phd

" 禁止光标闪烁
set gcr=a:block-blinkon0
" 禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
" 禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T

" 设置 gvim 显示字体
set guifont=YaHei_Consolas_Hybrid:h11.5

" 禁止折行
set nowrap

map <F12> :call Do_CsTag()<CR>
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>
function Do_CsTag()
    let dir = getcwd()
    if filereadable("tags")
        if(g:iswindows==1)
            let tagsdeleted=delete(dir."\\"."tags")
        else
            let tagsdeleted=delete("./"."tags")
        endif
        if(tagsdeleted!=0)
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            return
        endif
    endif
    if has("cscope")
        silent! execute "cs kill -1"
    endif
    if filereadable("cscope.files")
        if(g:iswindows==1)
            let csfilesdeleted=delete(dir."\\"."cscope.files")
        else
            let csfilesdeleted=delete("./"."cscope.files")
        endif
        if(csfilesdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
            return
        endif
    endif
    if filereadable("cscope.out")
        if(g:iswindows==1)
            let csoutdeleted=delete(dir."\\"."cscope.out")
        else
            let csoutdeleted=delete("./"."cscope.out")
        endif
        if(csoutdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
            return
        endif
    endif
    if(executable('ctags'))
        "silent! execute "!ctags -R --c-types=+p --fields=+S *"
        silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
    endif
    if(executable('cscope') && has("cscope") )
        if(g:iswindows!=1)
            silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"
        else
            silent! execute "!dir /s/b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
        endif
        silent! execute "!cscope -b"
        execute "normal :"
        if filereadable("cscope.out")
            execute "cs add cscope.out"
        endif
    endif
endfunction

"进行Tlist的设置
""TlistUpdate可以更新tags
map <F3> :silent! Tlist<CR> "按下F3就可以呼出了
let Tlist_Ctags_Cmd='ctags' "因为我们放在环境变量里，所以可以直接执行
let Tlist_Use_Right_Window=1 "让窗口显示在右边，0的话就是显示在左边
let Tlist_Show_One_File=0 "让taglist可以同时展示多个文件的函数列表，如果想只有1个，设置为1
let Tlist_File_Fold_Auto_Close=1 "非当前文件，函数列表折叠隐藏
let Tlist_Exit_OnlyWindow=1 "当taglist是最后一个分割窗口时，自动推出vim
let Tlist_Process_File_Always=0 "是否一直处理tags.1:处理;0:不处理。不是一直实时更新tags，因为没有必要
let Tlist_Inc_Winwidth=0

set nocp
filetype plugin on
set nu

" Add Customized Header To Your C File Automatically
" defines the template file. This indicates that for *.c file, 
autocmd bufnewfile *.c,*.cpp,*.hpp so ~/.vim/c_header.txt
" search for the pattern “@file:” from the 1st line to 10th line. If
" found, it will write the current filename in that line.
autocmd bufnewfile *.c,*.cpp,*.hpp exe "1," . 8 . "g/@file:.*/s//@file: " .expand("%")
"  update the Creation Date field
autocmd bufnewfile *.c,*.cpp,*.hpp exe "1," . 8 . "g/@creation date:.*/s//@creation date: " .strftime("%d-%m-%Y")
" mark the current cursor position before updating
autocmd Bufwritepre,filewritepre *.c,*.cpp,*.hpp execute "normal ma"
" update the Last Modified field with the current date and time when you save
" the file
autocmd Bufwritepre,filewritepre *.c,*.cpp,*.hpp exe "1," . 8 . "g/@last modified:.*/s/@last modified:.*/@last modified: " .strftime("%c")
" restore the cursor position back to its previous position.
autocmd bufwritepost,filewritepost *.c,*.cpp,*.hpp execute "normal `a"


" Add Customized Header To Your C File Automatically
" defines the template file. This indicates that for *.c file, 
autocmd bufnewfile *.py so ~/.vim/py_header.txt
" search for the pattern “@file:” from the 1st line to 10th line. If
" found, it will write the current filename in that line.
autocmd bufnewfile *.py exe "1," . 8 . "g/@file:.*/s//@file: " .expand("%")
"  update the Creation Date field
autocmd bufnewfile *.py exe "1," . 8 . "g/@creation date:.*/s//@creation date: " .strftime("%d-%m-%Y")
" mark the current cursor position before updating
autocmd Bufwritepre,filewritepre *.py execute "normal ma"
" update the Last Modified field with the current date and time when you save
" the file
autocmd Bufwritepre,filewritepre *.py exe "1," . 8 . "g/@last modified:.*/s/@last modified:.*/@last modified: " .strftime("%c")
" restore the cursor position back to its previous position.
autocmd bufwritepost,filewritepost *.py execute "normal `a"

" set tags using Ctags.
set tags=./tags,tags;$HOME
" This enables mouse in all modes.
set mouse=a
