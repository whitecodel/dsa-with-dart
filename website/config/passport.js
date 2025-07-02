const passport = require("passport");
const GitHubStrategy = require("passport-github2").Strategy;
const User = require("../models/User");

passport.serializeUser((user, done) => {
  done(null, user.id);
});

passport.deserializeUser(async (id, done) => {
  try {
    const user = await User.findById(id);
    done(null, user);
  } catch (err) {
    done(err, null);
  }
});

passport.use(
  new GitHubStrategy(
    {
      clientID: process.env.GITHUB_CLIENT_ID,
      clientSecret: process.env.GITHUB_CLIENT_SECRET,
      callbackURL: process.env.GITHUB_CALLBACK_URL,
    },
    async (accessToken, refreshToken, profile, done) => {
      try {
        // Check if user exists
        let user = await User.findOne({ githubId: profile.id });

        if (user) {
          // Update last login date
          user.lastLogin = Date.now();
          await user.save();
          return done(null, user);
        } else {
          // Create new user
          const newUser = {
            githubId: profile.id,
            username: profile.username,
            avatar: profile.photos?.[0]?.value || "",
            email: profile.emails?.[0]?.value || "",
          };

          user = await User.create(newUser);
          return done(null, user);
        }
      } catch (err) {
        console.error("Error during GitHub authentication:", err);
        return done(err, null);
      }
    }
  )
);

module.exports = passport;
