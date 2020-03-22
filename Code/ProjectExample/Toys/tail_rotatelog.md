```python
#!/bin/env python3
# coding=utf-8
import os
def tail(self, offset):
    nonecount = 0
    with open(self.filename, 'r') as f:
        f.seek(0, offset)
        while True:
            line = f.readline()
            if not line:
                if nonecount == 0:
                    oldfd = os.stat(filename)
                elif nonecount >= 3 and os.stat(filename) != oldfd:
                    print('BREAK')
                    break
                nonecount = nonecount + 1
                time.sleep(0.1)
                continue
            nonecount = 0
            yield line
```

