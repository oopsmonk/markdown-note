#Raspberry Pi Monitor  
Use RRDTool monitor Raspberry Pi, include CPU temperture, Memory usage, Disk I/O, Network I/O...  


##Install  
install packages  

    sudo apt-get install libcairo2-dev libpango1.0-dev libglib2.0-dev libxml2-dev librrd-dev python2.7-dev rrdtool python-rrdtool
    wget https://pypi.python.org/packages/source/p/psutil/psutil-2.1.1.tar.gz
    tar xf psutil-2.1.1.tar.gz
    cd psutil-2.1.1
    sudo python setup.py install

Download or clone rpi-monitor on github  
[https://github.com/oopsmonk/rpi-monitor](https://github.com/oopsmonk/rpi-monitor)  

##Setup Crontab
By defualt, the `cron.log` is disabled in [Raspbian](http://www.raspbian.org/).
To enable it:

    sudo vi /etc/rsyslog.conf

find the line and uncomment it.

    # cron.*                          /var/log/cron.log

Restart `rsyslog` via:

    sudo /etc/init.d/rsyslog restart

Modify `crontab`

    crontab -e

Add schedule as below

    #data collection every 5 minutes
    */5 * * * * /path/to/rpi-monitor/rpi_monitor.py
    #generate daily graph report at 00:01
    1 0 * * * /path/to/rpi-monitor/graphReport.py -1d
    #generate weekly graph report at 00:03 on Monday
    3 0 * * 1 /path/to/rpi-monitor/graphReport.py -1w  

##Report example  
####Raspberry Pi Hardware    
<img src="https://github.com/oopsmonk/markdown-note/raw/master/pictures/20140721-RPi.jpg">  

####CPU Temperture  
__The temperture drop to 44 because I add a fan on CPU.__  
<img src="https://github.com/oopsmonk/markdown-note/raw/master/pictures/20140721-cpuTemp-2d.png">  

####CPU Used Percentage  
<img src="https://github.com/oopsmonk/markdown-note/raw/master/pictures/20140721-cpuUsage-2d.png">  

####PID Count  
<img src="https://github.com/oopsmonk/markdown-note/raw/master/pictures/20140721-PIDs-2d.png">  

####Memory Usage  
<img src="https://github.com/oopsmonk/markdown-note/raw/master/pictures/20140721-memUsage-2d.png">  

####Mount point Usage  
<img src="https://github.com/oopsmonk/markdown-note/raw/master/pictures/20140721-mountPoint-home-2d.png">  

####Mount Point Percentage  
<img src="https://github.com/oopsmonk/markdown-note/raw/master/pictures/20140721-mountPointPercent-2d.png">  

####HDD I/O  
<img src="https://github.com/oopsmonk/markdown-note/raw/master/pictures/20140721-hdd-sda1-2d.png">  

####eth0 I/O  
<img src="https://github.com/oopsmonk/markdown-note/raw/master/pictures/20140721-interface-eth0-2d.png">  

####eth1 I/O  
<img src="https://github.com/oopsmonk/markdown-note/raw/master/pictures/20140721-interface-eth1-2d.png">  


