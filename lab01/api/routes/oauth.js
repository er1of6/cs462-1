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
		callbackURL: "http://" + "/api/login/callback"
	},
	function(accessToken, refreshToken, profile, done) {
		User.findOrCreate(profile._json.response.user, done);
		
	}
));