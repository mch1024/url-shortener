# coding=utf8

import flask
from redis import Redis
import os
import hashlib
from base64 import urlsafe_b64encode


app = flask.Flask(__name__)
app.debug = os.getenv('DEBUG') == '1'


DOMAIN = 'https://domain.tld'

IDENTIFIER_LENGTH = 7

MAX_TRIES = 10


@app.errorhandler(400)
def handle_bad_request(error):
	return str(error), 400


@app.route('/api/v1/shorten/<path:url>', methods=['POST'])
def shorten(url):
	redis = Redis(host=os.getenv('REDIS_HOST'), port=os.getenv('REDIS_PORT'))
	digest = hashlib.md5(url.encode('utf-8')).digest()
	source = urlsafe_b64encode(digest).decode('utf-8')
	success = False
	for i in range(MAX_TRIES):
		identifier = source[i:i + IDENTIFIER_LENGTH]
		if redis.get(identifier).decode('utf-8') == url:
			success = True
			break

		if redis.setnx(identifier, url):
			success = True
			break

	if not success:
		return 'Could not shorten URL', 500

	return '{}/{}'.format(DOMAIN, identifier), 200


@app.route('/api/v1/lookup/<identifier>', methods=['GET'])
def lookup(identifier):
	if len(identifier) > IDENTIFIER_LENGTH:
		return 'Invalid identifier', 400

	redis = Redis(host=os.getenv('REDIS_HOST_RO'), port=os.getenv('REDIS_PORT_RO'))
	# There could be a propagation delay if reading from a Redis replica
	value = redis.get(identifier)
	if value is None:
		return 'Invalid identifier', 404

	return value, 200


@app.route('/<identifier>', methods=['GET'])
def redirect(identifier):
	if len(identifier) > IDENTIFIER_LENGTH:
		return 'Invalid identifier {}'.format(len(identifier)), 400

	redis = Redis(host=os.getenv('REDIS_HOST_RO'), port=os.getenv('REDIS_PORT_RO'))
	value = redis.get(identifier)
	if value is None:
		return 'Invalid identifier', 404

	return flask.redirect(value.decode('utf-8'))
