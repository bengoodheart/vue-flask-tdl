# vue-flask-tdl
Connects with a cloud hosted API created with flask. 

## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```

### Docker
```
docker build . webapp-test
docker run -v ${PWD}:/app -v /app/node_modules -p 8081:8080 --rm webapp-test
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).
