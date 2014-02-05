/*
 * GET users listing.
 */
var fs = require('fs');
var FILE_NAME = 'data/users.json'

var openFile = function(cb) {
	fs.readFile(FILE_NAME, 'utf8', function(err, data) {
		cb(err, JSON.parse(data));
	});
};

var saveFile = function(data, cb) {
	fs.writeFile(FILE_NAME, JSON.stringify(data, null, 4), cb);
}

module.exports = {

	getById: function(id, cb) {
		openFile(function(err, users) {
			console.log(users);
			if (err) {
				cb(err)
			} else if (users[id] != undefined) {
				cb(null, users[id]);
			} else {
				cb(null, {});
			}
		})
	},

	getAll: function(cb) {
		openFile(function(err, users) {
			if (err) {
				cb(err)
			} else {
				cb(null, users)
			}
		})
	},

	create: function(user, cb) {
		console.log('Creating User: ' + JSON.stringify(user));
		openFile(function(err, users) {
			if (err) {
				cb(err)
			} else if (users[user.id] != undefined) {
				cb(null, {
					error: true,
					message: 'Already Exists'
				});
			} else {
				users[user.id] = user;
				saveFile(users, function(err) {
					cb(err, user);
				});
			}
		})
	},

	findOrCreate: function(user, cb) {
		module.exports.getById(user.id, function(err, response) {
			console.log(response);
			if (err) {
				cb(err)
			} else if (Object.keys(response).length == 0) {
				module.exports.create(user, cb);
			} else {
				cb(null, response);
			}
		})
	}


};