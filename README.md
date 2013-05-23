Markdown-note
=============

Notes write in Pandoc's Markdown syntax.  

##Genarate HTML file:  

* Standalone HTML

    `$ pandoc -H pandoc-markdown.css -s README.md -o out.html`  

* Include an automatically generated table of contents  

    `$ pandoc -H pandoc-markdown.css --toc -s README.md -o out.html`  
