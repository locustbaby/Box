##### AutoClick

```python
#coding:utf-8

import selenium
from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
import time,datetime
import random
import socket

socket.setdefaulttimeout(10)

dcap = dict(DesiredCapabilities.PHANTOMJS)
dcap["phantomjs.page.settings.userAgent"] = (
"Mozilla/5.0 (Linux; Android 5.1.1; Nexus 6 Build/LYZ28E) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.23 Mobile Safari/537.36"
)
dcap["phantomjs.page.settings.User-Agent"] = (
"Mozilla/5.0 (Linux; Android 5.1.1; Nexus 6 Build/LYZ28E) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.23 Mobile Safari/537.36"
)
dcap["User-Agent"] = (
"Mozilla/5.0 (Linux; Android 5.1.1; Nexus 6 Build/LYZ28E) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.23 Mobile Safari/537.36"
)
browser = webdriver.PhantomJS(desired_capabilities=dcap)
browser.get("http://login.html")
# print "one title",browser.title
# print "one url",browser.current_url
# print "one name:",browser.name
# time.sleep(3)
browser.find_element_by_id("username").send_keys('user')
browser.find_element_by_id("password").send_keys('password')
browser.find_element_by_class_name('login-button').click()


while 1:
    try:
        time.sleep(10)
        browser.get('http://zabbix/')
        # buttonlst = browser.find_element_by_xpath('//*[@id="alarmtbody"]')
        # buttonlst = browser.find_element_by_id("alarmtbody")
        browser.refresh()
        time.sleep(0.5)
        buttonlst = browser.find_elements_by_tag_name("button")
        # time.sleep(0.1)
        trnum = (len(buttonlst)-2)/3
        print 'tr num is:',trnum
        for i in range(trnum):
            browser.refresh()
            time.sleep(0.1)
            index = i + 1
            now = datetime.datetime.now()
            print '%s 第%s行'%(now,index)
            id = browser.find_element_by_xpath('//*[@id="alarmtbody"]/tr[%s]/td[2]/div/button[3]'%index)
            text = id.text
            if text == u"响应":
                print 'i am is %s, i will to click'%text
                # time.sleep(random.randint(3,9))
                id.click()
            else:
                first = browser.find_element_by_xpath('//*[@id="alarmtbody"]/tr[1]/td[2]/div/button[3]')
                if first.text == u"响应":
                    break
                print text
    except selenium.common.exceptions.StaleElementReferenceException, e:
        # browser.get('http://zabbix/')
        print "staleelement exception: %s" %str(e)
        pass
    except Exception,e:
        print 'common exception:%s'%str(e)
        pass
browser.quit()
print '退出浏览器'
```



