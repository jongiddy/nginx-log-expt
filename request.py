import requests

for i in range(10000):
    if i % 100 == 0:
        print(i)
    r = requests.get('http://localhost:8080/')
    r.raise_for_status()
