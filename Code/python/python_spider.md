##### PY spider

##### urllib

##### requests

```python
requests.get(url, params=params, data=data, headers=headers, cookies=cookies)
requests.post(url, data=data, headers=headers, cookies=cookies)
```

##### beautifulsoup

```python
soup = BeautifulSoup(res.text, 'lxml')
tables = soup.findAll('tr')
resource = [[re.findall(r'\d+', i.findAll('td')[l_index].getText()) for i in tables[1:]] for l_index in [4, 5, 6, 8, 10, 11, 12]]
```

Xpath

scrapy

##### selenium

```python
import selenium
from selenium import webdriver
from selenium.webdriver.support.select import Select
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.keys import Keys

chrome_options = Options()
chrome_options.add_argument('--headless')
chrome_options.add_argument('--disable-gpu')
driver = webdriver.Chrome(executable_path='/usr/local/bin/chromedriver',chrome_options=chrome_options)
```

phamtjs

