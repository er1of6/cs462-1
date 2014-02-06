var passport = require('passport')
var FoursquareStrategy = require('passport-foursquare').Strategy

var FOURSQUARE_CLIENT_ID = 'M2LRRAD3323NU1GABHSYIQCE40UYRMADV5QTTGZPAZRUZZKU';
var FOURSQUARE_CLIENT_SECRET = 'CQ3EX1J3TUAK1WIZ4JFUCSPEJX4J5NH4CY5QE14EX3ZV0ZHN'

var User = require('./User');

passport.serializeUser(function(user, done) {
	done(null, user.id);
});

passport.deserializeUser(function(id, done) {
	User.getById(id, done);
});

passport.use(new FoursquareStrategy({
		clientID: FOURSQUARE_CLIENT_ID,
		clientSecret: FOURSQUARE_CLIENT_SECRET,
		callbackURL: "http://localhost:5000/api/login/callback"
	},
	function(accessToken, refreshToken, profile, done) {
		var request = require('request');
		var url = 'https://api.foursquare.com/v2/users/self/checkins?oauth_token=' + accessToken + '&v=20130205'

		request(url, function(error, response, body) {
			if (!error && response.statusCode == 200) {
				var newInfo = JSON.parse(body).response.checkins;
				console.log('new info', JSON.stringify(profile, null, 4));
				profile._json.response.user.checkins = newInfo;
				User.findOrCreate(profile._json.response.user, done);
			}
			else {
				done('error getting checkin data');
			}
		})

	}
));