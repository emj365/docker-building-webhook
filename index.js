var express = require('express');
var bodyParser = require('body-parser')
var shell = require('shelljs');
var crypto = require('crypto');

var app = express();

var SECERT=process.env['SECERT']
var REPO_URL=process.env['REPO_URL']
var REF=process.env['REF']

// Calculate the X-Hub-Signature header value.
function getSignature(buf) {
  var hmac = crypto.createHmac("sha1", SECERT);
  hmac.update(buf, "utf-8");
  return "sha1=" + hmac.digest("hex");
}

// Verify function compatible with body-parser to retrieve the request payload.
// Read more: https://github.com/expressjs/body-parser#verify
function verifyRequest(req, res, buf, encoding) {
  var expected = req.headers['x-hub-signature'];
  var calculated = getSignature(buf);
  console.log("X-Hub-Signature:", expected, "Content:", "-" + buf.toString('utf8') + "-");
  if (expected !== calculated) {
    throw new Error("Invalid signature.");
  } else {
    console.log("Valid signature!");
  }
}

// Express error-handling middleware function.
// Read more: http://expressjs.com/en/guide/error-handling.html
function abortOnError(err, req, res, next) {
  if (err) {
    console.log(err);
    res.status(400).send({ error: "Invalid signature." });
  } else {
    next();
  }
}

app.use(bodyParser.json({ verify: verifyRequest }));

app.use(abortOnError);

app.post('/ping', function (req, res) {
  res.send('ok');
});

app.post('/', function (req, res) {
  res.send('ok');
  if (req.body.repository.url === REPO_URL && req.body.ref === REF) {
    shell.exec('./exec.sh')
  }
});

app.listen(80, function () {
  console.log('app listening on port 80!');
});

