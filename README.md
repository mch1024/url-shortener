# url-shortener

## How to run
```
docker compose up
```

Find the id of the api container:
```
docker ps
```

Get the IP of the api container:
```
docker inspect $ID_FROM_ABOVE
```

## Implementation details
- We return errors for invalid requests.
- If API authenticates requests, the unauthorised should always be returned before non-existing to avoid remote enumeration.
- Request to shorten an existing URL return the existing identifier.
- Due to the simple hashing implementation with a very simple collision handling if more than 10 URLs result in the same hash the service will return HTTP 500.
