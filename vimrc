set nu
set hlsearch
hi Search term=standout ctermfg=0 ctermbg=11 guifg=Black guibg=Yellow
hi ModeMsg ctermfg=LightGreen  " cscope 或者 ctags 搜索某变量定义时，列表出的文件名的配色
set ts=4
" set tags=tags   			" 若当前目录中没有tags则到父目录中找
" set autochdir

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, 插件管理tool
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'majutsushi/tagbar' "Tag bar"
" 树型显示目录
Plugin 'scrooloose/nerdtree'
" 自动补全
Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"

" cscope: 建立数据库: cscope -Rbq;
if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=1
	set cst
	set nocsverb
	" add any databse in current directory
	if filereadable("cscope.out")
		cs add cscope.out
	endif
	set csverb

endif

" 如果是<C-@>s 表示ctrl+space+s
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>		" C符号出现的地方
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>		" 定义的地方
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>		" 调用这个函数的函数列表
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>		" 搜索字符串
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>		" egrep 匹配
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>		" 搜索文件
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	" 包含这个文件的文件列表
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>		" 被这个函数调用的函数列表

" Tagbar
"let g:tagbar_width=25
"autocmd BufReadPost *.cpp,*.c,*.h,*.cc,*.cxx,*.S call tagbar#autoopen()

" NetRedTree 树型显示

"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"let NERDTreeWinSize=15
"let NERDTreeShowLineNumbers=1
"let NERDTreeAutoCenter=1
"let NERDTreeShowBookmarks=1

" 按F8按钮，在窗口的左侧出现taglist的窗口,像vc的左侧的workpace
nnoremap <silent> <F8> :TlistToggle<CR><CR>
" :Tlist              调用TagList
let Tlist_Show_One_File=0                    " 只显示当前文件的tags
let Tlist_Exit_OnlyWindow=1                  " 如果Taglist窗口是最后一个窗口则退出Vim
let Tlist_Use_Right_Window=1                 " 在右侧窗口中显示
let Tlist_File_Fold_Auto_Close=1             " 自动折叠


"YouCompleteMe
""配置默认文件路径
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
"打开vim时不再询问是否加载ycm_extra_conf.py配置
let g:ycm_confirm_extra_conf = 0
set completeopt=longest,menu
""自动开启语义补全
let g:ycm_seed_identifiers_with_syntax = 1
"在注释中也开启补全
"let g:ycm_complete_in_comments = 1
"let g:ycm_collect_identifiers_from_comments_and_strings = 0
""字符串中也开启补全
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
"开启基于tag的补全，可以在这之后添加需要的标签路径  
let g:ycm_collect_identifiers_from_tags_files = 1
""开始补全的字符数
let g:ycm_min_num_of_chars_for_completion = 2
"补全后自动关闭预览窗口
let g:ycm_autoclose_preview_window_after_completion = 1
""禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
"离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
""语法关键字补全
let g:ycm_seed_identifiers_with_syntax = 1  
"整合UltiSnips的提示
let g:ycm_use_ultisnips_completer = 1 
""在实现和声明之间跳转,并分屏打开
"let g:ycm_goto_buffer_command = 'horizontal-split'
"nnoremap <Leader>g :YcmCompleter GoTo<CR>
"与syntastic有冲突，建议关闭
""let g:ycm_error_symbol = '>>'
"let g:ycm_warning_symbol = '>>'
"let g:ycm_enable_diagnostic_signs = 0
"let g:ycm_enable_diagnostic_highlighting = 0
"let g:ycm_echo_current_diagnostic = 0
let g:ycm_show_diagnostics_ui = 0   " 不设置此项，vim打开后最左侧会多出一列

" 状态栏
set laststatus=2      " 总是显示状态栏
highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue
" 获取当前路径，将$HOME转化为~
function! CurDir()  
	let curdir = substitute(getcwd(), $HOME, "~", "g")  
	return curdir  
endfunction  

" set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \ \|%=\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ \|\ %{$USER}\ @\ %{hostname()}\

"绝对路径显示文件名：当前行/总行数 列数 总的字符数
set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%] 

" 设置第80列提示线
"set cc=80

set cursorline " 突出显示当前行
