#NodeJS Socket.io pairing boilerplate

Description:
Simple example of connecting a mobile device to a desktop with a unique session. 

Tags: nodejs, socketio

 
##Install

- install nodejs (nodejs.org)

```
  $ cd path/to/project/root
  $ npm install
```


##Compile Project & Start Server

```
  $ cd path/to/project/root
  $ coffee --compile --bare --output public/js/ coffee/*.coffee
  $ node app.js
```

### open in your desktop browser:
```
  http://yourlocalip:3000/
```

### open in your mobile browser via QRcode or manually (sessionID provided by desktop):
```
  http://yourlocalip:3000/mobile.html?sessionID=XXXX
```