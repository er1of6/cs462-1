/*
 * GET users listing.
 */

var User = require('./User');

module.exports = {

	getById: function(req, res, next) {
		User.getById(req.params.id, function(err, user) {
			if (err)
				next(err);
			else
				res.send(200, user);
		})
	},

	create: function(req, res, next) {
		User.create(req.body.user, function(err, result) {
			if (err)
				next(err);
			else
				res.send(200, result);
		})

	},

	getAll: function(req, res, next) {
		User.getAll(function(err, users) {
			if (err) {
				next(err);
			} else {
				for (var user in users) {
					var items = users[user].checkins.items;
					if (req.user && req.user.id && req.user.id == user) {
						continue;
					} else if (items.lenght <= 1) {
						continue;
					} else {
						users[user].checkins.items = items.length > 1 ? [items[0]] : items;
					}
				}
				res.send(200, users);
			}
		})
	},

	logout: function(req, res, next) {
		req.logOut();
		res.redirect("/");
	}
};