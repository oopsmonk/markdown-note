#JSON exmaple using jQuery Mobile & Bottle.  

[Bottle][] is a fast, simple and lightweight WSGI micro web-framework for Python.  
[jQuery Mobile][] base on jQuery for mobile device.  
[jQuery vs. jQuery Mobile vs. jQuery UI](http://stackoverflow.com/questions/6636388/jquery-vs-jquery-mobile-vs-jquery-ui)  

##Install bottle:  

```bash
$ sudo apt-get install python-setuptools
$ easy_install bottle
```

##Building a simple server use bottle  

```python
#!/usr/bin/env python
from bottle import route, static_file, debug, run, get, redirect
from bottle import post, request
import os, inspect, json

#enable bottle debug
debug(True)

# WebApp route path
routePath = '/bottle'
# get directory of WebApp (bottleJQuery.py's dir)
rootPath = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))

@route(routePath)
def rootHome():
    return redirect(routePath+'/index.html')

@route(routePath + '/<filename:re:.*\.html>')
def html_file(filename):
    return static_file(filename, root=rootPath)

@get(routePath + '/jsontest')
def testJsonGET():
#    print dict(request.headers) #for debug header
    return {"id":2,"name":"Jone"}

@post(routePath + '/jsontest')
def testJsonPost():
#    print dict(request.headers) #for debug header
    data = request.json
    print data 
    if data == None:
        return json.dumps({'Status':"Failed!"})
    else:
        return json.dumps({'Status':"Success!"})

run(host='localhost', port=8080, reloader=True)

```  

GET request test:  

```bash
$ curl -i -X GET http://localhost:8080/bottle/jsontest  

HTTP/1.0 200 OK  
Date: Wed, 07 Aug 2013 09:02:32 GMT  
Server: WSGIServer/0.1 Python/2.7.3  
Content-Length: 25  
Content-Type: application/json  

{"id": 2, "name": "Jone"}  
```

bottle debug message:  

```
localhost - - [07/Aug/2013 17:02:32] "GET /bottle/jsontest HTTP/1.1" 200 25
```

POST request test:  

```bash
$ curl -X POST -H "Content-Type: application/json" -d '{"name":"OopsMonk","pwd":"abc"}' http://localhost:8080/bottle/jsontest  

{"Status": "Success!"}  
```  

bottle debug message:  

```
{u'pwd': u'abc', u'name': u'OopsMonk'}  
localhost - - [07/Aug/2013 17:08:23] "POST /bottle/jsontest HTTP/1.1" 200 22  
```

##Building simple web page  

```html
<!DOCTYPE html>
<html>
<head>
<title>Bottle & jQuery Mobile</title>

<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.css" />
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>

</head>
 
<body>
<h3>This is a example using jQuery Mobile and pyhton bottle fromwork. </h3>
<div data-role="controlgroup" data-type="horizontal">
    <a href="#" id="btnGetJSON" data-role="button">jQuery.getJSON</a>
    <a href="#" id="btnPOSTJSON" data-role="button">jQuery.post</a>
    <a href="#" id="btnAJAXGet" data-role="button">jQuery.ajax GET</a>
    <a href="#" id="btnAJAXPOST" data-role="button">jQuery.ajax POST</a>
</div>

<script>
    //button action 
    $("#btnGetJSON").click(function(){
        $.getJSON("jsontest", function(data){
            $.each(data, function(index, value){
                alert("index: " + index + " , value: "+ value);
            });
        });
    });
    
    $("#btnPOSTJSON").click(function(){
        alert("Not easy work on bottle !!!");
        /*
        It's not work, send JSON via jQuery.post().
        because the content-Type is not 'application/json',
        The content type is fixed :
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
        that's a problem on bottle.request.json.

        $.post(
        "jsontest", 
        JSON.stringify({"id":3, "name":"Ping"}), 
        function(ret_data, st){
            alert("Server return : " + ret_data + " , status : " + st); 
        },
        'json'
        );
        */
    });
    
    $("#btnAJAXGet").click(function(){
        $.ajax
        ({
            url: 'jsontest',
            success: function(data){
                $.each(data, function(index, value){
                    alert("index: " + index + " , value: "+ value);
                });
            },
            /*
            if dataType not set, the Accept in request header is:
            'Accept': '* / *'
            dataType = json :
            'Accept': 'application/json, text/javascript, * /*; q=0.01'
            */
            dataType: 'json'
        });
    });
    
    $("#btnAJAXPOST").click(function(){
        var post_data = {"id":3, "name":"Ping"};
        $.ajax
        ({
            type: 'POST',
            url: 'jsontest',
            data:JSON.stringify(post_data),
            contentType: "application/json; charset=utf-8",
            dataType: 'json',
            success: function(data){
                $.each(data, function(index, value){
                    alert("index: " + index + " , value: "+ value);
                });
            }
        });
    });
</script>
</body>
</html>
```

[Bottle]: http://bottlepy.org/docs/dev/  
[jQuery Mobile]: http://jquerymobile.com/  

