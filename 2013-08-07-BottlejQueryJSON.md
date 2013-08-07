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


[Bottle]: http://bottlepy.org/docs/dev/  
[jQuery Mobile]: http://jquerymobile.com/  

