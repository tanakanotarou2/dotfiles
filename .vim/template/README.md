## sonictemplate.vim のテンプレート配置場所 

https://github.com/mattn/vim-sonictemplate

### テンプレートの配置先設定

```
let g:sonictemplate_vim_template_dir = [
\ '$HOME/.vim/template'
\]
```

###  テンプレートファイルの作り方

> テンプレートファイル
> テンプレートファイルは次の場所に配置する。
> 
> <template_dir>/<言語名>/[種類]-[テンプレート名].[拡張子]
> 
> テンプレートの種類は3つある。
> 
> base: 何も書いていないときに呼び出される。
> file: バッファ名とテンプレート名が一致するときに呼び出される。
> snip: なにか呼び出されているとsnipが呼び出される。

引用元: https://medium.com/@ch1aki/sonictemplate-vim%E3%82%92%E5%B0%8E%E5%85%A5%E3%81%97%E3%81%9F-b8a2d521d87c
