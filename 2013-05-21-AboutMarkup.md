#About Markup Language
##Markup Language
寫文件或blog最困擾的就是排版, 大略看一下目前較流行的[Markdown][id-md] & [reStructuredText][id-rst], 決定用Markdown來寫, rst給我的感覺就是要再學另一種語言, 雖然強大, 但我只要夠用就好, 必竟都有人用Markdown寫書了 XD.  

[id-md]: http://daringfireball.net/projects/markdown/  
[id-rst]: http://docutils.sourceforge.net/rst.html  

##Markdown Setup  
目前是用Vim + [Pandoc][id-pan]來寫Markdown, 網路上也有[Web editor][id-we], 或是windows平台的[Markdownpad][id-dpad], 但Web用起來不順手, Markdownpad不能跨平台. 用Vim麻煩的是preview, 寫完要手動用[Pandoc][id-pan]轉成html, 之後直接將轉出來的html, 直接貼到blogger.  

一般沒有CSS的用法:  

    $ pandoc README.md -o out.html  

加入CSS依文件的方法是:  

    $ pandoc -c markdown.css README.md -o out.html  

但是會有一個問題, 貼上blogger時會無法正常顯示, 原因在於html裡是這樣寫的: 

    <link rel="stylesheet" href="markdown.css" type="text/css" />  

後來想到了一個workaround, 用`-H`參數將CSS放入Header, 但也不是直接帶入, 需要將一般的CSS file用`style` tag包起來, 如下: 

    <style type="text/css">  
    Your CSS syntax....  
    </style>  

另存成`pandoc-markdown.css`, 如此才是真正的__fully standalone__. 

    $ pandoc -H pandoc-markdown.css README.md -o out.html  

**Note:**  
**如果是用`*.md`做為file extention, 需要在`.vimrc`裡面加入:**  

    autocmd BufRead,BufNewFile *.md set filetype=markdown  

**或是直接在Vim裡面打:**

    :set syntax=markdown

[id-pan]: http://johnmacfarlane.net/pandoc/  
[id-we]: http://joncom.be/experiments/markdown-editor/edit/  
[id-dpad]: http://markdownpad.com/  

##Conclusion  
* 不用煩惱排版的問題, Blogger與Evernote排版不會差太多.
* 可以用Git來做version control 及 backup.  
* 簡潔有力, 語法簡單.  
* Vim也有人做realtime preview的plug-in: [vim-instant-markdown][], 但我覺得沒有即時preview的需求.  
* 圖片使用Markdown語法無法調整大小, 可以使用HTML來放圖片.  

`<img src="http://3.bp.bloGspot.com/-BLhmfBdELH0/UBT3uUd7r5I/AAAAAAAAADw/-rnn2kz5vjY/s220/oops_monk01_120.jpg" width="100">`

<img src="http://3.bp.blogspot.com/-BLhmfBdELH0/UBT3uUd7r5I/AAAAAAAAADw/-rnn2kz5vjY/s220/oops_monk01_120.jpg" width="100">

* 影片也是用HTML, 以TEDTalk為例:  

`<iframe src="http://embed.ted.com/talks/lang/zh-tw/ken_robinson_how_to_escape_education_s_death_valley.html"`  
`width="560" height="315" frameborder="0" scrolling="no" `  
`webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>`

<iframe src="http://embed.ted.com/talks/lang/zh-tw/ken_robinson_how_to_escape_education_s_death_valley.html"
width="560" height="315" frameborder="0" scrolling="no"
webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>

[vim-instant-markdown]: https://github.com/suan/vim-instant-markdown  

